import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CommonTools {
  /// 复制文字到粘贴板
  static copy(String str) {
    showToast('已复制');
    Clipboard.setData(ClipboardData(text: str));
    HapticFeedback.heavyImpact();
  }

  /// 文字提示
  static showToast(String str) {
    SmartDialog.showToast(str);
  }
}
