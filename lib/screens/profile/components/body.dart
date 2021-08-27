import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/screens/historytransaksi/history_sreen.dart';
import 'package:bulanan/screens/notification/notification.dart';
import 'package:bulanan/screens/sign_in/sign_in_screen.dart';
import 'package:bulanan/screens/webscreennormal/webscreennormal.dart';

import '../profile_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(
                context,
                ProfileScreen.routeName,
              );
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.pushNamed(
                context,
                Notifikasi.routeName,
              );
            },
          ),
          ProfileMenu(
            text: "History Transaksi",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(
                context,
                HistoryTransaksi.routeName,
                arguments: {'position': '0'},
              );
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.pushNamed(
                context,
                WebScreen.routeName,
                arguments: {'url': 'https://bulanan.app/page/faq'},
              );
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.remove('id_member');
              await preferences.remove('auth');
              Navigator.pushNamed(
                context,
                SignInScreen.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
