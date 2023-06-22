import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:macdemo/hoc_process/view.dart';
import 'package:macdemo/platform_enviorment/view.dart';
import 'package:macdemo/utils/click_widget.dart';
import 'package:macdemo/widgets/drop_target_widget.dart';

import 'function_list_logic.dart';
import 'function_list_state.dart';

/// @description:
/// @author
/// @date: 2023-06-19 19:44:35
class FunctionListPage extends StatelessWidget {
  final FunctionListLogic logic = Get.put(FunctionListLogic());
  final FunctionListState state = Get.find<FunctionListLogic>().state;

  FunctionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mac功能',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF6A350),
            height: 1.0,
          ),
        ),
      ),
      body: GetBuilder<FunctionListLogic>(
        builder: (controller) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    FunctionModel itemModel = state.dataList[index];
                    String title = itemModel.title;
                    return ClickWidget(
                      onTap: () {
                        state.currentIndex = index;
                        logic.update();
                      },
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 10, right: 5, top: 0, bottom: 0),
                        margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: const Color(0xFF999999)),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(title)),
                            SizedBox(
                              width: 30,
                              child: Visibility(
                                visible: state.currentIndex == index,
                                child: const Icon(Icons.check),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                      child: Text(
                        state.tips,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFF6A350),
                          height: 1.0,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.35,
                      child: DropTargetWidget(
                        callback: (path) {
                          debugPrint('拖入的文件路径: $path');
                          state.currentDragPath = path;
                          ontapEvent();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void ontapEvent() {
    if (state.currentIndex == -1) {
      SmartDialog.showToast('请先选择左侧功能');
      return;
    }
    switch (state.currentIndex) {
      case 0:
        {
          Get.to(() => PlatformEnviormentPage(), arguments: {'path': state.currentDragPath});
        }
        break;
      case 1:
        {
          Get.to(() => HocProcessPage(), arguments: {'path': state.currentDragPath});
        }
        break;
      default:
        break;
    }
    debugPrint('响应了');
  }
}
