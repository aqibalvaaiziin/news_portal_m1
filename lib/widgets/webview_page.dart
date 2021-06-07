import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news/helpers/global.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewNews extends StatefulWidget {
  final String url;
  final String title;

  const WebviewNews({Key key, this.url, this.title}) : super(key: key);
  @override
  WebviewNewsState createState() => WebviewNewsState();
}

class WebviewNewsState extends State<WebviewNews> {
  double width;
  double height;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ClassColors.maincolor,
        title: sarabunText(
          width * 0.04,
          widget.title,
          color: Colors.white,
          fw: FontWeight.bold,
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
