import 'dart:ui';

import 'package:flutter/material.dart';

class PlatformEnviormentState {
  Color unselectColor = Colors.grey; //选中颜色
  Color selectColor = Colors.blue; //未选中颜色
  int platform = -1; //选择平台标记 0 ios 1 android (已做了本地的选择存储)
  int enviorment = -1; //选择环境标记 0正式 1灰度 2测试 3开发 (已做了本地的选择存储)
  int averagePackingTime = 0; //历史平均打包时长 (已做了本地的选择存储)
  int packingTimeThisTime = 0; //本次的打包时长
  int actualPackingTime = 0; //实时在变的打包时长的秒数
  List platformArr = ['iOS', 'Android']; //需要打包的平台
  List enviormentArr = ['正式', '灰度', '测试', '开发']; //需要打包的环境
  bool isArchiveing = false; //正在打包
  PlatformEnviormentState() {
    ///Initialize variables
  }
}
