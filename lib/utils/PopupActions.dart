import 'package:flutter/services.dart';

class PopupActions {
  static clipboard(String text) {
    print(text);
    Clipboard.setData(ClipboardData(text: '$text'));
  }
}
