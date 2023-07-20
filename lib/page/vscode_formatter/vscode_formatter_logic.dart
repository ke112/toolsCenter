import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:macdemo/utils/common_tools.dart';
import 'package:macdemo/utils/shared_pref.dart';
import 'package:macdemo/utils/shell_manager.dart';

import 'vscode_formatter_state.dart';

/// @description:
/// @author
/// @date: 2023-07-19 14:33:37
class VScodeFormatterLogic extends GetxController {
  final state = VScodeFormatterState();

  @override
  void onReady() async {
    super.onReady();
    state.isAutoCopy = await SPTool().getBoolForkey('isAutoCopy');
    update();
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('销毁了');
    state.leftController.dispose();
    state.rightController.dispose();
  }

  //左侧格式化
  void formatJson() async {
    if (state.leftController.text.isEmpty) {
      CommonTools.showToast('请先输入代码');
      return;
    }
    String result = await ShellManager()
        .run2('${Directory.current.path}/lib/page/vscode_formatter/t.sh', params: [(state.leftController.text), '2']);
    state.rightController.text = result;
    update();
    if (state.isAutoCopy) {
      copy();
    }
  }

  //左侧转换
  void transform() async {
    if (state.leftController.text.isEmpty) {
      CommonTools.showToast('请先输入代码');
      return;
    }
    String result = await ShellManager()
        .run2('${Directory.current.path}/lib/page/vscode_formatter/t.sh', params: [(state.leftController.text)]);
    state.rightController.text = result;
    update();
    if (state.isAutoCopy) {
      copy();
    }
  }

  //右侧复制
  void copy() {
    if (state.rightController.text.isEmpty) {
      CommonTools.showToast('请先转换');
      return;
    }
    CommonTools.copy(state.rightController.text);
  }
}
