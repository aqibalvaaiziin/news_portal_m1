import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/helpers/global.dart';
import 'package:news/models/topics_model.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/models/topics_state_model.dart';
import 'package:news/screens/list_publisher_and_topics_page/list_publisher_and_topics_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/search_shimmer.dart';
import './topic_list_page_view_model.dart';

class TopicListPageView extends TopicListPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return StoreConnector<AppState, TopicsState>(
      converter: (store) => store.state.topicsState,
      builder: (context, state) {
        return CustomScaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: sarabunText(
              width * 0.05,
              "Pilih Topic Untuk Rekomendasi Anda",
              fw: FontWeight.w800,
            ),
            centerTitle: true,
          ),
          body: state.topicsList.isEmpty
              ? SearchShimmer()
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildListTopics(state.topicsList),
                          SizedBox(height: height * 0.1),
                        ],
                      ),
                    ),
                    isLoading ? isLoadAction(width, height) : SizedBox()
                  ],
                ),
        );
      },
    );
  }

  Widget buildListTopics(List<TopicModel> list) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: list.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return itemTopics(list[i], i);
      },
    );
  }

  Widget itemTopics(TopicModel data, int index) {
    return Container(
      width: width,
      height: height * 0.13,
      margin: EdgeInsets.only(
        left: width * 0.03,
        right: width * 0.03,
        bottom: height * 0.02,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.02),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(1, 2),
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.02),
        child: MaterialButton(
          padding: EdgeInsets.all(width * 0.03),
          onPressed: () {
            String topicValue = index == 1
                ? "news"
                : index == 2
                    ? "tech"
                    : index == 3
                        ? "seleb"
                        : index == 4
                            ? "health"
                            : index == 5
                                ? "travel"
                                : "sport";
            nextPage(
              context,
              ListPublisherAndTopicsPage(
                from: "topic",
                image: ImageBoarding.newspaper,
                name: data.name,
                topicName: topicValue,
              ),
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.01),
                child: Image.asset(
                  data.name == "Techno"
                      ? ImageBoarding.tech
                      : data.name == "News"
                          ? ImageBoarding.news
                          : data.name == "Seleb"
                              ? ImageBoarding.seleb
                              : data.name == "Health"
                                  ? ImageBoarding.health
                                  : data.name == "Sport"
                                      ? ImageBoarding.sport
                                      : ImageBoarding.travel,
                  width: width * 0.2,
                  height: width * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sarabunText(
                      width * 0.05,
                      data.name == "Techno"
                          ? "Teknologi"
                          : data.name == "News"
                              ? "News"
                              : data.name == "Seleb"
                                  ? "Selebriti"
                                  : data.name == "Health"
                                      ? "Kesehatan"
                                      : data.name == "Sport"
                                          ? "OlahRaga"
                                          : "Travel",
                      fw: FontWeight.bold,
                    ),
                    SizedBox(height: height * 0.01),
                    SizedBox(
                      width: width * 0.5,
                      child: sarabunText(
                        width * 0.033,
                        data.name == "Techno"
                            ? techDesc
                            : data.name == "News"
                                ? newsDesc
                                : data.name == "Seleb"
                                    ? selebDesc
                                    : data.name == "Health"
                                        ? healthDesc
                                        : data.name == "Sport"
                                            ? sportDesc
                                            : travelDesc,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
