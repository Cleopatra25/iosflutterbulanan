import 'package:flutter/material.dart';
import 'package:bulanan/screens/checkout/components/body.dart';

import 'components/bodyjadwal.dart';

class JadwalScreen extends StatefulWidget {
  static String routeName = "/jadwal";

  @override
  _JadwalScreenState createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyJadwal(),
    );
  }
}
