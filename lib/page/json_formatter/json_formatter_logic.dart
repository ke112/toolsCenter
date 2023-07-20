import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macdemo/utils/common_tools.dart';

import 'json_formatter_state.dart';

/// @description:
/// @author
/// @date: 2023-06-26 11:56:52
class JsonFormatterLogic extends GetxController {
  final state = JsonFormatterState();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    state.leftController.dispose();
    state.rightController.dispose();
  }

  //左侧转换
  void transform() {
    state.rightController.text = state.leftController.text;
    update();
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
