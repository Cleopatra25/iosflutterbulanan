import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bulanan/screens/search/searchscreen.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({
    Key key,
  }) : super(key: key);

  @override
  _Searchbarstate createState() => _Searchbarstate();
}

class _Searchbarstate extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          SearchScreen.routeName,
        ).then((value) {
          setState(() {});
          print('were back');
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(10),
          top: getProportionateScreenHeight(10),
          bottom: getProportionateScreenHeight(10),
        ),
        height: SizeConfig.screenHeight * 0.045,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kSecondaryColor),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Image.asset(
                "assets/images/searchblack.png",
                width: getProportionateScreenHeight(10),
                height: getProportionateScreenHeight(10),
              ),
            ),
            Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: 'Belanja Apa hari ini ?',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        color: kTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
