import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/helpers/global.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/models/news_state_model.dart';
import 'package:news/screens/register_page/register_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/global_widget.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/search_shimmer.dart';
import './bookmark_page_view_model.dart';

class BookmarkPageView extends BookmarkPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, NewsState>(
      converter: (store) => store.state.newsState,
      builder: (context, state) {
        return CustomScaffold(
          scaffoldKey: scaffoldKey,
          body: isHaveToken == null
              ? SearchShimmer()
              : isHaveToken
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          isLoading
                              ? SearchShimmer()
                              : state.bookmarkList == null
                                  ? SearchShimmer()
                                  : state.bookmarkList.isEmpty
                                      ? SizedBox(
                                          width: width,
                                          height: height * 0.9,
                                          child: Center(
                                            child: sarabunText(
                                              width * 0.05,
                                              "Bookmark Kosong",
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
                                            list: state.bookmarkList,
                                            listFrom: "bookmark",
                                          ),
                                        )
                        ],
                      ),
                    )
                  : buildUnloginPage(),
        );
      },
    );
  }

  Widget buildUnloginPage() {
    return Stack(
      children: [
        Image.asset(
          ImageBoarding.read1,
          width: width,
          height: height * 0.6,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * 0.35,
            padding: EdgeInsets.only(
              top: height * 0.01,
              right: width * 0.03,
              left: width * 0.03,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * 0.1),
                topLeft: Radius.circular(width * 0.1),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sarabunText(
                  width * 0.05,
                  "Dapatkan Fitur\nKeseluruhan Dengan Log In",
                  fw: FontWeight.bold,
                  ta: TextAlign.center,
                  th: 1.2,
                ),
                Column(
                  children: [
                    inputLogin(email, "Email"),
                    SizedBox(height: height * 0.01),
                    inputLogin(password, "Password", isPassword: true),
                  ],
                ),
                loginButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sarabunText(
                      width * 0.03,
                      "Anda belum punya akun ? ",
                    ),
                    InkWell(
                      onTap: () {
                        nextPage(
                            context,
                            RegisterPage(
                              from: "bookmark",
                            ));
                      },
                      child: sarabunText(
                        width * 0.03,
                        "Daftar Disini",
                        color: ClassColors.maincolor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        isLoginLoading ? isLoadActionPage(width, height) : SizedBox()
      ],
    );
  }

  Widget inputLogin(
    TextEditingController controller,
    String hint, {
    bool isPassword = false,
  }) {
    return Container(
      height: height * 0.05,
      width: width,
      margin: EdgeInsets.only(
        left: width * 0.04,
        right: width * 0.04,
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(width * 0.01),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isVisible : false,
        style: TextStyle(fontSize: width * 0.033),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: width * 0.033),
          suffixIcon: isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.001),
                    child: Icon(
                      isVisible ? FontAwesome.eye_slash : FontAwesome.eye,
                      size: width * 0.04,
                      color: ClassColors.maincolor,
                    ),
                  ),
                )
              : SizedBox(),
          suffixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
        ),
      ),
    );
  }

  Widget loginButton() {
    return InkWell(
      onTap: () {
        loginAction();
      },
      child: Container(
        height: height * 0.05,
        decoration: BoxDecoration(
          color: ClassColors.maincolor,
          borderRadius: BorderRadius.circular(width * 0.012),
        ),
        margin: EdgeInsets.symmetric(horizontal: width * 0.17),
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.05,
        ),
        child: Center(
          child: sarabunText(
            width * 0.04,
            "Log In",
            ta: TextAlign.center,
            color: Colors.white,
            fw: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
