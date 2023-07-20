import 'package:flutter/material.dart';
import 'package:macdemo/widgets/click_widget.dart';

class TextButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const TextButtonWidget({super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ClickWidget(
      onTap: () {
        callback.call();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFFF6A350),
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
