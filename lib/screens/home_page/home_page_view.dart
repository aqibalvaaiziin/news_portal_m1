import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/helpers/global.dart';
import 'package:news/models/all_news_model.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/models/news_state_model.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/screens/read_news_page/read_news_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/global_widget.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/home_shimmer.dart';
import './home_page_view_model.dart';

class HomePageView extends HomePageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, NewsState>(
      converter: (store) => store.state.newsState,
      builder: (context, state) {
        return CustomScaffold(
          scaffoldKey: scaffoldKey,
          body: isLoading
              ? HomeShimmer()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      buildHeader(),
                      buildTabTopic(),
                      imageSlider(state),
                      latestNews(state),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget buildHeader() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        width * 0.015,
        0,
        width * 0.05,
        height * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            ImageBoarding.splash,
            width: width * 0.2,
          ),
          InkWell(
            onTap: () {
              nextPageRemove(
                context,
                NavigatorPage(
                  currentPage: 3,
                ),
              );
            },
            child: !isHaveToken
                ? SizedBox()
                : Icon(
                    FontAwesome.user_circle,
                    size: width * 0.06,
                  ),
          )
        ],
      ),
    );
  }

  Widget buildTabTopic() {
    return Container(
      width: width,
      height: height * 0.04,
      padding: EdgeInsets.only(left: width * 0.05),
      margin: EdgeInsets.only(bottom: height * 0.015),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topics.length,
        itemBuilder: (context, i) {
          return isHaveToken && i == 0
              ? SizedBox()
              : buildItemTopic(topics[i], i);
        },
      ),
    );
  }

  Widget buildItemTopic(data, i) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(width * 0.01),
            topLeft: Radius.circular(width * 0.01),
          ),
          onTap: () {
            setState(() {
              topicsValue = i;
            });
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.005),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: data['value'] == topicsValue
                        ? ClassColors.maincolor
                        : Colors.white,
                    width: 3),
              ),
            ),
            child: sarabunText(
              width * 0.037,
              data['name'],
              color: data['value'] == topicsValue ? Colors.black : Colors.grey,
              fw: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: width * 0.02)
      ],
    );
  }

  Widget buildEmptyList() {
    return Container(
      width: width * 0.8,
      height: height * 0.27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.02),
        color: Colors.grey[400],
      ),
      child: Center(
        child: montserratText(width * 0.06, "Kategori Kosong",
            color: Colors.grey[100], fw: FontWeight.bold),
      ),
    );
  }

  Widget imageSlider(NewsState state) {
    List<AllNews> selectedList = topicsValue == 0
        ? state.homeAllNewsList
        : topicsValue == 1
            ? state.homeTravelList
            : topicsValue == 2
                ? state.homeTechList
                : topicsValue == 3
                    ? state.homeSelebList
                    : topicsValue == 4
                        ? state.homeSportList
                        : state.homeHealthList;
    return selectedList.isEmpty
        ? buildEmptyList()
        : Container(
            margin: EdgeInsets.only(top: height * 0.01),
            width: width,
            child: Column(
              children: [
                Container(
                  width: width,
                  child: CarouselSlider.builder(
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 10),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        aspectRatio: 2.0,
                        pauseAutoPlayOnTouch: true,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: selectedList.length,
                      itemBuilder: (BuildContext context, int i, int index) {
                        AllNews data = selectedList[i];
                        // if (topicsValue == 1) {
                        //   if (data.topic.contains("travel")) {
                        //     return itemSlider(data, i);
                        //   }
                        // } else if (topicsValue == 2) {
                        //   if (data.topic.contains("tech")) {
                        //     return itemSlider(data, i);
                        //   }
                        // } else if (topicsValue == 3) {
                        //   if (data.topic.contains("seleb")) {
                        //     return itemSlider(data, i);
                        //   }
                        // } else if (topicsValue == 4) {
                        //   if (data.topic.contains("sport")) {
                        //     return itemSlider(data, i);
                        //   }
                        // } else if (topicsValue == 5) {
                        //   if (data.topic.contains("health")) {
                        //     return itemSlider(data, i);
                        //   }
                        // } else {
                        return itemSlider(data, i);
                        // }
                        // return Container();
                      }),
                ),
              ],
            ),
          );
  }

  Widget itemSlider(AllNews data, i) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.02),
      child: InkWell(
        onTap: () {
          nextPage(
            context,
            ReadNewsPage(
              idNews: data.sId,
              from: "home",
            ),
          );
        },
        child: Stack(
          children: [
            data == null || data.image == " "
                ? buildNoImage(
                    width * 0.8,
                    height * 0.3,
                    width * 0.03,
                    radius: width * 0.02,
                  )
                : buildNetworkImage(
                    width * 0.8,
                    height * 0.3,
                    data.image,
                    fit: BoxFit.cover,
                    radius: width * 0.02,
                    isAllRadius: true,
                  ),
            Positioned(
              top: 0,
              child: Container(
                width: width * 0.8,
                height: height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.02),
                    topRight: Radius.circular(width * 0.02),
                  ),
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
                width: width * 0.8,
                height: height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.02),
                    topRight: Radius.circular(width * 0.02),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      ClassColors.black.withOpacity(0.6),
                      Colors.transparent,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height * 0.015,
              left: width * 0.03,
              right: width * 0.03,
              child: SizedBox(
                width: width,
                child: Text(
                  data.title,
                  style: TextStyle(
                    fontSize: width * 0.045,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              top: height * 0.01,
              left: width * 0.03,
              right: width * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sarabunText(
                    width * 0.035,
                    data.date,
                    color: Colors.white,
                    fw: FontWeight.w600,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(width * 0.011),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Icon(
                        data.isBookmark
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        size: width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      print("topicsValue  : $topicsValue");
                      if (data.isBookmark) {
                        bookmarkSlider(jsonEncode(data), isAdd: false);
                      } else {
                        bookmarkSlider(jsonEncode(data));
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget latestNews(NewsState state) {
    List<AllNews> selectedNews =
        isHaveToken ? state.homeAllNewsList : state.homeNewsList;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.04,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: montserratText(
              width * 0.05,
              "Berita Terbaru",
              fw: FontWeight.bold,
            ),
          ),
          selectedNews.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: height * 0.01),
                  width: width,
                  height: height * 0.17,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                  child: Center(
                    child: montserratText(
                      width * 0.055,
                      "Berita Kosong",
                      color: Colors.grey[100],
                      fw: FontWeight.bold,
                    ),
                  ),
                )
              : BuildCardList(
                  list: selectedNews,
                  isLoading: selectedNews == null,
                  listFrom: "home",
                ),
        ],
      ),
    );
  }
}
