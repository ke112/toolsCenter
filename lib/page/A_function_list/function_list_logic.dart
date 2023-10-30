import 'dart:io';

import 'package:get/get.dart';

import 'function_list_state.dart';

/// @description:
/// @author
/// @date: 2023-06-19 19:44:35
class FunctionListLogic extends GetxController {
  final state = FunctionListState();

  @override
  void onReady() {
    super.onReady();
    int index = Platform.version.indexOf('(stable)');
    state.version = Platform.version.substring(0,index);
    update();
  }
}
