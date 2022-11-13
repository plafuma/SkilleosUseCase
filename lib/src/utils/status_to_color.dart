import 'package:flutter/material.dart';

extension StatusToColor on String {
  Color toColor() {
    if (toLowerCase() == "alive") {
      return Colors.green;
    } else if (toLowerCase() == "dead") {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}
