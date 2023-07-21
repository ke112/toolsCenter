import 'dart:io';

import 'package:get/get.dart';
import 'package:macdemo/utils/common_tools.dart';
import 'package:macdemo/utils/shell_manager.dart';

import 'heic_transform_page_state.dart';

/// @description:
/// @author
/// @date: 2023-07-21 23:48:38
class HeicTransformPageLogic extends GetxController {
  final state = HeicTransformPageState();

  //转换图片
  void transform() async {
    if (state.drogPath?.isEmpty ?? false || state.drogPath == null) {
      CommonTools.showToast('请先拖入图片路径');
      return;
    }
    String? result = await ShellManager().runScript('${Directory.current.path}/lib/page/heic_transform_page/heic.sh',
        args: [(state.drogPath ?? ''), state.selected, '${state.isRemoveOrigin ? 1 : 0}']);
    CommonTools.showToast('转换完成');
  }
}
