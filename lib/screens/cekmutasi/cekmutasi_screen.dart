import 'package:flutter/material.dart';
import 'package:bulanan/screens/cekmutasi/components/bodycekmutasi.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import 'package:bulanan/screens/webview/components/bodywebview.dart';

class Cekmutasi extends StatefulWidget {
  static String routeName = "/cekmutasi";

  @override
  _CekmutasiState createState() => _CekmutasiState();
}

class _CekmutasiState extends State<Cekmutasi> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String url = '';
    String totaltransaksi = '';
    String auth = '';

    if (arguments != null) {
      url = arguments['invoice'];
      totaltransaksi = arguments['totaltransaksi'];
      auth = arguments['auth'];
    }
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
            arguments: {
              'pesan':
                  'Pesanan Anda sudah kami terima\nPeriksa kembali status pembayaran anda \n\nuntuk melihat pesanan anda buka menu notifikasi atau di bilah menu -> transaksi'
            },
          );
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          return true;
        },
        child: Scaffold(
          body: BodyCekmutasi(
            invoice: url,
            totaltransaksi: totaltransaksi,
            auth: auth,
          ),
        ));
  }
}
