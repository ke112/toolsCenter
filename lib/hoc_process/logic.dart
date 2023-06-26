import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:macdemo/utils/shell_manager.dart';

import 'state.dart';

class HocProcessLogic extends GetxController {
  final HocProcessState state = HocProcessState();

  late String localPath; //本地的路径

  @override
  void onReady() async {
    super.onReady();
    localPath = Get.arguments['path'];
    runShell();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /*开始提交*/
  void startGit() async {
    debugPrint(state.textController.text);
    SmartDialog.showLoading(msg: '正在处理...');
    runShell();
  }

  void runShell() async {
    String appPath = '';
    if (kDebugMode == true) {
      appPath = '/Users/ke/Desktop/macdemo/lib/hoc_process/888.sh';
    } else {
      appPath = '/Applications/macdemo/lib/hoc_process/888.sh';
    }
    /*开始执行脚本*/
    await ShellManager().run('''
    sh $appPath $localPath ${state.textController.text}
    ''').then((value) async {
      SmartDialog.dismiss();
      if (state.textController.text.isNotEmpty) {
        SmartDialog.showToast('拉取新代码,提交完成');
      } else {
        SmartDialog.showToast('拉取新代码完成');
      }
      // Get.back();
    });
  }
}
