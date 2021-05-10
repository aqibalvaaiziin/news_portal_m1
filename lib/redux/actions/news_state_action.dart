
import 'package:news/models/all_news_model.dart';

class SearchText {
  final String searchText;
  SearchText(this.searchText);
}

class SetBookmarkList {
  final List<AllNews> bookmarkList;

  SetBookmarkList(this.bookmarkList);
}

class SetTopicPublisherList {
  final List<AllNews> topicPublisherList;

  SetTopicPublisherList(this.topicPublisherList);
}

class SetHomeAllsList {
  final List<AllNews> homeAllNewsList;

  SetHomeAllsList(this.homeAllNewsList);
}

class SetSearchNewsList {
  final List<AllNews> searchNewsList;

  SetSearchNewsList(this.searchNewsList);
}

class SetHomeNewsList {
  final List<AllNews> homeNewsList;

  SetHomeNewsList(this.homeNewsList);
}

class AddToHomeNewsList {
  final AllNews data;

  AddToHomeNewsList(this.data);
}

class SetHomeTravelList {
  final List<AllNews> homeTravelList;

  SetHomeTravelList(this.homeTravelList);
}

class AddToHomeTravelList {
  final AllNews data;

  AddToHomeTravelList(this.data);
}

class SetHomeTechList {
  final List<AllNews> homeTechList;

  SetHomeTechList(this.homeTechList);
}

class AddToHomeTechList {
  final AllNews data;

  AddToHomeTechList(this.data);
}

class SetHomeSelebList {
  final List<AllNews> homeSelebList;

  SetHomeSelebList(this.homeSelebList);
}

class AddToHomeSelebList {
  final AllNews data;

  AddToHomeSelebList(this.data);
}

class SetHomeSportList {
  final List<AllNews> homeSportList;

  SetHomeSportList(this.homeSportList);
}

class AddToHomeSportList {
  final AllNews data;

  AddToHomeSportList(this.data);
}

class SetHomeHealthList {
  final List<AllNews> homeHealthList;

  SetHomeHealthList(this.homeHealthList);
}

class AddToHomeHealthList {
  final AllNews data;

  AddToHomeHealthList(this.data);
}

class SetHomeAllNewsBookmark {
  final String newsId;

  SetHomeAllNewsBookmark(this.newsId);
}

class SetHomeNewsBookmark {
  final String newsId;

  SetHomeNewsBookmark(this.newsId);
}

class SetHomeTravelBookmark {
  final String newsId;

  SetHomeTravelBookmark(this.newsId);
}

class SetHomeTechBookmark {
  final String newsId;

  SetHomeTechBookmark(this.newsId);
}

class SetHomeSelebBookmark {
  final String newsId;

  SetHomeSelebBookmark(this.newsId);
}

class SetHomeSportBookmark {
  final String newsId;

  SetHomeSportBookmark(this.newsId);
}

class SetHomeHealthBookmark {
  final String newsId;

  SetHomeHealthBookmark(this.newsId);
}

class SetSearchNewsBookmark {
  final String newsId;

  SetSearchNewsBookmark(this.newsId);
}

class SetBookmarkPageBookmark {
  final String newsId;

  SetBookmarkPageBookmark(this.newsId);
}

class SetTopicPublisherPageBookmark {
  final String newsId;

  SetTopicPublisherPageBookmark(this.newsId);
}
