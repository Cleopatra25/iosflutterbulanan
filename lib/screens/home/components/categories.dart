import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
      if (kode == 'semua') {
        colorBacgsemua = kPrimaryColor;
        colorBacgpromo = kTextWhite;
        colorBacgterlaris = kTextWhite;
        colorbacgflashsale = kTextWhite;
        colortextsemua = kTextWhite;
        colortextpromo = kTextColor;
        colortextterlaris = kTextColor;
        colortextflashsale = kTextColor;
        status = 'semua';
      } else if (kode == 'promo') {
        colorBacgsemua = kTextWhite;
        colorBacgpromo = kPrimaryColor;
        colorBacgterlaris = kTextWhite;
        colorbacgflashsale = kTextWhite;
        colortextsemua = kTextColor;
        colortextpromo = kTextWhite;
        colortextterlaris = kTextColor;
        colortextflashsale = kTextColor;
        status = 'promo';
      } else if (kode == 'terlaris') {
        colorBacgsemua = kTextWhite;
        colorBacgpromo = kTextWhite;
        colorBacgterlaris = kPrimaryColor;
        colorbacgflashsale = kTextWhite;
        colortextsemua = kTextColor;
        colortextpromo = kTextColor;
        colortextterlaris = kTextWhite;
        colortextflashsale = kTextColor;
        status = 'terlaris';
      } else if (kode == 'flashsale') {
        colorBacgsemua = kTextWhite;
        colorBacgpromo = kTextWhite;
        colorBacgterlaris = kTextWhite;
        colorbacgflashsale = kPrimaryColor;
        colortextsemua = kTextColor;
        colortextpromo = kTextColor;
        colortextterlaris = kTextColor;
        colortextflashsale = kTextWhite;
        status = 'flashsale';
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
            gantibackground('semua');
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
                  text: 'Semua',
                )),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            gantibackground('promo');
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
                  text: 'Promo',
                )),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            gantibackground('terlaris');
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
                  text: 'Terlaris',
                )),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            gantibackground('flashsale');
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
                  color: colorbacgflashsale,
                  border: Border.all(color: kSecondaryColor),
                ),
                child: Text.rich(TextSpan(
                  style: TextStyle(
                    color: colortextflashsale,
                    fontSize: getProportionateScreenHeight(10),
                  ),
                  text: 'Flash sale',
                )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
