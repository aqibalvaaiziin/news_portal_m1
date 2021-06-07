import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/api/services/news_services.dart';
import 'package:news/api/services/user_service.dart';
import 'package:news/models/all_news_model.dart';
import 'package:news/redux/actions/news_state_action.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home_page.dart';

abstract class HomePageViewModel extends State<HomePage> {
  double width;
  double height;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Store<AppState> store;
  bool isBookmark = false;
  NewsServices newsServices = NewsServices();
  UserServices userServices = UserServices();
  // ignore: deprecated_member_use
  List<AllNews> allNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<AllNews> newestNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<AllNews> travelNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<AllNews> techNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<AllNews> selebNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<AllNews> healthNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<AllNews> sportNews = List<AllNews>();
  bool isHaveToken = false;
  bool isLoading = true;
  String image = "";
  int topicsValue = 0;
  List topics = [
    {
      "name": "Semua",
      "value": 0,
    },
    {
      "name": "Travel",
      "value": 1,
    },
    {
      "name": "Teknologi",
      "value": 2,
    },
    {
      "name": "Selebriti",
      "value": 3,
    },
    {
      "name": "Olah Raga",
      "value": 4,
    },
    {
      "name": "Kesehatan",
      "value": 5,
    },
  ];

  checkToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      image = sp.getString("image");
      // isHaveToken = sp.getString("token") == null ? false : true;
      isHaveToken = false;
      topicsValue = isHaveToken ? 1 : 0;
    });
  }

  bookmarkSlider(String idNews, {bool isAdd = true}) {
    setState(() {
      if (topicsValue == 0) {
        store.dispatch(SetHomeAllNewsBookmark(idNews));
      } else if (topicsValue == 1) {
        store.dispatch(SetHomeTravelBookmark(idNews));
      } else if (topicsValue == 2) {
        store.dispatch(SetHomeTechBookmark(idNews));
      } else if (topicsValue == 3) {
        store.dispatch(SetHomeSelebBookmark(idNews));
      } else if (topicsValue == 4) {
        store.dispatch(SetHomeSportBookmark(idNews));
      } else if (topicsValue == 5) {
        store.dispatch(SetHomeHealthBookmark(idNews));
      }
    });
    if (isAdd) {
      userServices.addBookmark(idNews).then((value) {
        setState(() {
          if (topicsValue == 0) {
            setAllNews();
          } else if (topicsValue == 1) {
            setTravelNews();
          } else if (topicsValue == 2) {
            setTechNews();
          } else if (topicsValue == 3) {
            setSelebNews();
          } else if (topicsValue == 4) {
            setSportNews();
          } else if (topicsValue == 5) {
            setHealthNews();
          }
        });
      });
    } else {
      userServices.removeBookmark(idNews).then((value) {
        setState(() {
          if (topicsValue == 0) {
            setAllNews();
          } else if (topicsValue == 1) {
            setTravelNews();
          } else if (topicsValue == 2) {
            setTechNews();
          } else if (topicsValue == 3) {
            setSelebNews();
          } else if (topicsValue == 4) {
            setSportNews();
          } else if (topicsValue == 5) {
            setHealthNews();
          }
        });
      });
    }
  }

  setAllNews({bool isInit = false}) {
    newsServices.getAllNews().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        store.dispatch(SetHomeAllsList(allNews));
        store.dispatch(SetHomeAllsList(List.from(jsonObject.data)));
        if (isInit) {
          store.dispatch(SetHomeNewsList(newestNews));
          store.dispatch(SetHomeNewsList(newestNews));
          store.dispatch(SetHomeTravelList(travelNews));
          store.dispatch(SetHomeTechList(techNews));
          store.dispatch(SetHomeSelebList(selebNews));
          store.dispatch(SetHomeSportList(sportNews));
          store.dispatch(SetHomeHealthList(healthNews));
          store.dispatch(SetHomeAllsList(allNews));
          store.dispatch(SetHomeAllsList(List.from(jsonObject.data)));
          jsonObject.data.forEach((element) {
            if (element.topic.toLowerCase() == "news") {
              store.dispatch(AddToHomeNewsList(element));
            } else if (element.topic.toLowerCase() == "travel") {
              store.dispatch(AddToHomeTravelList(element));
            } else if (element.topic.toLowerCase() == "techno") {
              store.dispatch(AddToHomeTechList(element));
            } else if (element.topic.toLowerCase() == "seleb") {
              store.dispatch(AddToHomeSelebList(element));
            } else if (element.topic.toLowerCase() == "health") {
              store.dispatch(AddToHomeHealthList(element));
            } else if (element.topic.toLowerCase() == "sport") {
              store.dispatch(AddToHomeSportList(element));
            }
          });
        }
        isLoading = false;
      }
    });
  }

  setTravelNews() {
    newsServices.getAllNews().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        store.dispatch(SetHomeTravelList(travelNews));
        setState(() {
          jsonObject.data.forEach((element) {
            if (element.topic == "travel") {
              store.dispatch(AddToHomeTravelList(element));
            }
          });
        });
      }
    });
  }

  setTechNews() {
    newsServices.getAllNews().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        store.dispatch(SetHomeTechList(techNews));
        setState(() {
          jsonObject.data.forEach((element) {
            if (element.topic == "tech") {
              store.dispatch(AddToHomeTechList(element));
            }
          });
        });
      }
    });
  }

  setSelebNews() {
    newsServices.getAllNews().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        store.dispatch(SetHomeSelebList(selebNews));
        setState(() {
          jsonObject.data.forEach((element) {
            if (element.topic == "seleb") {
              store.dispatch(AddToHomeSelebList(element));
            }
          });
        });
      }
    });
  }

  setSportNews() {
    newsServices.getAllNews().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        store.dispatch(SetHomeSportList(sportNews));
        setState(() {
          jsonObject.data.forEach((element) {
            if (element.topic == "sport") {
              store.dispatch(AddToHomeSportList(element));
            }
          });
        });
      }
    });
  }

  setHealthNews() {
    newsServices.getAllNews().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        store.dispatch(SetHomeHealthList(healthNews));
        setState(() {
          jsonObject.data.forEach((element) {
            if (element.topic == "health") {
              store.dispatch(AddToHomeHealthList(element));
            }
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      checkToken();
      setAllNews(isInit: true);
    });
  }

  @override
  void dispose() {
    store.dispatch(SetHomeNewsList(newestNews));
    store.dispatch(SetHomeTravelList(travelNews));
    store.dispatch(SetHomeTechList(techNews));
    store.dispatch(SetHomeSelebList(selebNews));
    store.dispatch(SetHomeSportList(sportNews));
    store.dispatch(SetHomeHealthList(healthNews));
    store.dispatch(SetHomeAllsList(allNews));
    super.dispose();
  }
}
