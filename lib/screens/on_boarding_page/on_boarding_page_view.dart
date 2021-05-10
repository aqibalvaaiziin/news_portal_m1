import 'package:flutter/material.dart';
import 'package:news/helpers/global.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import './on_boarding_page_view_model.dart';
import 'dart:math' as math;

class OnBoardingPageView extends OnBoardingPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return CustomScaffold(
      scaffoldKey: scaffoldKey,
      body: PageView.builder(
        controller: pageController,
        itemCount: listOnboarding.length,
        itemBuilder: (context, i) {
          return buildOnboarding(
            listOnboarding[i],
            i,
          );
        },
      ),
    );
  }

  Widget buildOnboarding(data, i) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset(
            data['image'],
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          SizedBox(height: height * 0.06),
          Positioned(
            bottom: height * 0.03,
            left: width * 0.05,
            right: width * 0.05,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.04),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.05)),
              child: Column(
                children: [
                  montserratText(
                    width * 0.036,
                    data['headerText'],
                    fw: FontWeight.w700,
                    ta: TextAlign.center,
                    th: 1.2,
                  ),
                  SizedBox(height: height * 0.01),
                  montserratText(
                    width * 0.034,
                    data['footerText'],
                    ta: TextAlign.center,
                    th: 1.2,
                  ),
                  SizedBox(height: height * 0.03),
                  i == 0 || i == 3
                      ? Container(
                          width: width * 0.5,
                          height: height * 0.045,
                          decoration: BoxDecoration(
                            color: ClassColors.maincolor,
                            borderRadius: BorderRadius.circular(width),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width),
                            child: MaterialButton(
                              onPressed: () {
                                if (i == 0) {
                                  startOnboarding();
                                } else {
                                  preferencesData
                                      .setIsAlreadyOpenOnboarding(true);
                                  nextPageRemove(context, NavigatorPage());
                                }
                              },
                              child: montserratText(
                                width * 0.04,
                                i == 0 ? "Mulai" : "Mulai Baca",
                                fw: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildShape(isActive: i == 1),
                            buildShape(isActive: i == 2),
                            buildShape(isActive: i == 3),
                          ],
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShape({bool isActive = false}) {
    return Transform.rotate(
      angle: math.pi / 0.79,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
        width: width * 0.02,
        height: width * 0.02,
        color: isActive
            ? ClassColors.maincolor
            : ClassColors.maincolor.withOpacity(0.5),
      ),
    );
  }
}
