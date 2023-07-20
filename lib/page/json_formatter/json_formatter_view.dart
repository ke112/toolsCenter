import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macdemo/widgets/click_widget.dart';
import 'package:macdemo/widgets/item_widget.dart';

import 'json_formatter_logic.dart';
import 'json_formatter_state.dart';

/// @description:
/// @author
/// @date: 2023-06-26 11:56:52
class JsonFormatterPage extends StatelessWidget {
  JsonFormatterPage({Key? key}) : super(key: key);
  final JsonFormatterLogic logic = Get.put(JsonFormatterLogic());
  final JsonFormatterState state = Get.find<JsonFormatterLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['title'] ?? ''),
      ),
      body: GetBuilder<JsonFormatterLogic>(
        builder: (_) {
          return Container(
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
          );
        },
      ),
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
                hintText: left ? '请输入json' : '待转换',
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
              ? TextButtonWidget(
                  title: '转换',
                  callback: () {
                    logic.transform();
                  },
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
