import 'package:flutter/material.dart';
import 'package:news/widgets/shimmer/component_shimmer.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ReadNewsShimmer extends StatelessWidget {
  double width;
  double height;

  ReadNewsShimmer({Key key}) : super(key: key);
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
            rectShimmer(
              width,
              height * 0.4,
              isAllRadius: false,
              bottomRight: width * 0.05,
              bottomLeft: width * 0.05,
            ),
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                children: [
                  rectShimmer(width * 0.02, height * 0.12),
                  SizedBox(width: width * 0.01),
                  Column(
                    children: [
                      rectShimmer(width * 0.7, height * 0.03),
                      SizedBox(height: height * 0.01),
                      rectShimmer(width * 0.7, height * 0.03),
                      SizedBox(height: height * 0.01),
                      rectShimmer(width * 0.7, height * 0.03),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              itemCount: 11,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.only(bottom: height * 0.01),
                  child: rectShimmer(width, height * 0.02),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
