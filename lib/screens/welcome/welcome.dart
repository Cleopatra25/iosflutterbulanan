import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/screens/splash/splash_screen.dart';
import 'package:bulanan/size_config.dart';

class Welcome extends StatefulWidget {
  static String routeName = "/welcome";

  @override
  _Welcomestate createState() => _Welcomestate();
}

class _Welcomestate extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    loadwidget();
  }

  loadwidget() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, toGreeting);
  }

  Future<void> toGreeting() async {
    String isi;
    String idDevice;
    String idCity;
    String idMember;
    SharedPreferences myshare = await SharedPreferences.getInstance();
    isi = myshare.getString('loged');
    idDevice = myshare.getString('id_device');
    idCity = myshare.getString('id_city');

    if (isi.toString() == "true") {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SplashScreen.routeName);
    }
    if (idDevice == null) {
      SharedPreferences myshare = await SharedPreferences.getInstance();
      await myshare.setString("id_device", getRandomString(10));
      print(getRandomString(16));

      print(idDevice);
      print('ada');
    } else {
      print(idDevice);
      print(idCity);
      print('gada');
    }
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                "assets/images/logo_white.png",
                width: getProportionateScreenHeight(265),
                height: getProportionateScreenHeight(235),
              ),
            )
          ],
        ),
      ),
    );
  }
}
