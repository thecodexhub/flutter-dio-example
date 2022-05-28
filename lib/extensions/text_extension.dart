import 'package:flutter/material.dart';

extension TextExtension on Text {
  Text fontSize(double fontSize) {
    Text newWidget = Text(
      data!,
      style: style == null
          ? TextStyle(fontSize: fontSize)
          : style?.copyWith(fontSize: fontSize),
    );
    return newWidget;
  }

  Text bold([FontWeight fontWeight = FontWeight.w500]) {
    Text newWidget = Text(
      data!,
      style: style == null
          ? TextStyle(fontWeight: fontWeight)
          : style?.copyWith(fontWeight: fontWeight),
    );
    return newWidget;
  }
}
