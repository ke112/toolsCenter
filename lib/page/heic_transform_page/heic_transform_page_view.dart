import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macdemo/widgets/drop_target_widget.dart';
import 'package:macdemo/widgets/item_widget.dart';

import 'heic_transform_page_logic.dart';
import 'heic_transform_page_state.dart';

/// @description:
/// @author
/// @date: 2023-07-21 23:48:38
class HeicTransformPagePage extends StatelessWidget {
  final HeicTransformPageLogic logic = Get.put(HeicTransformPageLogic());
  final HeicTransformPageState state = Get.find<HeicTransformPageLogic>().state;

  HeicTransformPagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeicTransformPageLogic>(
      builder: (_) {
        return Scaffold(
          appBar: appBarWidget(),
          body: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: DropTargetWidget(
                    callback: (path) {
                      state.drogPath = path;
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              '是否移除原图',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFFF6A350), height: 1.0),
                            ),
                            Transform.scale(
                              scale: 0.9,
                              child: CupertinoSwitch(
                                value: state.isRemoveOrigin, // 后台返回开关状态
                                activeColor: Colors.green,
                                trackColor: const Color(0xFFE5E5E5),
                                onChanged: (bool value) {
                                  state.isRemoveOrigin = !state.isRemoveOrigin;
                                  logic.update();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '提示:勾选了移除原图,不会创建新文件夹,直接替换',
                          style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          for (var option in state.options)
                            RadioListTile(
                              title: Text(option),
                              value: option,
                              groupValue: state.selected,
                              onChanged: (value) {
                                state.selected = value ?? '';
                                logic.update();
                              },
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: TextButtonWidget(
                      title: '转换',
                      callback: () {
                        logic.transform();
                      },
                    ),
                  ),
                )
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
    );
  }
}
