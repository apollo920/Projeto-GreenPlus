import 'package:flutter/cupertino.dart';

extension IconParsing on String {
    IconData toIcon() {
      return IconData(int.parse(this), fontFamily: 'MaterialIcons');
    }
}