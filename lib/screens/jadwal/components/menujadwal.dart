import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Menujadwal extends StatefulWidget {
  final Function changewaktu;
  Menujadwal({
    Key key,
    this.changewaktu,
  }) : super(key: key);

  @override
  _MenujadwalState createState() => _MenujadwalState();
}

class _MenujadwalState extends State<Menujadwal> {
  Color colorBacgsemua = kPrimaryColor;
  Color colorBacgpromo = kTextWhite;
  Color colorBacgterlaris = kTextWhite;
  Color colorbacgflashsale = kTextWhite;
  Color colortextsemua = kTextWhite;
  Color colortextpromo = kTextColor;
  Color colortextterlaris = kTextColor;
  Color colortextflashsale = kTextColor;
  String status = 'semua';
  String idDevice = '';
  String idCity = '';
  String idMember = '';
  void gantibackground(String kode) {
    setState(() {
      if (kode == 'hariini') {
        colorBacgsemua = kPrimaryColor;
        colorBacgpromo = kTextWhite;
        colorBacgterlaris = kTextWhite;
        colorbacgflashsale = kTextWhite;
        colortextsemua = kTextWhite;
        colortextpromo = kTextColor;
        colortextterlaris = kTextColor;
        colortextflashsale = kTextColor;
        status = 'hariini';
        widget.changewaktu(kode);
      } else if (kode == 'besok') {
        colorBacgsemua = kTextWhite;
        colorBacgpromo = kPrimaryColor;
        colorBacgterlaris = kTextWhite;
        colortextsemua = kTextColor;
        colortextpromo = kTextWhite;
        colortextterlaris = kTextColor;
        status = 'besok';
        widget.changewaktu(kode);
      } else if (kode == 'lusa') {
        colorBacgsemua = kTextWhite;
        colorBacgpromo = kTextWhite;
        colorBacgterlaris = kPrimaryColor;
        colortextsemua = kTextColor;
        colortextpromo = kTextColor;
        colortextterlaris = kTextWhite;
        status = 'lusa';
        widget.changewaktu(kode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            gantibackground('hariini');
          },
          child: Wrap(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  top: getProportionateScreenWidth(8),
                  bottom: getProportionateScreenWidth(8),
                ),
                padding: EdgeInsets.only(
                  right: getProportionateScreenWidth(18),
                  left: getProportionateScreenWidth(18),
                  top: getProportionateScreenWidth(8),
                  bottom: getProportionateScreenWidth(8),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorBacgsemua,
                  border: Border.all(color: kSecondaryColor),
                ),
                child: Text.rich(TextSpan(
                  style: TextStyle(
                    color: colortextsemua,
                    fontSize: getProportionateScreenHeight(10),
                  ),
                  text: 'Hari Ini',
                )),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            gantibackground('besok');
          },
          child: Wrap(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(5),
                  top: getProportionateScreenWidth(8),
                  bottom: getProportionateScreenWidth(8),
                ),
                padding: EdgeInsets.only(
                  right: getProportionateScreenWidth(18),
                  left: getProportionateScreenWidth(18),
                  top: getProportionateScreenWidth(8),
                  bottom: getProportionateScreenWidth(8),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorBacgpromo,
                  border: Border.all(color: kSecondaryColor),
                ),
                child: Text.rich(TextSpan(
                  style: TextStyle(
                    color: colortextpromo,
                    fontSize: getProportionateScreenHeight(10),
                  ),
                  text: 'Besok',
                )),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            gantibackground('lusa');
          },
          child: Wrap(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(5),
                  top: getProportionateScreenWidth(8),
                  bottom: getProportionateScreenWidth(8),
                ),
                padding: EdgeInsets.only(
                  right: getProportionateScreenWidth(18),
                  left: getProportionateScreenWidth(18),
                  top: getProportionateScreenWidth(8),
                  bottom: getProportionateScreenWidth(8),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorBacgterlaris,
                  border: Border.all(color: kSecondaryColor),
                ),
                child: Text.rich(TextSpan(
                  style: TextStyle(
                    color: colortextterlaris,
                    fontSize: getProportionateScreenHeight(10),
                  ),
                  text: 'Lusa',
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
