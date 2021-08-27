import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyWebview extends StatefulWidget {
  final String url;
  BodyWebview({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  _BodyWebviewState createState() => _BodyWebviewState();
}

class _BodyWebviewState extends State<BodyWebview> {
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
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('gojek://')) {
          print('blocking navigation to $request}');
          _launchURL(request.toString());
          return NavigationDecision.prevent;
        }

        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
