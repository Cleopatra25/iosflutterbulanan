import 'package:flutter/material.dart';
import 'package:bulanan/screens/notification/components/bodynotification.dart';

class Notifikasi extends StatelessWidget {
  static String routeName = "/notification";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyNotification());
  }
}
