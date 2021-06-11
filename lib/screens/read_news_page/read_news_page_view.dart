import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:news/helpers/global.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/read_news_shimmer.dart';
import 'package:news/widgets/webview_page.dart';
import './read_news_page_view_model.dart';

class ReadNewsPageView extends ReadNewsPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onPop,
          child: CustomScaffold(
        scaffoldKey: scaffoldKey,
        body: dataNews == null
            ? ReadNewsShimmer()
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        buildImageHeader(),
                        buildTitle(),
                        buildPublisher(),
                        buildNews(),
                        SizedBox(height: height * 0.18)
                      ],
                    ),
                  ),
                  isLoading ? isLoadActionPage(width, height) : SizedBox()
                ],
              ),
        floatingActionButton: dataNews == null ? SizedBox() : dialButton(),
      ),
    );
  }

  Widget buildImageHeader() {
    return Stack(
      children: [
        dataNews.image == " " || dataNews.image == null
            ? buildNoImage(width, height * 0.04, width * 0.05)
            : buildNetworkImage(
                width,
                height * 0.4,
                dataNews.image,
                isAllRadius: false,
                radiusBottomLeft: width * 0.05,
                radiusBottomRight: width * 0.05,
                fit: BoxFit.cover,
              ),
        Positioned(
          top: 0,
          child: Container(
            width: width,
            height: height * 0.16,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ClassColors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: width,
            height: height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(width * 0.05),
                  bottomLeft: Radius.circular(width * 0.05)),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  ClassColors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: height * 0.02,
          left: width * 0.06,
          right: width * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sarabunText(
                width * 0.035,
                dataNews.date,
                fw: FontWeight.w600,
                color: Colors.white,
              ),
              Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                    size: width * 0.045,
                  ),
                  sarabunText(
                    width * 0.035,
                    "  ${dataNews.views}",
                    fw: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: height * 0.005,
          left: width * 0.02,
          right: width * 0.02,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  borderRadius: BorderRadius.circular(width * 0.01),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: width * 0.055,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    backScreenAction();
                  }),
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(width * 0.01),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Icon(
                        dataNews.isBookmark
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        size: width * 0.055,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      addToBookMark();
                    },
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(width * 0.01),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Icon(
                        Icons.share,
                        size: width * 0.055,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isLoading = true;
                        shareNews();
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildTitle() {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.07,
        vertical: height * 0.03,
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: ClassColors.maincolor, width: 4),
        ),
      ),
      child: montserratText(
        width * 0.05 + indicator,
        dataNews.title,
        fw: FontWeight.bold,
        th: 1.2,
      ),
    );
  }

  Widget buildPublisher() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.08),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                dataNews.publisher.contains("Tribunnews")
                    ? ImagePublisher.tribun
                    : dataNews.publisher.contains("Detik")
                        ? ImagePublisher.detik
                        : dataNews.publisher.contains("Okezone")
                            ? ImagePublisher.okezones
                            : dataNews.publisher.contains("Merdeka")
                                ? ImagePublisher.merdeka
                                : ImagePublisher.liputan,
                width: width * 0.05,
              ),
              SizedBox(width: width * 0.01),
              montserratText(
                width * 0.033 + indicator,
                dataNews.publisher,
                fw: FontWeight.bold,
                th: 1.2,
              ),
            ],
          ),
          buildLinkButton(),
        ],
      ),
    );
  }

  Widget buildLinkButton() {
    return Container(
      width: width * 0.17,
      height: height * 0.035,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          nextPage(
            context,
            WebviewNews(
              url: dataNews.link,
              title: dataNews.title,
            ),
          );
        },
        color: ClassColors.maincolor,
        child: sarabunText(
          width * 0.03,
          "Sumber",
          fw: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildNews() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.07,
      ),
      // child: sarabunText(
      //   width * 0.035 + indicator,
      //   Utils.textNews(dataNews.news),
      //   th: 1.5,
      // ),
      child: Html(
        data: dataNews.news,
        style: {
          "body": Style(
            fontSize: FontSize(width * 0.035 + indicator),
          ),
        },
      ),
    );
  }

  Widget dialButton() {
    return SpeedDial(
      // both default to 16
      marginEnd: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      visible: dialVisible,
      closeManually: true,
      curve: Curves.bounceIn,
      overlayColor: ClassColors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: ClassColors.black,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(
            Icons.format_size,
            size: width * 0.04,
            color: Colors.black,
          ),
          labelWidget: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(3),
            ),
            child: sarabunText(
              width * 0.035,
              "Kecilkan Font",
              color: Colors.white,
              fw: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          onTap: () => makeSmaller(),
        ),
        SpeedDialChild(
          child: Icon(
            Icons.format_size,
            size: width * 0.05,
            color: Colors.black,
          ),
          labelWidget: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(3),
            ),
            child: sarabunText(
              width * 0.035,
              "Besarkan Font",
              color: Colors.white,
              fw: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          onTap: () => makeBigger(),
        ),
      ],
    );
  }
}
