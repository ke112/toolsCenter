import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HocProcessPage extends StatelessWidget {
  final logic = Get.put(HocProcessLogic());
  final state = Get.find<HocProcessLogic>().state;

  VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('上传代码'),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              child: const Text('提交'),
              onTap: () async {
                logic.startGit();
              },
            ),
          ))
        ],
      ),
      body: GetBuilder<HocProcessLogic>(builder: (logic) {
        return Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: state.textController,
            focusNode: FocusNode(),
            decoration: InputDecoration(
              hintText: "请输入提交描述,不可为空",
              hintStyle: TextStyle(
                // color: ColorManager.colorCCCCCC,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: const UnderlineInputBorder(
                // 不是焦点的时候颜色
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: const UnderlineInputBorder(
                // 焦点集中的时候颜色
                borderSide: BorderSide(color: Colors.white70),
              ),
            ),
            // onSubmitted: (v) {
            // //监听点了搜索
            // },
            style: TextStyle(
              // color: ColorManager.color2A2A2A,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            keyboardType: TextInputType.text,
            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(11), //限制输入的个数
            //   FilteringTextInputFormatter.allow(RegExp("[0-9]")), //只允许输入数字
            // ],
            textInputAction: TextInputAction.done,
            maxLines: 1,
          ),
        );
      }),
    );
  }
}
