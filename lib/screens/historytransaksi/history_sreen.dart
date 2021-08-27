import 'package:flutter/material.dart';
import 'package:bulanan/screens/cekmutasi/components/bodycekmutasi.dart';
import 'package:bulanan/screens/historytransaksi/components/bodytransaction.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import 'package:bulanan/screens/webview/components/bodywebview.dart';

class HistoryTransaksi extends StatefulWidget {
  static String routeName = "/transaksi";

  @override
  _HistoryTransaksiState createState() => _HistoryTransaksiState();
}

class _HistoryTransaksiState extends State<HistoryTransaksi> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String position = '0';

    if (arguments != null) {
      position = arguments['position'];
    }
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          return true;
        },
        child: Scaffold(
          body: BodyTransaction(position: position),
        ));
  }
}
