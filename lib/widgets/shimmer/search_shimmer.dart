import 'package:flutter/material.dart';
import 'package:news/widgets/shimmer/component_shimmer.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class SearchShimmer extends StatelessWidget {
  double width;
  double height;

  SearchShimmer({Key key}) : super(key: key);
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
        child: ListView.builder(
          itemCount: 8,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: rectShimmer(
                width * 0.93,
                height * 0.16,
                radius: width * 0.03,
              ),
            );
          },
        ));
  }
}
