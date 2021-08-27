import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/models/ModelMember.dart';
import 'package:bulanan/screens/historytransaksi/history_sreen.dart';
import 'package:bulanan/screens/login_success/login_success_screen.dart';
import 'package:bulanan/screens/profile/profile_screen.dart';
import 'package:bulanan/screens/sign_in/sign_in_screen.dart';
import 'package:bulanan/screens/webscreennormal/webscreennormal.dart';
import 'package:bulanan/screens/webview/webview_screen.dart';

import '../../../size_config.dart';

class Drawers extends StatefulWidget {
  const Drawers({
    Key key,
  }) : super(key: key);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';

  String idMember = '';

  ModelMember model;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPreference(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (idMember == '' || idMember == null) {
              return buildDrawergaada();
            } else {
              return getMember(context);
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  FutureBuilder<Response<dynamic>> getMember(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getMember('sembako168', authHeader, idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            model = ModelMember.fromJson(snapshot.data.body);
            print('sahadat ${model.data.profilePic}');
            return buildDrawer(context, model);
          } else {
            return buildDrawergaada();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Drawer buildDrawer(BuildContext context, ModelMember models) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: getProportionateScreenHeight(90),
                    height: getProportionateScreenHeight(90),

                    child: buildimagescustom(
                        'assets/images/account.png',
                        getProportionateScreenWidth(90),
                        getProportionateScreenHeight(90)),
                    // child: CachedNetworkImage(
                    //   imageUrl: models.data.profilePic,
                    //   placeholder: (context, url) =>
                    //       new CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) =>
                    //       new Icon(Icons.error),
                    // ),
                  ),
                  buildtextSize(models.data.fullName, kTextWhite,
                      getProportionateScreenWidth(14))
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            title: buildtextSize(
                'Account', Colors.black87, getProportionateScreenWidth(12)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(
                context,
                ProfileScreen.routeName,
              );
            },
          ),
          ListTile(
            title: buildtextSize(
                'Transaksi', Colors.black87, getProportionateScreenWidth(12)),
            onTap: () {
              Navigator.pushNamed(
                context,
                HistoryTransaksi.routeName,
                arguments: {'position': '0'},
              );
              // Update the state of the app
              // ...
              // Then close the drawer
            },
          ),
          ListTile(
            title: buildtextSize(
                'FAQ', Colors.black87, getProportionateScreenWidth(12)),
            onTap: () {
              Navigator.pushNamed(
                context,
                WebScreen.routeName,
                arguments: {'url': 'https://bulanan.app/page/faq'},
              );
            },
          ),
          ListTile(
            title: buildtextSize('Tentang Kami', Colors.black87,
                getProportionateScreenWidth(12)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(
                context,
                WebScreen.routeName,
                arguments: {'url': 'https://bulanan.app/page/about'},
              );
            },
          ),
          ListTile(
            title: buildtextSize(
                'Logout', Colors.black87, getProportionateScreenWidth(12)),
            onTap: () async {
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

  Drawer buildDrawergaada() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            title: buildtextSize(
                'FAQ', Colors.black87, getProportionateScreenWidth(12)),
            onTap: () {
              Navigator.pushNamed(
                context,
                WebScreen.routeName,
                arguments: {'url': 'https://bulanan.app/page/faq'},
              );
            },
          ),
          ListTile(
            title: buildtextSize('Tentang Kami', Colors.black87,
                getProportionateScreenWidth(12)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(
                context,
                WebScreen.routeName,
                arguments: {'url': 'https://bulanan.app/page/about'},
              );
            },
          ),
          ListTile(
            title: buildtextSize(
                'Login', Colors.black87, getProportionateScreenWidth(12)),
            onTap: () async {
              Navigator.pushNamed(
                context,
                SignInScreen.routeName,
              );
            },
          )
        ],
      ),
    );
  }

  Future<String> getPreference() async {
    SharedPreferences myshare = await SharedPreferences.getInstance();
    idCity = myshare.getString('id_city') ?? '3271';
    idDevice = myshare.getString('id_device') ?? '';
    idMember = myshare.getString('id_member') ?? '';
    authHeader = myshare.getString('auth') ?? '';
    nameCity = myshare.getString('name_city') ?? 'Bogor';
    return idCity;
  }
}
