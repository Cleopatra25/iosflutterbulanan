import 'package:flutter/material.dart';
import 'package:bulanan/screens/checkout/components/body.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyChekout());
  }
}
