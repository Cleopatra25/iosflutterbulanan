import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/models/ModelAlamat.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/screens/addalamat/addalamatscreen.dart';
import 'package:bulanan/screens/cart/components/cartcontent.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/checkout/components/checkoutcomponent.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/screens/jadwal/components/menujadwal.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BodyJadwal extends StatefulWidget {
  @override
  _BodyJadwalState createState() => _BodyJadwalState();
}

class _BodyJadwalState extends State<BodyJadwal> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';
  List<Map<String, String>> jadwallist;
  DateTime now = DateTime.now();
  bool valDate = false;
  String waktu = 'hariini';

  void changewaktu(String waktus) {
    print('waktunya $waktus');
    setState(() {
      waktu = waktus;
    });
  }

  @override
  void initState() {
    jadwallist = [
      {
        'jadwal': '09:00 - 10:00',
        'waktu': DateTime(now.year, now.month, now.day, 9, 0).toString()
      },
      {
        'jadwal': '10:00 - 11:00',
        'waktu': DateTime(now.year, now.month, now.day, 10, 0).toString()
      },
      {
        'jadwal': '11:00 - 12:00',
        'waktu': DateTime(now.year, now.month, now.day, 11, 0).toString()
      },
      {
        'jadwal': '12:00 - 13:00',
        'waktu': DateTime(now.year, now.month, now.day, 12, 0).toString()
      },
      {
        'jadwal': '13:00 - 14:00',
        'waktu': DateTime(now.year, now.month, now.day, 13, 0).toString()
      },
      {
        'jadwal': '14:00 - 15:00',
        'waktu': DateTime(now.year, now.month, now.day, 14, 0).toString()
      },
      {
        'jadwal': '15:00 - 16:00',
        'waktu': DateTime(now.year, now.month, now.day, 15, 0).toString()
      },
      {
        'jadwal': '16:00 - 17:00',
        'waktu': DateTime(now.year, now.month, now.day, 16, 0).toString()
      },
      {
        'jadwal': '17:00 - 18:00',
        'waktu': DateTime(now.year, now.month, now.day, 17, 0).toString()
      },
      {
        'jadwal': '18:00 - 19:00',
        'waktu': DateTime(now.year, now.month, now.day, 18, 0).toString()
      },
      {
        'jadwal': '19:00 - 20:00',
        'waktu': DateTime(now.year, now.month, now.day, 19, 0).toString()
      },
    ];

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
              tittle: 'Pilih Jadwal Pengiriman',
              routename: HomeScreen.routeName),
        ),
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(40),
          margin: EdgeInsets.only(top: getProportionateScreenHeight(94)),
          child: Menujadwal(changewaktu: changewaktu),
        ),
        if (waktu == 'hariini') ...[
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(139)),
            child: _buildJadwallist(context),
          ),
        ] else ...[
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(139)),
            child: _buildJadwallistbesok(context, waktu),
          ),
        ]
      ],
    );
  }

  ListView _buildJadwallist(BuildContext context) {
    return ListView.builder(
      itemCount: jadwallist.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        DateTime dateTime = DateTime.parse(jadwallist[index]['waktu']);
        DateTime dateTimeplush2 = dateTime.add(Duration(hours: -2));
        DateTime nows = DateTime(
            now.year, now.month, now.day, now.hour, now.minute, now.second);

        valDate = dateTimeplush2.isAfter(nows);
        if (valDate) {
          return Card(
              margin: EdgeInsets.all(getProportionateScreenWidth(8)),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  String jadwalnya = jadwallist[index]['jadwal'];
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                  Navigator.pop(context,
                      'Hari ini tanggal: $formattedDate\nPukul:  $jadwalnya');
                },
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: accentColortransparent),
                      width: double.infinity,
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(50),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: buildtextSizeleft(jadwallist[index]['jadwal'],
                              Colors.black87, getProportionateScreenWidth(12))),
                    ),
                    Container(
                      width: getProportionateScreenWidth(80),
                      height: getProportionateScreenWidth(20),
                      margin: EdgeInsets.only(
                          bottom: getProportionateScreenWidth(20),
                          right: getProportionateScreenWidth(20)),
                      decoration: BoxDecoration(
                        color: kTextWhite,
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(4)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: buildtextSize('Pilih Jadwal', kPrimaryColor,
                            getProportionateScreenWidth(10)),
                      ),
                    ),
                  ],
                ),
              ));
        } else {
          int ai = jadwallist.length - 1;
          print('indexnya $index');
          print('indexnya $ai');
          print(jadwallist.length);
          if (index == jadwallist.length - 1) {
            return Container(
              width: getProportionateScreenHeight(100),
              height: getProportionateScreenWidth(100),
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              child: Align(
                alignment: Alignment.center,
                child: buildtextSizecenter(
                    'Maaf Hari ini Kami sudah tutup pilih pengiriman di hari besok',
                    kPrimaryColor,
                    getProportionateScreenWidth(14)),
              ),
            );
          } else {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
        }
      },
    );
  }

  ListView _buildJadwallistbesok(BuildContext context, String kode) {
    return ListView.builder(
        itemCount: jadwallist.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(getProportionateScreenWidth(8)),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                if (kode == 'besok') {
                  String jadwalnya = jadwallist[index]['jadwal'];
                  DateTime now = DateTime.now();
                  DateTime lusa = now.add(Duration(days: 1));
                  String formattedDate = DateFormat('yyyy-MM-dd').format(lusa);
                  Navigator.pop(context,
                      'Besok tanggal: $formattedDate\nPukul:  $jadwalnya');
                } else {
                  String jadwalnya = jadwallist[index]['jadwal'];
                  DateTime now = DateTime.now();
                  DateTime lusa = now.add(Duration(days: 2));
                  String formattedDate = DateFormat('yyyy-MM-dd').format(lusa);
                  Navigator.pop(context,
                      'Lusa tanggal: $formattedDate\nPukul:  $jadwalnya');
                }
              },
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    decoration: BoxDecoration(color: accentColortransparent),
                    width: double.infinity,
                    padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    height: getProportionateScreenWidth(50),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: buildtextSizeleft(jadwallist[index]['jadwal'],
                            Colors.black87, getProportionateScreenWidth(12))),
                  ),
                  Container(
                    width: getProportionateScreenWidth(80),
                    height: getProportionateScreenWidth(20),
                    margin: EdgeInsets.only(
                        bottom: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(20)),
                    decoration: BoxDecoration(
                      color: kTextWhite,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius:
                          BorderRadius.circular(getProportionateScreenWidth(4)),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: buildtextSize('Pilih Jadwal', kPrimaryColor,
                          getProportionateScreenWidth(10)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
