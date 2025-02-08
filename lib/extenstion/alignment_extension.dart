import 'package:flutter/material.dart';

extension AlignmentExtension on Widget {
  Widget setAlignment(AlignmentGeometry align) {
    return Align(
      alignment: align,
      child: this,
    );
  }
   Widget alignTopLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Widget alignTopRight() {
    return Align(
      alignment: Alignment.topRight,
      child: this,
    );
  }

  Widget alignCenter() {
    return Align(
      alignment: Alignment.center,
      child: this,
    );
  }
}
