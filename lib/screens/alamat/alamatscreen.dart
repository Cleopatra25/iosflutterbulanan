import 'package:flutter/material.dart';
import 'package:bulanan/screens/alamat/components/body.dart';
import 'package:bulanan/screens/cart/components/body.dart';

class AlamatScreen extends StatefulWidget {
  static String routeName = "/alamat";

  @override
  _AlamatScreenState createState() => _AlamatScreenState();
}

class _AlamatScreenState extends State<AlamatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyAlamat(),
    );
  }
}
