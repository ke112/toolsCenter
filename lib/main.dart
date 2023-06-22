/*
 * @Author: zhangzhihua
 * @Date: 2022-03-15 09:50:45
 * @LastEditors: zhangzhihua
 * @LastEditTime: 2022-10-24 17:30:26
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:macdemo/function_list/function_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FunctionListPage(),
      // home: ArchiveResultPage(),
      debugShowCheckedModeBanner: false,
      // 文字提示
      // here
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
    );
  }
}
