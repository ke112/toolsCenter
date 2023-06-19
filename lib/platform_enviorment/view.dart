import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:macdemo/utils/comment.dart';
import 'logic.dart';

class PlatformEnviormentPage extends StatelessWidget {
  final logic = Get.put(PlatformEnviormentLogic());
  final state = Get.find<PlatformEnviormentLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('选择配置'),
          leading: GestureDetector(
            child: const Icon(Icons.close),
            onTap: () {
              Get.back();
            },
          ),
        ),
        body: GetBuilder<PlatformEnviormentLogic>(builder: (logic) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '请选择要打包的平台',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Container(
                    // color: Colors.lightBlue,
                    width: 200.w,
                    height: 24.w,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.platformArr.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 10.w);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          String value = state.platformArr[index];
                          return htButton(
                            title: value,
                            width: (value.length * 4 + 20).w,
                            height: 24.w,
                            backgroundColor: index == state.platform
                                ? state.selectColor
                                : state.unselectColor,
                            onPressed: () {
                              logic.updatePlatform(index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    '请选择要打包的环境',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Container(
                    // color: Colors.lightBlue,
                    width: 200.w,
                    height: 24.w,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.enviormentArr.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 10.w);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          String value = state.enviormentArr[index];
                          return htButton(
                            title: value,
                            width: (value.length * 4 + 20).w,
                            height: 24.w,
                            backgroundColor: index == state.enviorment
                                ? state.selectColor
                                : state.unselectColor,
                            onPressed: () {
                              logic.updateEnviorment(index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text(
                    '选择完毕,点击以下按钮开始打包',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      htButton(
                        title: state.isArchiveing ? "正在打包" : "开始打包",
                        width: 50.w,
                        height: 24.w,
                        backgroundColor: state.isArchiveing
                            ? Colors.deepOrange
                            : logic.judgeEnable()
                                ? state.selectColor
                                : state.unselectColor,
                        onPressed: () {
                          logic.runShell();
                        },
                      ),
                      SizedBox(height: 5.w),
                      Text(
                        logic.commonTimerDes(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
