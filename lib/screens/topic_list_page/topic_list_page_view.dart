import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/helpers/global.dart';
import 'package:news/models/topics_model.dart';
import 'package:news/redux/actions/topics_state_action.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/models/topics_state_model.dart';
import 'package:news/widgets/custom_widet.dart';
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
          body: state.topicsList.isEmpty
              ? SearchShimmer()
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.03,
                            ),
                            child: sarabunText(
                              width * 0.05,
                              "Pilih Topic Untuk Rekomendasi Anda",
                              fw: FontWeight.w800,
                            ),
                          ),
                          buildListTopics(state.topicsList),
                          SizedBox(height: height * 0.1),
                        ],
                      ),
                    ),
                    isLoading ? isLoadAction(width, height) : SizedBox()
                  ],
                ),
          floatingActionButton: buttonFinish(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
        return itemTopics(list[i]);
      },
    );
  }

  Widget itemTopics(TopicModel data) {
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
            setState(() {
              if (data.name != "News") {
                store.dispatch(RemoveItemFromTopicsList(data.sId));
              }
            });
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
              )),
              SizedBox(width: width * 0.02),
              data.isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonFinish() {
    return Container(
      width: width,
      height: height * 0.08,
      decoration: BoxDecoration(
        color: ClassColors.maincolor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(width * 0.1),
          topLeft: Radius.circular(width * 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(width * 0.1),
          topLeft: Radius.circular(width * 0.1),
        ),
        child: MaterialButton(
          onPressed: () {
            chooseTopicAction();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sarabunText(
                width * 0.045,
                "Lanjut Baca  ",
                fw: FontWeight.bold,
                color: Colors.white,
              ),
              Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: width * 0.05,
              )
            ],
          ),
        ),
      ),
    );
  }
}
