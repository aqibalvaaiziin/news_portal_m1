import 'package:flutter/material.dart';
import 'package:news/widgets/shimmer/component_shimmer.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomeShimmer extends StatelessWidget {
  double width;
  double height;

  HomeShimmer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Shimmer(
      gradient: LinearGradient(
          colors: [Colors.grey[300], Colors.grey[400], Colors.grey[300]],
          begin: Alignment(1, 1),
          end: Alignment(-1, -1),
          stops: [0.4, 0.5, 0.6]),
      child: Container(
          child: Column(
        children: [
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                rectShimmer(width * 0.2, height * 0.07),
                circShimmer(width * 0.1)
              ],
            ),
          ),
          SizedBox(height: height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                rectShimmer(width * 0.2, height * 0.025),
                rectShimmer(width * 0.2, height * 0.025),
                rectShimmer(width * 0.2, height * 0.025),
                rectShimmer(width * 0.2, height * 0.025),
              ],
            ),
          ),
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rectShimmer(
                width * 0.06,
                height * 0.23,
                isAllRadius: false,
                topRight: 6,
                bottomRight: 6,
              ),
              rectShimmer(width * 0.75, height * 0.23),
              rectShimmer(
                width * 0.06,
                height * 0.23,
                isAllRadius: false,
                bottomLeft: 6,
                topLeft: 6,
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.03),
            alignment: Alignment.centerLeft,
            child: rectShimmer(width * 0.3, height * 0.04),
          ),
          SizedBox(height: height * 0.03),
          rectShimmer(width * 0.93, height * 0.16, radius: width * 0.03),
          SizedBox(height: height * 0.02),
          rectShimmer(width * 0.93, height * 0.16, radius: width * 0.03),
        ],
      )),
    );
  }
}
