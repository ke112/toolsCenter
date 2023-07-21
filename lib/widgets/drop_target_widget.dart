import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

typedef SuccessCallback = void Function(String path);

class DropTargetWidget extends StatefulWidget {
  final SuccessCallback callback;
  const DropTargetWidget({super.key, required this.callback});

  @override
  State<DropTargetWidget> createState() => _DropTargetWidgetState();
}

class _DropTargetWidgetState extends State<DropTargetWidget> {
  final List<XFile> _list = [];
  bool isDragging = false; //是否拖拽到区域内
  String content = ''; //拖拽后的路径

  @override
  Widget build(BuildContext context) {
    return buildDropTarget(context);
  }

  /*接受拖入项目的widget*/
  DropTarget buildDropTarget(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) {
        _list.clear();
        for (var i = 0; i < detail.files.length; i++) {
          if (i == 0) {
            XFile file = detail.files[i];
            _list.add(file);
            widget.callback.call(file.path);
            content = file.path;
            if (mounted) setState(() {});
            return;
          }
        }
        // setState(() {});
      },
      onDragEntered: (detail) {
        // debugPrint('进入区域');
        setState(() {
          isDragging = true;
        });
      },
      onDragExited: (detail) {
        // debugPrint('离开区域');
        setState(() {
          isDragging = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height,
        color: isDragging ? Colors.blue.withOpacity(0.4) : Colors.grey.withOpacity(0.2),
        child: Text(content.isNotEmpty ? content : '请拖入到此处'),
      ),
    );
  }
}
