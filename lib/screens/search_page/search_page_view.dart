import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/models/publisher_model.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/models/news_state_model.dart';
import 'package:news/screens/list_publisher_and_topics_page/list_publisher_and_topics_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/global_widget.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/first_search_shimmer.dart';
import 'package:news/widgets/shimmer/search_shimmer.dart';
import './search_page_view_model.dart';

class SearchPageView extends SearchPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, NewsState>(
      converter: (store) => store.state.newsState,
      builder: (context, state) {
        print(state.searchNewsList);
        return CustomScaffold(
          scaffoldKey: scaffoldKey,
          body: firstLoading
              ? FirstSearchShimmer()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSearchBar(),
                      buildViewLayout(state),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget buildSearchBar() {
    return Container(
      width: width,
      height: height * 0.09,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(width * 0.06),
          bottomLeft: Radius.circular(width * 0.06),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.06,
        vertical: width * 0.03,
      ),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.01),
        ),
        padding: EdgeInsets.only(
          bottom: height * 0.001,
          left: width * 0.03,
          right: width * 0.03,
        ),
        child: TextField(
          style: TextStyle(fontSize: width * 0.037),
          controller: searchController,
          onChanged: (value) => searchStoreData(value),
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: width * 0.05,
            ),
            hintText: "Cari Berita ...........",
            hintStyle: TextStyle(fontSize: width * 0.037),
            suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          ),
        ),
      ),
    );
  }

  Widget buildViewLayout(NewsState state) {
    return isLoading
        ? SearchShimmer()
        : searchController.text.isEmpty
            ? buildPubliserList()
            : state.searchNewsList.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: BuildCardList(
                      list: state.searchNewsList,
                      isLoading: isLoading,
                      listFrom: "search",
                    ),
                  )
                : sarabunText(width * 0.03, "data kosong");
  }

  Widget buildPubliserList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: height * 0.01),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: publisherList.length,
      itemBuilder: (context, i) {
        return publisherItem(publisherList[i]);
      },
    );
  }

  Widget publisherItem(PublisherModel data) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.02),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(1, 2),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.02),
        child: MaterialButton(
          padding: EdgeInsets.all(width * 0.03),
          onPressed: () {
            nextPage(
              context,
              ListPublisherAndTopicsPage(
                from: "publisher",
                image: data.image,
                name: data.name,
                iconData: Icons.login,
              ),
            );
          },
          child: Row(
            children: [
              buildNetworkImage(width * 0.2, width * 0.2, data.image),
              SizedBox(width: width * 0.03),
              montserratText(
                width * 0.045,
                data.name,
                fw: FontWeight.w600,
              )
            ],
          ),
        ),
      ),
    );
  }
}
