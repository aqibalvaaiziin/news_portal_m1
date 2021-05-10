import 'package:flutter/material.dart';

Widget rectShimmer(
  double width,
  double height, {
  bool isAllRadius = true,
  double radius = 6,
  double topLeft = 0,
  double topRight = 0,
  double bottomRight = 0,
  double bottomLeft = 0,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: isAllRadius
          ? BorderRadius.circular(radius)
          : BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomRight: Radius.circular(bottomRight),
              bottomLeft: Radius.circular(bottomLeft),
            ),
    ),
  );
}

Widget circShimmer(double width, {double radius = 6}) {
  return Container(
    width: width,
    height: width,
    decoration: BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
  );
}
