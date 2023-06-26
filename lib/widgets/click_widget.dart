import 'package:flutter/material.dart';

class ClickWidget extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final Duration debounceDuration;

  const ClickWidget({
    Key? key,
    required this.child,
    required this.onTap,
    this.debounceDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _ClickWidgetState createState() => _ClickWidgetState();
}

class _ClickWidgetState extends State<ClickWidget> {
  bool _isClickable = true;

  void _onTap() {
    if (_isClickable) {
      setState(() {
        _isClickable = false;
      });
      widget.onTap();

      Future.delayed(widget.debounceDuration, () {
        if (mounted) {
          setState(() {
            _isClickable = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: widget.child,
    );
  }
}
