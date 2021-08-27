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

import '../../../constants.dart';
import '../../../size_config.dart';

class BodyChekout extends StatefulWidget {
  @override
  _BodyChekoutState createState() => _BodyChekoutState();
}

class _BodyChekoutState extends State<BodyChekout> {
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
          child: Headers(tittle: 'Checkout', routename: HomeScreen.routeName),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: getProportionateScreenHeight(100)),
          child: FutureBuilder(
            future: getPreference(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Chekcoutcomponents(
                  idCity: idCity,
                  idDevice: idDevice,
                  idMember: idMember,
                  authheader: authHeader,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
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
