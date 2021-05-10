import 'package:news/redux/actions/news_state_action.dart';
import 'package:news/redux/models/news_state_model.dart';
import 'package:redux/redux.dart';

final newsReducer = combineReducers<NewsState>(
    [TypedReducer<NewsState, dynamic>(_setNewsState)]);

NewsState _setNewsState(NewsState state, action) {
  // get list
  if (action is SearchText) {
    return state.copyWith(searchText: action.searchText);
  } else if (action is SetHomeAllsList) {
    return state.copyWith(homeAllNewsList: action.homeAllNewsList);
  } else if (action is SetBookmarkList) {
    return state.copyWith(bookmarkList: action.bookmarkList);
  } else if (action is SetHomeNewsList) {
    return state.copyWith(homeNewsList: action.homeNewsList);
  } else if (action is SetHomeTravelList) {
    return state.copyWith(homeTravelList: action.homeTravelList);
  } else if (action is SetHomeTechList) {
    return state.copyWith(homeTechList: action.homeTechList);
  } else if (action is SetHomeSelebList) {
    return state.copyWith(homeSelebList: action.homeSelebList);
  } else if (action is SetHomeSportList) {
    return state.copyWith(homeSportList: action.homeSportList);
  } else if (action is SetHomeHealthList) {
    return state.copyWith(homeHealthList: action.homeHealthList);
  } else if (action is SetSearchNewsList) {
    return state.copyWith(searchNewsList: action.searchNewsList);
  } else if (action is SetTopicPublisherList) {
    return state.copyWith(topicPublisherList: action.topicPublisherList);
  }

  // add data to list
  else if (action is AddToHomeNewsList) {
    return state.copyWith(
      homeNewsList: state.homeNewsList..add(action.data),
    );
  } else if (action is AddToHomeTravelList) {
    return state.copyWith(
      homeTravelList: state.homeTravelList..add(action.data),
    );
  } else if (action is AddToHomeTechList) {
    return state.copyWith(
      homeTechList: state.homeTechList..add(action.data),
    );
  } else if (action is AddToHomeSelebList) {
    return state.copyWith(
      homeSelebList: state.homeSelebList..add(action.data),
    );
  } else if (action is AddToHomeSportList) {
    return state.copyWith(
      homeSportList: state.homeSportList..add(action.data),
    );
  } else if (action is AddToHomeHealthList) {
    return state.copyWith(
      homeHealthList: state.homeHealthList..add(action.data),
    );
  }

  //set bookmark
  else if (action is SetHomeAllNewsBookmark) {
    return state.copyWith(
      homeAllNewsList: state.homeAllNewsList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetHomeNewsBookmark) {
    return state.copyWith(
      homeNewsList: state.homeNewsList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetHomeTravelBookmark) {
    return state.copyWith(
      homeTravelList: state.homeTravelList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetHomeTechBookmark) {
    return state.copyWith(
      homeTechList: state.homeTechList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetHomeSelebBookmark) {
    return state.copyWith(
      homeSelebList: state.homeSelebList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetHomeSportBookmark) {
    return state.copyWith(
      homeSportList: state.homeSportList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetHomeHealthBookmark) {
    return state.copyWith(
      homeHealthList: state.homeHealthList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetSearchNewsBookmark) {
    return state.copyWith(
      searchNewsList: state.searchNewsList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetBookmarkPageBookmark) {
    return state.copyWith(
      bookmarkList: state.bookmarkList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  } else if (action is SetTopicPublisherPageBookmark) {
    return state.copyWith(
      topicPublisherList: state.topicPublisherList
        ..forEach((element) {
          if (element.sId == action.newsId) {
            element.isBookmark = !element.isBookmark;
          }
        }),
    );
  }

  return state;
}
