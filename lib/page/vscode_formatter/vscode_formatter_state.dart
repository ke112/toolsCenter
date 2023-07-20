import 'package:flutter/material.dart';

/// @description:
/// @author
/// @date: 2023-07-19 14:33:37
class VScodeFormatterState {
  late TextEditingController leftController;
  late TextEditingController rightController;
  late FocusNode? leftFocusNode;
  late FocusNode? rightFocusNode;
  bool isAutoCopy = true; //是否自动复制
  VScodeFormatterState() {
    ///Initialize variables
    leftController = TextEditingController();
    rightController = TextEditingController();
    leftFocusNode = FocusNode();
    rightFocusNode = FocusNode();
  }
}
