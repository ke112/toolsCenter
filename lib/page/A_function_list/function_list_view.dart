import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macdemo/page/heic_transform_page/heic_transform_page_view.dart';
import 'package:macdemo/page/hoc_process/view.dart';
import 'package:macdemo/page/json_formatter/json_formatter_view.dart';
import 'package:macdemo/page/platform_enviorment/view.dart';
import 'package:macdemo/page/vscode_formatter/vscode_formatter_view.dart';
import 'package:macdemo/utils/common_tools.dart';
import 'package:macdemo/utils/shell_manager.dart';
import 'package:macdemo/widgets/click_widget.dart';
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
          'Mac',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        '以下功能需要选择后,拖拽项目使用',
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.dragFuncList.length,
                        itemBuilder: (BuildContext context, int index) {
                          FunctionModel itemModel = state.dragFuncList[index];
                          String title = itemModel.title;
                          return ClickWidget(
                            onTap: () {
                              debugPrint('点击了功能列表 $index');
                              state.currentIndex = index;
                              logic.update();
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 40,
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
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
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        '以下功能可以单击直接使用',
                      ),
                    ),
                    Wrap(
                      children: state.singleFuncList.map((element) {
                        String title = element.title;
                        return ClickWidget(
                          onTap: () {
                            handleSingleEvent(element);
                          },
                          child: Container(
                            // constraints: const BoxConstraints(
                            //   minHeight: 50,
                            // ),
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                            margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5, color: const Color(0xFF999999)),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Text(title),
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                      child: Stack(
                        children: [
                          DropTargetWidget(
                            callback: (path) {
                              state.currentDragPath = path;
                              handleDargEvent();
                            },
                          ),
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
                            ),
                          ),
                        ],
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

  //处理拖拽项目功能事件
  void handleDargEvent() async {
    if (state.currentIndex == -1) {
      CommonTools.showToast('请先选择左侧功能');
      return;
    }
    bool hasGit = await ShellManager().isGitRepository(state.currentDragPath);
    if (!hasGit) return;
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
  }

  //处理单独点击功能事件
  void handleSingleEvent(FunctionModel model) {
    switch (model.index) {
      case 10001:
        Get.to(() => JsonFormatterPage(), arguments: {"title": model.title});
        break;
      case 10002:
        Get.to(() => HeicTransformPagePage(), arguments: {"title": model.title});
        break;
      case 10003:
        Get.to(() => VScodeFormatterPage(), arguments: {"title": model.title});
        break;
      default:
        break;
    }
  }
}
