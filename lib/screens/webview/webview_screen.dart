import 'package:flutter/material.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import 'package:bulanan/screens/webview/components/bodywebview.dart';

class WebviewScreen extends StatefulWidget {
  static String routeName = "/weviews";

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String url = '';

    if (arguments != null) {
      url = arguments['url'];
    }
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
            arguments: {
              'pesan':
                  'Pesanan Anda sudah kami terima\nPeriksa kembali status pembayaran pesanan anda\n\nuntuk melihat pesanan anda buka menu notifikasi atau di bilah menu -> transaksi'
            },
          );
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          return true;
        },
        child: Scaffold(
          body: BodyWebview(
            url: url,
          ),
        ));
  }
}
