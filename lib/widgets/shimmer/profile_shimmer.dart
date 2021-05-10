import 'package:flutter/material.dart';
import 'package:news/helpers/global.dart';
import 'package:news/widgets/shimmer/component_shimmer.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProfileShimmer extends StatelessWidget {
  double width;
  double height;

  ProfileShimmer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Opacity(
          opacity: 0.3,
          child: Image.asset(
            ImageBoarding.newspaper,
            fit: BoxFit.cover,
            width: width,
            height: height * 0.5,
          ),
        ),
        Container(
          width: width,
          height: height * 0.5,
          child: Shimmer(
            gradient: LinearGradient(
                colors: [Colors.grey[300], Colors.grey[400], Colors.grey[300]],
                begin: Alignment(1, 1),
                end: Alignment(-1, -1),
                stops: [0.4, 0.5, 0.6]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                rectShimmer(width * 0.24, width * 0.24, radius: width),
                SizedBox(height: height * 0.02),
                rectShimmer(
                  width * 0.6,
                  height * 0.04,
                ),
                SizedBox(height: height * 0.015),
                rectShimmer(
                  width * 0.6,
                  height * 0.03,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * 0.46,
            padding: EdgeInsets.only(
              left: width * 0.05,
              right: width * 0.05,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * 0.1),
                topLeft: Radius.circular(width * 0.1),
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer(
                  gradient: LinearGradient(
                      colors: [
                        Colors.grey[300],
                        Colors.grey[400],
                        Colors.grey[300]
                      ],
                      begin: Alignment(1, 1),
                      end: Alignment(-1, -1),
                      stops: [0.4, 0.5, 0.6]),
                  child: rectShimmer(width * 0.7, height * 0.04),
                ),
                SizedBox(height: height * 0.05),
                boxTopic(),
              ],
            )),
          ),
        )
      ],
    );
  }

  Widget boxTopic() {
    return Container(
      width: width,
      height: height * 0.28,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.05),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(2, 2),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ]),
      child: Shimmer(
        gradient: LinearGradient(
            colors: [Colors.grey[300], Colors.grey[400], Colors.grey[300]],
            begin: Alignment(1, 1),
            end: Alignment(-1, -1),
            stops: [0.4, 0.5, 0.6]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                buildItemTopic(),
                buildItemTopic(),
                buildItemTopic(),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[200],
              indent: width * 0.03,
              endIndent: width * 0.03,
            ),
            Row(
              children: [
                buildItemTopic(),
                buildItemTopic(),
                buildItemTopic(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemTopic() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rectShimmer(width * 0.08, width * 0.08),
              SizedBox(height: height * 0.01),
              rectShimmer(width * 0.2, height * 0.018),
            ],
          ),
        ),
      ),
    );
  }
}
