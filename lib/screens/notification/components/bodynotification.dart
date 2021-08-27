import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/screens/historytransaksi/history_sreen.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BodyNotification extends StatefulWidget {
  @override
  _BodyNotificationState createState() => _BodyNotificationState();

  BodyNotification({
    Key key,
  }) : super(key: key);
}

class _BodyNotificationState extends State<BodyNotification> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';

  @override
  void initState() {
    getPreference();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Headers(
            tittle: 'Notifikasi',
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
                return buildlayoutnotif();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }

  Column buildlayoutnotif() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: buildtextSize('Transaksi Anda', Colors.black87,
                getProportionateScreenWidth(14)),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              flex: 25,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      HistoryTransaksi.routeName,
                      arguments: {
                        'position': '1',
                      },
                    ).then((value) {
                      print('were back');
                    });
                  },
                  child: Column(
                    children: [
                      buildimagescustom(
                          'assets/images/pending.png',
                          getProportionateScreenWidth(30),
                          getProportionateScreenWidth(30)),
                      buildtextSize('Pending', Colors.black87,
                          getProportionateScreenWidth(11))
                    ],
                  )),
            ),
            Expanded(
              flex: 25,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      HistoryTransaksi.routeName,
                      arguments: {
                        'position': '2',
                      },
                    ).then((value) {
                      print('were back');
                    });
                  },
                  child: Column(
                    children: [
                      buildimagescustom(
                          'assets/images/ongoing.png',
                          getProportionateScreenWidth(30),
                          getProportionateScreenWidth(30)),
                      buildtextSize('Di prosess', Colors.black87,
                          getProportionateScreenWidth(11))
                    ],
                  )),
            ),
            Expanded(
              flex: 25,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      HistoryTransaksi.routeName,
                      arguments: {
                        'position': '3',
                      },
                    ).then((value) {
                      print('were back');
                    });
                  },
                  child: Column(
                    children: [
                      buildimagescustom(
                          'assets/images/done.png',
                          getProportionateScreenWidth(30),
                          getProportionateScreenWidth(30)),
                      buildtextSize('Selesai', Colors.black87,
                          getProportionateScreenWidth(11))
                    ],
                  )),
            ),
            Expanded(
              flex: 25,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      HistoryTransaksi.routeName,
                      arguments: {
                        'position': '4',
                      },
                    ).then((value) {
                      print('were back');
                    });
                  },
                  child: Column(
                    children: [
                      buildimagescustom(
                          'assets/images/process.png',
                          getProportionateScreenWidth(30),
                          getProportionateScreenWidth(30)),
                      buildtextSize('Batal', Colors.black87,
                          getProportionateScreenWidth(11))
                    ],
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(2),
          decoration: BoxDecoration(color: Colors.black12),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: buildtextSize(
                'Untuk Kamu', Colors.black87, getProportionateScreenWidth(14)),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Card(
            child: Container(
              height: getProportionateScreenHeight(70),
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Promo Akun Baru', Colors.black87,
                        getProportionateScreenWidth(12)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: buildtextSize(
                        'Gunakan voucher BULANANBARU3 untuk mendapatkan potongan harga Rp 15.000',
                        kTextColor,
                        getProportionateScreenWidth(11)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Card(
            child: Container(
              height: getProportionateScreenHeight(70),
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Gratis ongkir', Colors.black87,
                        getProportionateScreenWidth(12)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: buildtextSize(
                        'kalo kamu belanja di atas Rp 20.000 kita kasi gratis ongkir loh',
                        kTextColor,
                        getProportionateScreenWidth(11)),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
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
