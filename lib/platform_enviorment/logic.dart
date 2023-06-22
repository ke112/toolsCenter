import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:process_run/shell.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class PlatformEnviormentLogic extends GetxController {
  final PlatformEnviormentState state = PlatformEnviormentState();

  TimerUtil? timerUtil; //定时任务test
  late String localPath; //本地的路径

  @override
  void onReady() async {
    super.onReady();
    localPath = Get.arguments['path'];
    //获取保存的记录
    getHistory();
  }

  @override
  void onClose() {
    super.onClose();
    //控制器销毁时,就可以把计时器关闭了
    stopTimer();
  }

  /*获取保存的记录*/
  getHistory() async {
    await SharedPreferences.getInstance().then((value) {
      int platform = value.getInt('platform') as int;
      int enviorment = value.getInt('enviorment') as int;
      state.platform = platform; //获取历史选择平台
      state.enviorment = enviorment; //获取历史选择环境
      debugPrint("${state.platform}");
      debugPrint("${state.enviorment}");

      debugPrint(localPath);
      List<String>? historyTimes = value.getStringList(localPath); //获取历史打包时长
      if (historyTimes?.isNotEmpty == true) {
        int total = 0;
        for (String obj in historyTimes!) {
          total += int.parse(obj);
          debugPrint("获取到历史的打包时间 ${showTimerDes(int.parse(obj))}");
        }
        state.averagePackingTime = (total / historyTimes.length).truncate();
        showTimerDes(state.averagePackingTime);
      } else {
        debugPrint("暂无记录");
      }
      update();
    });
  }

  //开始计时器监听
  obserTimer() {
    timerUtil?.setOnTimerTickCallback((int value) {
      state.actualPackingTime = value;
      showTimerDes(value);
      update();
    });
  }

  /*总的时间显示的方法*/
  commonTimerDes() {
    return state.isArchiveing
        ? '本次打包耗时 ${showTimerDes(state.actualPackingTime)} ${showParkingPercent()}'
        : state.packingTimeThisTime > 0
            ? '上次打包耗时 ${showTimerDes(state.packingTimeThisTime)}'
            : state.averagePackingTime > 0
                ? '平均打包耗时 ${showTimerDes(state.averagePackingTime)}'
                : '暂无记录';
  }

  /*展示大概的进度百分比*/
  String showParkingPercent() {
    if (state.averagePackingTime == 0) {
      return "";
    } else {
      double value = 0;
      double v = state.actualPackingTime / state.averagePackingTime;
      if (v >= 1.0) {
        value = 0.9999;
      } else {
        value = v;
      }
      return "预估完成 ${(value * 100).toStringAsFixed(2)}%";
    }
  }

  /*处理秒数转成描述*/
  showTimerDes(int value) {
    // debugPrint(value);
    int minuter = value ~/ 60;
    int second = value % 60;
    String minuterStr = '';
    String secondStr = '';
    if (minuter < 10) {
      minuterStr = '0' + minuter.toString();
    } else {
      minuterStr = minuter.toString();
    }
    if (second < 10) {
      secondStr = '0' + second.toString();
    } else {
      secondStr = second.toString();
    }
    if (value >= 60) {
      return '$minuterStr:$secondStr';
    } else {
      return '00:$secondStr';
    }
  }

  /*计时器开始/创建*/
  startTimer() {
    stopTimer();
    timerUtil ??= TimerUtil(mInterval: 1000, mTotalTime: 1000 * 60 * 60 * 24);
    obserTimer();
    timerUtil?.startTimer();
  }

  /*计时器停止/销毁*/
  stopTimer() {
    if (timerUtil != null) {
      timerUtil?.cancel();
    }
  }

  /*选中平台事件*/
  updatePlatform(int index) async {
    state.platform = index;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('platform', index);
    update();
  }

  /*选中环境事件*/
  updateEnviorment(int index) async {
    state.enviorment = index;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('enviorment', index);
    update();
  }

  /*判断是否可以开始打包*/
  bool judgeEnable() {
    if (state.platform != -1 && state.enviorment != -1) {
      return true;
    } else {
      return false;
    }
  }

  /*开始打包*/
  runShell() async {
    if (judgeEnable() == false || state.isArchiveing == true) {
      return;
    }
    var shell = Shell();
    debugPrint('-----getx传过来参数------ ${localPath}');
    String platform = (state.platform + 1).toString();
    String enviorment = (state.enviorment + 1).toString();

    debugPrint(platform);
    debugPrint(enviorment);

    //更新打包按钮的状态
    state.isArchiveing = true;
    state.packingTimeThisTime = 0;
    update();

    startTimer(); //开启计时器
    // SmartDialog.showLoading(msg: '正在打包...');

    String shellPath = '';
    if (kDebugMode == true) {
      shellPath = '/Users/ke/Desktop/macdemo/lib/platform_enviorment/dabao.sh';
    } else {
      shellPath = '/Applications/macdemo/lib/platform_enviorment/dabao.sh';
    }
    String shellCommand = '''
    sh $shellPath $localPath $platform $enviorment 1
    ''';
    debugPrint('shellCommand: $shellCommand');
    /*开始执行脚本*/
    await shell.run(shellCommand).then((value) async {
      debugPrint(value.toString());
      // SmartDialog.dismiss();
      // //恢复打包按钮的状态
      // state.isArchiveing = false;
      // state.PackingTimeThisTime = state.actualPackingTime;
      // update();
      // //打包完成,销毁计时器
      // stopTimer();
      // //记录历史打包事件
      // SharedPreferences pref = await SharedPreferences.getInstance();
      // List<String>? his = pref.getStringList(localPath);
      // if (his?.isNotEmpty == true) {
      //   his!.add(state.PackingTimeThisTime.toString());
      //   pref.setStringList(localPath, his);
      // } else {
      //   List<String> temp = [state.PackingTimeThisTime.toString()];
      //   pref.setStringList(localPath, temp);
      // }
      // // //跳转打包成功界面
      // // Get.to(
      // //   () => ArchiveResultPage(),
      // // );
      // Get.back();
    });

    // await Future.delayed(const Duration(seconds: 5)).then((value) {
    //   SmartDialog.dismiss();
    //   //恢复打包按钮的状态
    //   state.isArchiveing = false;
    //   state.PackingTimeThisTime = state.actualPackingTime;
    //   update();
    //   //打包完成,销毁计时器
    //   stopTimer();
    //   //跳转打包成功界面
    //   Get.to(
    //     () => ArchiveResultPage(),
    //   );
    // });
  }
}
