import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:news/helpers/global.dart';

class CustomScaffold extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AppBar appBar;
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const CustomScaffold({
    Key key,
    this.scaffoldKey,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  Future<bool> onPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: widget.appBar,
          key: widget.scaffoldKey,
          body: widget.body,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          bottomNavigationBar: widget.bottomNavigationBar,
        ),
      ),
    );
  }
}

Widget sarabunText(
  double width,
  String text, {
  FontWeight fw = FontWeight.normal,
  double lt = 0.2,
  double th = 1.0,
  Color color = Colors.black87,
  TextAlign ta = TextAlign.left,
  TextDecoration td = TextDecoration.none,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: width,
      fontFamily: "sarabun",
      fontWeight: fw,
      letterSpacing: lt,
      color: color,
      decoration: td,
      height: th,
      decorationThickness: 4,
    ),
    textAlign: ta,
  );
}

Widget montserratText(
  double width,
  String text, {
  FontWeight fw = FontWeight.normal,
  double lt = 0.2,
  double th = 1.0,
  Color color = Colors.black87,
  TextAlign ta = TextAlign.left,
  TextDecoration td = TextDecoration.none,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: width,
      fontFamily: "montserrat",
      fontWeight: fw,
      letterSpacing: lt,
      color: color,
      decoration: td,
      height: th,
      decorationThickness: 2,
    ),
    textAlign: ta,
  );
}

Widget isLoadAction(double width, double height, {bool isBlank = false}) {
  return SizedBox(
    width: width,
    height: height,
    child: Scaffold(
      backgroundColor: isBlank ? Colors.white : Colors.black.withOpacity(0.2),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(ClassColors.maincolor),
        ),
      ),
    ),
  );
}

Widget buildNoImage(
  double width,
  double height,
  double fontSize, {
  double radius = 0.0,
  bool isAllRadius = true,
  double radiusTopRight = 0.0,
  double radiusTopLeft = 0.0,
  double radiusBottomRight = 0.0,
  double radiusBottomLeft = 0.0,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.grey[700],
      borderRadius: !isAllRadius
          ? BorderRadius.only(
              topRight: Radius.circular(radiusTopRight),
              topLeft: Radius.circular(radiusTopRight),
              bottomRight: Radius.circular(radiusBottomRight),
              bottomLeft: Radius.circular(radiusBottomLeft),
            )
          : BorderRadius.circular(radius),
    ),
    child: Center(
      child: montserratText(
        fontSize,
        "No\nImage",
        ta: TextAlign.center,
        color: Colors.grey[300],
      ),
    ),
  );
}

Widget buildNetworkImage(
  double width,
  double height,
  String url, {
  BoxFit fit = BoxFit.contain,
  double radius = 0.0,
  bool isAllRadius = true,
  double radiusTopRight = 0.0,
  double radiusTopLeft = 0.0,
  double radiusBottomRight = 0.0,
  double radiusBottomLeft = 0.0,
}) {
  return ClipRRect(
    borderRadius: !isAllRadius
        ? BorderRadius.only(
            topRight: Radius.circular(radiusTopRight),
            topLeft: Radius.circular(radiusTopRight),
            bottomRight: Radius.circular(radiusBottomRight),
            bottomLeft: Radius.circular(radiusBottomLeft),
          )
        : BorderRadius.circular(radius),
    child: Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (
        BuildContext context,
        Widget widget,
        ImageChunkEvent loadingProgress,
      ) {
        if (loadingProgress == null) return widget;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget flushBar(
  BuildContext context,
  String title,
  String message,
  IconData icon, {
  Color color = Colors.grey,
}) {
  return Flushbar(
    icon: Icon(
      icon,
      color: Colors.black.withOpacity(0.4),
    ),
    borderRadius: BorderRadius.circular(4),
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor: color,
    title: title,
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(milliseconds: 1500),
  )..show(context);
}

Widget isLoadActionPage(double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.red),
        ),
      ),
    ),
  );
}
