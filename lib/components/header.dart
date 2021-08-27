import 'package:flutter/material.dart';
import 'package:bulanan/constants.dart';

import '../size_config.dart';

// ignore: must_be_immutable
class Headers extends StatefulWidget {
  String tittle;
  String routename;

  Headers({Key key, this.tittle, this.routename}) : super(key: key);

  @override
  _HeadersState createState() => _HeadersState();
}

class _HeadersState extends State<Headers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      height: getProportionateScreenHeight(60),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenWidth(13)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/images/left_arrow_white.png",
                  width: getProportionateScreenWidth(23),
                  height: getProportionateScreenHeight(23),
                ),
              ),
              splashColor: kPrimaryColor,
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: buildtextbold(widget.tittle, kTextWhite),
          ),
        ],
      ),
    );
  }
}
