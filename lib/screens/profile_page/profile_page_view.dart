import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news/helpers/global.dart';
import 'package:news/screens/list_publisher_and_topics_page/list_publisher_and_topics_page.dart';
import 'package:news/screens/register_page/register_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/profile_shimmer.dart';
import 'profile_page_view_model.dart';

class ProfilePageView extends ProfilePageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return CustomScaffold(
        scaffoldKey: scaffoldKey,
        body: isHaveToken == null
            ? ProfileShimmer()
            : isHaveToken
                ? isLoading
                    ? ProfileShimmer()
                    : Stack(
                        children: [
                          buildHeaderProfile(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: width,
                              height: height * 0.46,
                              padding: EdgeInsets.fromLTRB(
                                width * 0.06,
                                height * 0.05,
                                width * 0.06,
                                0,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(width * 0.1),
                                    topLeft: Radius.circular(width * 0.1),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(0, -2),
                                      blurRadius: 2,
                                    ),
                                  ]),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildBoxTopic(),
                                    SizedBox(height: height * 0.06),
                                    logoutButton(),
                                    SizedBox(height: height * 0.03),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          topicLoading
                              ? isLoadActionPage(width, height)
                              : SizedBox()
                        ],
                      )
                : buildUnloginPage());
  }

  Widget buildHeaderProfile() {
    return Container(
      width: width,
      height: height * 0.5,
      // color: Color(0xffffa500),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Opacity(
          //     opacity: 0.3,
          //     child: Image.asset(
          //       ImageBoarding.newspaper,
          //       fit: BoxFit.cover,
          //       width: width,
          //       height: height * 0.5,
          //     )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesome.user_circle,
                size: width * 0.3,
              ),
              SizedBox(height: height * 0.02),
              montserratText(
                width * 0.055,
                name,
                fw: FontWeight.bold,
              ),
              SizedBox(height: height * 0.015),
              montserratText(
                width * 0.035,
                email,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBoxTopic() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.05),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(2, 2),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildItemTopics(
                1,
                "606023b50bcfc713404c55c5",
                haveNews,
                FontAwesome.newspaper_o,
                "News",
                haveNews ? ClassColors.maincolor : Colors.grey,
              ),
              buildItemTopics(
                2,
                "6060268a6fb5b92c44b68571",
                haveTravel,
                Icons.airplanemode_active_outlined,
                "Travel",
                haveTravel ? ClassColors.maincolor : Colors.grey,
              ),
              buildItemTopics(
                3,
                "606023b00bcfc713404c55c4",
                haveTech,
                FontAwesome.cogs,
                "Teknologi",
                haveTech ? ClassColors.maincolor : Colors.grey,
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.grey[200],
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildItemTopics(
                4,
                "606023b90bcfc713404c55c6",
                haveSeleb,
                Icons.star,
                "Selebrity",
                haveSeleb ? ClassColors.maincolor : Colors.grey,
              ),
              buildItemTopics(
                5,
                "606023c20bcfc713404c55c8",
                haveSport,
                FontAwesome.soccer_ball_o,
                "Olah Raga",
                haveSport ? ClassColors.maincolor : Colors.grey,
              ),
              buildItemTopics(
                6,
                "606023bf0bcfc713404c55c7",
                haveHealth,
                FontAwesome.plus,
                "Kesehatan",
                haveHealth ? ClassColors.maincolor : Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildItemTopics(
    int id,
    String topicId,
    bool condition,
    IconData icon,
    String title,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(id == 3 ? width * 0.05 : 0),
            topLeft: Radius.circular(id == 1 ? width * 0.05 : 0),
            bottomRight: Radius.circular(id == 6 ? width * 0.05 : 0),
            bottomLeft: Radius.circular(id == 4 ? width * 0.05 : 0),
          ),
          child: MaterialButton(
            padding: EdgeInsets.all(width * 0.04),
            onLongPress: () {
              if (id != 1) {
                if (condition) {
                  dialogTopic(topicId, isRemove: true);
                }
              }
            },
            onPressed: () {
              String topicName = id == 1
                  ? "news"
                  : id == 2
                      ? "travel"
                      : id == 3
                          ? "tech"
                          : id == 4
                              ? "seleb"
                              : id == 5
                                  ? "sport"
                                  : "health";
              if (condition) {
                nextPage(
                  context,
                  ListPublisherAndTopicsPage(
                    from: "topic",
                    image: ImageBoarding.newspaper,
                    name: title,
                    topicName: topicName,
                    iconData: icon,
                  ),
                );
              } else {
                dialogTopic(topicId);
              }
            },
            child: Column(
              children: [
                Icon(
                  icon,
                  size: width * 0.055,
                  color: iconColor,
                ),
                sarabunText(
                  width * 0.033,
                  title,
                  th: 2.2,
                  color: iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dialogTopic(String id, {bool isRemove = false}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return customDialogBox(
            title: isRemove ? "Hapus Topik" : "Tambah Topik",
            descriptions: isRemove
                ? "Apakah anda yakin ingin menghapus topik ini ?"
                : "Apakah anda yakin ingin menambahkan topik ini ?",
            iconData: isRemove ? Icons.delete : FontAwesome.unlock,
            text: isRemove ? "Hapus" : "Tambahkan",
            condition: isRemove,
            idTopic: id,
          );
        });
  }

  Widget customDialogBox(
      {String idTopic,
      String title,
      String descriptions,
      String text,
      IconData iconData,
      bool condition}) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.03),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(
        idTopic,
        title,
        descriptions,
        text,
        iconData,
        condition,
      ),
    );
  }

  Widget contentBox(
    String idTopic,
    String title,
    String descriptions,
    String text,
    IconData iconData,
    bool condition,
  ) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[700],
                  offset: Offset(0, 10),
                  blurRadius: 6,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: width * 0.05, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: height * 0.01),
              Text(
                descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.03),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: width * 0.25,
                        height: height * 0.045,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ClassColors.maincolor),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            "Batal",
                            style: TextStyle(
                              fontSize: width * 0.035,
                              color: ClassColors.maincolor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    InkWell(
                      onTap: () {
                        if (condition) {
                          removeTopicAction(idTopic);
                        } else {
                          addTopicAction(idTopic);
                        }
                      },
                      child: Container(
                        width: width * 0.25,
                        height: height * 0.045,
                        decoration: BoxDecoration(
                          color: ClassColors.maincolor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: width * 0.035,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: width * 0.22,
          right: width * 0.22,
          child: Container(
            width: width * 0.2,
            height: width * 0.22,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(0, 3),
                    blurRadius: 3,
                  ),
                ]),
            child: Icon(
              iconData,
              size: width * 0.08,
              color: ClassColors.maincolor,
            ),
          ),
        ),
      ],
    );
  }

  Widget logoutButton() {
    return Container(
      width: width,
      height: height * 0.055,
      decoration: BoxDecoration(
        color: ClassColors.maincolor,
        borderRadius: BorderRadius.circular(width * 0.02),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.02),
        child: MaterialButton(
          onPressed: () {
            logoutAction();
          },
          child: montserratText(
            width * 0.035,
            "Keluar",
            fw: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildUnloginPage() {
    return Stack(
      children: [
        Image.asset(
          ImageBoarding.read2,
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
                  "Pilih Topic\nFavoritmu Dengan Log In",
                  fw: FontWeight.bold,
                  ta: TextAlign.center,
                  th: 1.2,
                ),
                Column(
                  children: [
                    inputLogin(emailInput, "Email"),
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
                              from: "profile",
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
