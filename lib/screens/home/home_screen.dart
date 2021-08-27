import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'components/drawer.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String pesan = '';

    if (arguments != null) {
      pesan = arguments['pesan'];
      Future.delayed(Duration.zero, () => showAlert(context, pesan));
    }

    return Scaffold(body: Body(), drawer: Drawers());
  }

  void showAlert(BuildContext context, String pesans) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext contexts) {
          return Dialog(
              child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            width: double.infinity,
            height: getProportionateScreenHeight(330),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildtextSize('Info Pesanan', Colors.black87,
                    getProportionateScreenWidth(15)),
                SizedBox(
                  height: 12,
                ),
                Align(
                    alignment: Alignment.center,
                    child: buildtextSizecentersoft(pesans, Colors.black87,
                        getProportionateScreenWidth(15))),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(contexts);
                    },
                    child: Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(40),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(4)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: buildtextSize('Baiklah', kTextWhite,
                            getProportionateScreenWidth(11)),
                      ),
                    ))
              ],
            ),
          ));
        });
  }
}
