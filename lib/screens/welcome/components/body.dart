import 'package:flutter/material.dart';
import 'package:bulanan/constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                height: getProportionateScreenHeight(265),
                width: getProportionateScreenWidth(235),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
