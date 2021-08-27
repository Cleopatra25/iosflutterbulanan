import 'package:flutter/material.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import 'package:bulanan/screens/webview/components/bodywebview.dart';

class WebScreen extends StatefulWidget {
  static String routeName = "/weviews";

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String url = '';

    if (arguments != null) {
      url = arguments['url'];
    }
    return Scaffold(
      body: BodyWebview(
        url: url,
      ),
    );
  }
}
