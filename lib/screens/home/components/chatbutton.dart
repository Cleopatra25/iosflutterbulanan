import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Chatbutton extends StatelessWidget {
  const Chatbutton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.white, width: getProportionateScreenWidth(1.8)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 8,
            ),
            child: Image.asset(
              "assets/images/whatsapp.png",
              width: getProportionateScreenWidth(15),
              height: getProportionateScreenHeight(15),
            ),
          ),
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                  text: "Chat",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(13),
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
