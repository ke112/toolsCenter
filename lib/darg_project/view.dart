import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:macdemo/hoc_process/view.dart';
import 'logic.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:cross_file/cross_file.dart';
import 'package:macdemo/platform_enviorment/view.dart';

class DargProjectPage extends StatefulWidget {
  @override
  State<DargProjectPage> createState() => _DargProjectPageState();
}

class _DargProjectPageState extends State<DargProjectPage> {
  final logic = Get.put(DargProjectLogic());

  final state = Get.find<DargProjectLogic>().state;

  final List<XFile> _list = [];
  List<String> content = [
    "1.自动打安卓/iOS包\n2.目前只支持纯flutter的项目打包\n3.如果同时拖入多个项目,默认只识别第一个",
    "1.自动拉取Git代码,如果无日志不提交\n2.解决了有新代码拉取时,自动合并成一个主干分支\n3.如果同时拖入多个项目,默认只识别第一个"
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      buildDropTarget(context, 0, content),
      Container(color: Colors.blue.withOpacity(0.4), width: 1),
      buildDropTarget(context, 1, content)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mac功能集锦'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets,
      ),
    );
  }

  /*接受拖入项目的widget*/
  DropTarget buildDropTarget(BuildContext context, int type, List<String> content) {
    return DropTarget(
      onDragDone: (detail) {
        _list.clear();
        for (var i = 0; i < detail.files.length; i++) {
          if (i == 0) {
            XFile file = detail.files[i];
            _list.add(file);
            print('拖动完成 : ' + file.path);
            if (type == 0) {
              Get.to(() => PlatformEnviormentPage(), arguments: {'path': file.path});
            } else {
              Get.to(() => HocProcessPage(), arguments: {'path': file.path});
            }
            return;
          }
        }
        // setState(() {});
      },
      onDragEntered: (detail) {
        // print('进入区域');
        setState(() {
          if (type == 0) {
            state.draggingAdhoc = true;
          } else {
            state.draggingGit = true;
          }
        });
      },
      onDragExited: (detail) {
        // print('离开区域');
        setState(() {
          if (type == 0) {
            state.draggingAdhoc = false;
          } else {
            state.draggingGit = false;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / (content.length) - 1,
        color: (type == 0 ? state.draggingAdhoc : state.draggingGit) ? Colors.blue.withOpacity(0.4) : Colors.transparent,
        child: Text(content[type]),
      ),
    );
  }
}
