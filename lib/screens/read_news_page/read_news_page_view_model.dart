import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:news/api/services/news_services.dart';
import 'package:news/api/services/user_service.dart';
import 'package:news/models/all_news_model.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './read_news_page.dart';

abstract class ReadNewsPageViewModel extends State<ReadNewsPage> {
  double width;
  double height;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double indicator = 0.0;
  DetailNews dataNews;
  bool dialVisible = true;
  NewsServices newsServices = NewsServices();
  UserServices userServices = UserServices();
  bool isLoading = false;
  bool isHaveToken = true;

  checkToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      isHaveToken = sp.getString("token") == null ? false : true;
    });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  backScreenAction() {
    if (widget.isFromBookmark) {
      if (widget.from == "home") {
        nextPageRemove(context, NavigatorPage(currentPage: 0));
      } else if (widget.from == "search") {
        nextPageRemove(context, NavigatorPage(currentPage: 1));
      } else if (widget.from == "bookmark") {
        nextPageRemove(context, NavigatorPage(currentPage: 2));
      }
    } else {
      backScreen(context);
    }
  }

  addToBookMark() {
    setState(() {
      isLoading = true;
    });
    if (dataNews.isBookmark) {
      userServices.removeBookmark(widget.idNews).then((value) {
        nextPageRemove(
          context,
          ReadNewsPage(
            from: widget.from,
            idNews: widget.idNews,
            isFromBookmark: true,
            isRemove: true,
          ),
        );
      });
    } else {
      userServices.addBookmark(widget.idNews).then((value) {
        nextPageRemove(
            context,
            ReadNewsPage(
              from: widget.from,
              idNews: widget.idNews,
              isFromBookmark: true,
              isRemove: false,
            ));
      });
    }
  }

  makeSmaller() {
    if (indicator > -3.0) {
      setState(() {
        indicator -= 1;
        print(indicator);
      });
    }
  }

  makeBigger() {
    if (indicator < 3.0) {
      setState(() {
        indicator += 1;
        print(indicator);
      });
    }
  }

  getDataNews() {
    newsServices.getDetailNews(widget.idNews).then((value) {
      var jsonObject = DetailNewsResponse.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        setState(() {
          dataNews = jsonObject.data;
        });
      }
    });
  }

  showAlert() {
  // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 25,
            ),
            sarabunText(
              15,
              widget.isRemove
                  ? "  Bookmark berhasil dihapus"
                  : "  Bookmark berhasil ditambahkan",
              color: Colors.white,
              fw: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }

  Future<void> shareNews() async {
    setState(() {
      isLoading = false;
    });
    await FlutterShare.share(
      title: "Dibagikan dari D News",
      text:
          "Judul: ${dataNews.title}\nTanggal : ${dataNews.date}\nPenerbit : ${dataNews.publisher}",
      linkUrl: dataNews.link,
    );
  }

  @override
  void initState() {
    super.initState();
    getDataNews();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkToken();
      if (widget.isFromBookmark) {
        showAlert();
      }
    });
  }
}
