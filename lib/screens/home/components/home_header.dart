import 'package:flutter/material.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/screens/historytransaksi/history_sreen.dart';
import 'package:bulanan/screens/notification/notification.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'chatbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class HomeHeader extends StatefulWidget {
  String idCitys;
  String nameCitys;
  HomeHeader({Key key, this.nameCitys, this.idCitys}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      height: getProportionateScreenWidth(45),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(8),
          vertical: getProportionateScreenWidth(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/images/left_menu.png",
                  width: getProportionateScreenWidth(15),
                  height: getProportionateScreenWidth(15),
                ),
              ),
              splashColor: kPrimaryColor,
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: SearchField(
              idCitys: widget.idCitys,
              nameCitys: widget.nameCitys,
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenHeight(8),
                ),
                child: Chatbutton(),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                child: Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            border: Border.all(color: kTextWhite, width: 2),
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(20))),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: buildimagescustom(
                            'assets/images/notif_white.png',
                            getProportionateScreenWidth(20),
                            getProportionateScreenWidth(20)),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Notifikasi.routeName,
                  ).then((value) {
                    setState(() {});
                    print('were back');
                  });
                },
              ))
        ],
      ),
    );
  }
}
