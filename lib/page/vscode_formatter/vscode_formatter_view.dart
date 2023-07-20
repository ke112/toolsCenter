import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macdemo/utils/shared_pref.dart';
import 'package:macdemo/widgets/click_widget.dart';
import 'package:macdemo/widgets/item_widget.dart';

import 'vscode_formatter_logic.dart';
import 'vscode_formatter_state.dart';

/// @description:
/// @author
/// @date: 2023-07-19 14:33:37
class VScodeFormatterPage extends StatelessWidget {
  final VScodeFormatterLogic logic = Get.put(VScodeFormatterLogic());
  final VScodeFormatterState state = Get.find<VScodeFormatterLogic>().state;

  VScodeFormatterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VScodeFormatterLogic>(
      builder: (_) {
        return Scaffold(
          appBar: appBarWidget(),
          body: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: inputWidget(true),
                ),
                Container(width: 0.5, color: const Color(0xFFE5E4E3)),
                Expanded(
                  flex: 1,
                  child: inputWidget(false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      title: Text(Get.arguments['title'] ?? ''),
      actions: [
        Row(
          children: <Widget>[
            const Text(
              '转换完自动复制',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFFF6A350), height: 1.0),
            ),
            Transform.scale(
              scale: 0.9,
              child: CupertinoSwitch(
                value: state.isAutoCopy, // 后台返回开关状态
                activeColor: Colors.green,
                trackColor: const Color(0xFFE5E5E5),
                onChanged: (bool value) {
                  state.isAutoCopy = !state.isAutoCopy;
                  logic.update();
                  SPTool().setBoolForKey(isAutoCopy, value);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget inputWidget(bool left) {
    return Stack(
      children: [
        ClickWidget(
          onTap: () {
            if (left) state.leftFocusNode?.requestFocus();
            if (!left) state.rightFocusNode?.requestFocus();
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // height: 40,
            // alignment: Alignment.center,
            child: TextField(
              controller: left ? state.leftController : state.rightController,
              focusNode: left ? state.leftFocusNode : state.rightFocusNode,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: 1000,
              // inputFormatters: [
              //   LengthLimitingTextInputFormatter(11),
              //   // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              // ],
              style: const TextStyle(
                textBaseline: TextBaseline.alphabetic,
                color: Color(0xFF2A2A2A),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: left ? '请输入代码' : '待转换',
                hintStyle: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              onSubmitted: (v) {},
              onChanged: (v) {},
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: left
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButtonWidget(
                      title: '格式化对齐',
                      callback: () {
                        logic.formatJson();
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButtonWidget(
                      title: '转换代码块',
                      callback: () {
                        logic.transform();
                      },
                    )
                  ],
                )
              : TextButtonWidget(
                  title: '复制',
                  callback: () {
                    logic.copy();
                  },
                ),
        )
      ],
    );
  }
}
