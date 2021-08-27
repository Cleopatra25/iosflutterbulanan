import 'package:flutter/material.dart';
import 'package:bulanan/screens/alamat/components/body.dart';
import 'package:bulanan/screens/cart/components/body.dart';
import 'package:bulanan/screens/coupon/component/bodyscreen.dart';

class CouponScreen extends StatefulWidget {
  static String routeName = "/coupon";

  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    int totalharga = 0;
    int biayakirim = 0;

    if (arguments != null) {
      totalharga = arguments['totalharga'];
      biayakirim = arguments['biayakirim'];
    }
    return Scaffold(
      body: BodyCoupon(
        totalharga: totalharga,
        biayakirim: biayakirim,
      ),
    );
  }
}
