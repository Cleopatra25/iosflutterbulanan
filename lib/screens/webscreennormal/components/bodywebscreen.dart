import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyWebScreen extends StatefulWidget {
  final String url;
  BodyWebScreen({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  _BodyWebScreenState createState() => _BodyWebScreenState();
}

class _BodyWebScreenState extends State<BodyWebScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Headers(tittle: 'Bulanan', routename: HomeScreen.routeName),
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        )
      ],
    );
  }
}
