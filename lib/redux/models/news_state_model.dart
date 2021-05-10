
import 'package:news/models/all_news_model.dart';

class NewsState {
  final String searchText;
  final List<AllNews> homeAllNewsList;
  final List<AllNews> homeNewsList;
  final List<AllNews> homeTravelList;
  final List<AllNews> homeTechList;
  final List<AllNews> homeSelebList;
  final List<AllNews> homeSportList;
  final List<AllNews> homeHealthList;
  final List<AllNews> bookmarkList;
  final List<AllNews> searchNewsList;
  final List<AllNews> topicPublisherList;

  NewsState({
    this.searchText,
    this.homeAllNewsList,
    this.homeNewsList,
    this.homeTravelList,
    this.homeTechList,
    this.homeSelebList,
    this.homeSportList,
    this.homeHealthList,
    this.searchNewsList,
    this.topicPublisherList,
    this.bookmarkList,
  });

  factory NewsState.initial() {
    return NewsState(
      searchText: "",
      homeAllNewsList: null,
      homeNewsList: null,
      homeTravelList: null,
      homeTechList: null,
      homeSelebList: null,
      homeSportList: null,
      searchNewsList: null,
      topicPublisherList: null,
      homeHealthList: null,
      bookmarkList: null,
    );
  }

  NewsState copyWith({
    String searchText,
    List<AllNews> homeAllNewsList,
    List<AllNews> homeNewsList,
    List<AllNews> homeTravelList,
    List<AllNews> homeTechList,
    List<AllNews> homeSelebList,
    List<AllNews> homeSportList,
    List<AllNews> homeHealthList,
    List<AllNews> searchNewsList,
    List<AllNews> bookmarkList,
    List<AllNews> topicPublisherList,
  }) {
    return NewsState(
      searchText: searchText ?? this.searchText,
      homeAllNewsList: homeAllNewsList ?? this.homeAllNewsList,
      homeNewsList: homeNewsList ?? this.homeNewsList,
      homeTravelList: homeTravelList ?? this.homeTravelList,
      homeTechList: homeTechList ?? this.homeTechList,
      homeSelebList: homeSelebList ?? this.homeSelebList,
      homeSportList: homeSportList ?? this.homeSportList,
      homeHealthList: homeHealthList ?? this.homeHealthList,
      searchNewsList: searchNewsList ?? this.searchNewsList,
      topicPublisherList: topicPublisherList ?? this.topicPublisherList,
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsState &&
          runtimeType == other.runtimeType &&
          searchText == other.searchText &&
          homeAllNewsList == other.homeAllNewsList &&
          homeNewsList == other.homeNewsList &&
          homeTravelList == other.homeTravelList &&
          homeTechList == other.homeTechList &&
          homeSelebList == other.homeSelebList &&
          homeSportList == other.homeSportList &&
          searchNewsList == other.searchNewsList &&
          bookmarkList == other.bookmarkList &&
          topicPublisherList == other.topicPublisherList &&
          homeHealthList == other.homeHealthList;

  @override
  int get hashCode =>
      searchText.hashCode ^
      homeAllNewsList.hashCode ^
      homeNewsList.hashCode ^
      homeTravelList.hashCode ^
      homeTechList.hashCode ^
      homeSelebList.hashCode ^
      homeSportList.hashCode ^
      bookmarkList.hashCode ^
      searchNewsList.hashCode ^
      topicPublisherList.hashCode ^
      homeHealthList.hashCode;
}
