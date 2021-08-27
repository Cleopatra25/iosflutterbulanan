import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class FlashsaleCountdown extends StatefulWidget {
  final String enddate;
  FlashsaleCountdown({Key key, this.enddate}) : super(key: key);

  @override
  _FlashsaleCountdownState createState() => _FlashsaleCountdownState();
}

class _FlashsaleCountdownState extends State<FlashsaleCountdown> {
  int _days = 0;
  int _hour = 0;
  int _minute = 0;
  int _sec = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    starttimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: getProportionateScreenWidth(5)),
          padding: EdgeInsets.all(getProportionateScreenHeight(4)),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(9)),
              color: kPrimaryColor),
          height: getProportionateScreenHeight(25),
          width: getProportionateScreenWidth(35),
          child: buildtextSize(
              '$_days H', kTextWhite, getProportionateScreenHeight(7)),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: getProportionateScreenWidth(5)),
          padding: EdgeInsets.all(getProportionateScreenHeight(4)),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(9)),
              color: kPrimaryColor),
          height: getProportionateScreenHeight(25),
          width: getProportionateScreenWidth(35),
          child: buildtextSize(
              '$_hour J', kTextWhite, getProportionateScreenHeight(7)),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: getProportionateScreenWidth(5)),
          padding: EdgeInsets.all(getProportionateScreenHeight(4)),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(9)),
              color: kPrimaryColor),
          height: getProportionateScreenHeight(25),
          width: getProportionateScreenWidth(35),
          child: buildtextSize(
              '$_minute M', kTextWhite, getProportionateScreenHeight(7)),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: getProportionateScreenWidth(5)),
          padding: EdgeInsets.all(getProportionateScreenHeight(4)),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(9)),
              color: kPrimaryColor),
          height: getProportionateScreenHeight(25),
          width: getProportionateScreenWidth(35),
          child: buildtextSize(
              '$_sec D', kTextWhite, getProportionateScreenHeight(7)),
        ),
      ],
    );
  }

  void timeleft(DateTime enddate) {
    Duration timelefts = enddate.difference(DateTime.now());
    _days = timelefts.inDays;
    _hour = timelefts.inHours - (_days * 24);
    _minute = timelefts.inMinutes - (_days * 24 * 60) - (_hour * 60);
    _sec = timelefts.inSeconds -
        (_days * 24 * 60 * 60) -
        (_hour * 60 * 60) -
        (_minute * 60);
  }

  void starttimer() {
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(widget.enddate);
    _timer = Timer.periodic(Duration(seconds: 1), (callback) {
      if (mounted) {
        setState(() {
          timeleft(tempDate);
        });
      }
    });
  }
}
