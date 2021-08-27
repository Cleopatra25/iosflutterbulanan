import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/screens/historytransaksi/components/content_transaksi.dart';
import 'package:bulanan/screens/historytransaksi/components/custom_tab.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyTransaction extends StatefulWidget {
  final String position;

  BodyTransaction({
    Key key,
    this.position,
  }) : super(key: key);
  @override
  _BodyTransactionState createState() => _BodyTransactionState();
}

class _BodyTransactionState extends State<BodyTransaction> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';
  List<String> data = ['Semua', 'Menunggu', 'Diproses', 'Selesai', 'Cancel'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Headers(
            tittle: 'History Transaksi',
            routename: HomeScreen.routeName,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(
              top: getProportionateScreenHeight(100),
              bottom: getProportionateScreenHeight(50)),
          child: FutureBuilder(
            future: getPreference(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _buildtab(context);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }

  CustomTabView _buildtab(BuildContext context) {
    return CustomTabView(
      initPosition: int.parse(widget.position),
      itemCount: data.length,
      tabBuilder: (context, index) {
        return Tab(
          text: data[index],
        );
      },
      pageBuilder: (context, index) {
        return ContentTransaksi(
          position: index,
          idMember: idMember,
          idCity: idCity,
          idDevice: idDevice,
          authHeader: authHeader,
        );
      },
    );
  }

  Future<String> getPreference() async {
    SharedPreferences myshare = await SharedPreferences.getInstance();
    idCity = myshare.getString('id_city') ?? '3271';
    idDevice = myshare.getString('id_device') ?? '';
    idMember = myshare.getString('id_member') ?? '';
    authHeader = myshare.getString('auth') ?? '';
    nameCity = myshare.getString('name_city') ?? 'Bogor';
    return idCity;
  }
}
