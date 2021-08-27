import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class CheckoutPembayaran extends StatefulWidget {
  String paymentgateway;
  final Function pembayaran;

  CheckoutPembayaran({
    Key key,
    this.paymentgateway,
    this.pembayaran,
  }) : super(key: key);

  @override
  _CheckoutPembayaranState createState() => _CheckoutPembayaranState();
}

class _CheckoutPembayaranState extends State<CheckoutPembayaran> {
  String cekcod = 'assets/images/cek_inaktif.png';
  String cektransfer = 'assets/images/cek_inaktif.png';
  String cekbo = 'assets/images/cek_inaktif.png';

  Color ccod = Colors.black12;
  Color ctransfer = Colors.black12;
  Color ccbo = Colors.black12;

  void changebackground(token) {
    setState(() {
      if (token == 'COD') {
        cekcod = 'assets/images/cek_aktif.png';
        cektransfer = 'assets/images/cek_inaktif.png';
        cekbo = 'assets/images/cek_inaktif.png';

        ccod = kPrimaryColor;
        ctransfer = Colors.black12;
        ccbo = Colors.black12;
        widget.paymentgateway = 'COD';
        widget.pembayaran(token);
      } else if (token == 'Cekmutasi') {
        cekcod = 'assets/images/cek_inaktif.png';
        cektransfer = 'assets/images/cek_aktif.png';
        cekbo = 'assets/images/cek_inaktif.png';

        ctransfer = kPrimaryColor;
        ccod = Colors.black12;
        ccbo = Colors.black12;
        widget.paymentgateway = 'Cekmutasi';
        widget.pembayaran(token);
      } else if (token == 'Midtrans') {
        cekcod = 'assets/images/cek_inaktif.png';
        cektransfer = 'assets/images/cek_inaktif.png';
        cekbo = 'assets/images/cek_aktif.png';

        ccbo = kPrimaryColor;
        ccod = Colors.black12;
        ctransfer = Colors.black12;
        widget.paymentgateway = 'Midtrans';
        widget.pembayaran(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            changebackground('COD');
          },
          child: Container(
            width: double.infinity,
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              color: kTextWhite,
              border: Border.all(color: ccod),
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(4)),
            ),
            child: Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenWidth(20),
                  child: buildimagescustom(
                      cekcod,
                      getProportionateScreenWidth(20),
                      getProportionateScreenWidth(20)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(45),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/cod.png",
                      getProportionateScreenWidth(50),
                      getProportionateScreenWidth(40)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/link_aja.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/ovo.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/dana.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/gopay.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            changebackground('Cekmutasi');
          },
          child: Container(
            width: double.infinity,
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              color: kTextWhite,
              border: Border.all(color: ctransfer),
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(4)),
            ),
            child: Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenWidth(20),
                  child: buildimagescustom(
                      cektransfer,
                      getProportionateScreenWidth(20),
                      getProportionateScreenWidth(20)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(45),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/bank_transfer.png",
                      getProportionateScreenWidth(50),
                      getProportionateScreenWidth(40)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/bcapng.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            changebackground('Midtrans');
          },
          child: Container(
            width: double.infinity,
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              color: kTextWhite,
              border: Border.all(color: ccbo),
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(4)),
            ),
            child: Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenWidth(20),
                  child: buildimagescustom(
                      cekbo,
                      getProportionateScreenWidth(20),
                      getProportionateScreenWidth(20)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(45),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/bayar_online.png",
                      getProportionateScreenWidth(50),
                      getProportionateScreenWidth(40)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/visa.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/master_card.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  child: buildimagescustom(
                      "assets/images/gopay.png",
                      getProportionateScreenWidth(35),
                      getProportionateScreenWidth(35)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
