import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyCekmutasi extends StatefulWidget {
  final String invoice;
  final String totaltransaksi;
  final String auth;
  final Timer times;

  BodyCekmutasi({
    Key key,
    this.invoice,
    this.totaltransaksi,
    this.auth,
    this.times,
  }) : super(key: key);
  @override
  _BodyCekmutasiState createState() => _BodyCekmutasiState();
}

class _BodyCekmutasiState extends State<BodyCekmutasi> {
  Timer _timer;
  bool isloading = true;
  String status = 'pending';

  @override
  void initState() {
    super.initState();
    starttimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Card(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(getProportionateScreenWidth(10)),
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Column(
            children: [
              buildtextSize('Hai Pesanan Kamu Hampir selesai', Colors.black87,
                  getProportionateScreenWidth(15)),
              buildtextSize('Bayar pesanan kamu sekarang', Colors.black54,
                  getProportionateScreenWidth(11)),
              SizedBox(
                height: 22,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildimagescustom(
                      'assets/images/bcapng.png',
                      getProportionateScreenWidth(40),
                      getProportionateScreenWidth(30)),
                  SizedBox(
                    width: 12,
                  ),
                  buildtextSize('0953910303', kPrimaryColors,
                      getProportionateScreenWidth(20)),
                  SizedBox(
                    width: 22,
                  ),
                  GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('disalin ke clipboard'),
                        ));
                        Clipboard.setData(ClipboardData(text: "0953910303"));
                      },
                      child: Container(
                        width: getProportionateScreenWidth(60),
                        height: getProportionateScreenWidth(30),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(3))),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize('Copy', kTextWhite,
                              getProportionateScreenHeight(11)),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              buildtextSize('Total Pembayaran', Colors.black87,
                  getProportionateScreenWidth(12)),
              SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildtextSize(
                      NumberFormat.currency(locale: 'id', name: 'Rp ')
                          .format(int.parse(widget.totaltransaksi)),
                      Colors.black87,
                      getProportionateScreenWidth(15)),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('disalin ke clipboard'),
                        ));
                        Clipboard.setData(ClipboardData(text: "0953910303"));
                      },
                      child: Container(
                        width: getProportionateScreenWidth(60),
                        height: getProportionateScreenWidth(30),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(3))),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize('Copy', kTextWhite,
                              getProportionateScreenHeight(11)),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              buildtextSizecenter(
                  'Silahkan transfer sesuai nilai total yang tercantum untuk memudahkan verifikasi.\n Sistem akan memverifikasi pembayaran selama 5 - 10 menit setelah melakukan transfer',
                  Colors.black87,
                  getProportionateScreenWidth(11)),
              SizedBox(
                height: 22,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildtextSize('Status Pembayaran', Colors.black87,
                      getProportionateScreenWidth(12)),
                  SizedBox(
                    width: 10,
                  ),
                  buildtextSize(
                      status, kPrimaryColor, getProportionateScreenWidth(12)),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              if (isloading) ...[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ]
            ],
          ),
        ),
      ),
    ));
  }

  void starttimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (callback) {
      registerAccount();
    });
  }

  void registerAccount() async {
    // setState(() {
    //   isloading = true;
    // });
    final response = await Provider.of<NetworkApiService>(context,
            listen: false)
        .postCekmutasi(
            'sembako168', widget.auth, widget.invoice, widget.totaltransaksi);

    print(response.body);

    if (response.body['status'] == true) {
      setState(() {
        isloading = false;
        status = response.body['message'];
      });
      _timer.cancel();
      // setState(() {
      //   isloading = false;
      // });

    }
  }
}
