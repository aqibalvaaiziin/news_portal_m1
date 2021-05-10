import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/models/news_state_model.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/global_widget.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/search_shimmer.dart';
import './list_publisher_and_topics_page_view_model.dart';

class ListPublisherAndTopicsPageView
    extends ListPublisherAndTopicsPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, NewsState>(
      converter: (store) => store.state.newsState,
      builder: (context, state) {
        return CustomScaffold(
            scaffoldKey: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: sarabunText(
                width * 0.045,
                widget.name,
                fw: FontWeight.bold,
              ),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: width * 0.055,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    backScreen(context);
                  }),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  isLoading
                      ? SearchShimmer()
                      : state.topicPublisherList == null
                          ? SearchShimmer()
                          : state.topicPublisherList.isEmpty
                              ? SizedBox(
                                  width: width,
                                  height: height * 0.9,
                                  child: Center(
                                    child: sarabunText(
                                      width * 0.05,
                                      "Berita Kosong",
                                      fw: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03,
                                      vertical: height * 0.02),
                                  child: BuildCardList(
                                    isLoading: false,
                                    list: state.topicPublisherList,
                                    listFrom: widget.from,
                                    name: widget.from == "topic"
                                        ? widget.topicName
                                        : widget.name,
                                  ),
                                )
                ],
              ),
            ));
      },
    );
  }
}
