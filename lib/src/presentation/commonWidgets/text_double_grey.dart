import 'package:flutter/material.dart';
import 'package:flutter_skilleos/src/utils/color_constants.dart';

class TextDoubleGrey extends StatelessWidget {
  const TextDoubleGrey(
      {Key? key, required this.firstValue, required this.secondValue})
      : super(key: key);

  final String firstValue;
  final String secondValue;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      style: TextStyle(color: ColorConstants.darkGrey),
      children: <TextSpan>[
        TextSpan(text: firstValue),
        TextSpan(
            text: secondValue,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ));
  }
}
