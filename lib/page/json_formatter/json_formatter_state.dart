import 'package:flutter/material.dart';

/// @description:
/// @author
/// @date: 2023-06-26 11:56:52
class JsonFormatterState {
  late TextEditingController leftController;
  late TextEditingController rightController;
  late FocusNode? leftFocusNode;
  late FocusNode? rightFocusNode;
  JsonFormatterState() {
    ///Initialize variables
    leftController = TextEditingController();
    rightController = TextEditingController();
    leftFocusNode = FocusNode();
    rightFocusNode = FocusNode();
  }
}
