import 'package:flutter/material.dart';
import 'package:bulanan/screens/addalamat/components/body.dart';
import 'package:bulanan/screens/alamat/components/body.dart';
import 'package:bulanan/screens/cart/components/body.dart';

class AddAlamatScreen extends StatefulWidget {
  static String routeName = "/addalamat";

  @override
  _AddAlamatScreenState createState() => _AddAlamatScreenState();
}

class _AddAlamatScreenState extends State<AddAlamatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyAddAlamat(),
    );
  }
}
