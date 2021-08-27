import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/models/ModelMember.dart';
import 'package:bulanan/size_config.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
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
            return getMember(context);
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
            return buildprofilepic(context, model);
          } else {
            return Center(
              child: buildtextSize('Akun Tidak ditemukan Logout dan login lagi',
                  Colors.black54, getProportionateScreenWidth(12)),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column buildprofilepic(BuildContext context, ModelMember mods) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/account.png"),
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {},
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildtextSize(mods.data.fullName, Colors.black87,
                getProportionateScreenWidth(14)),
          ],
        ),
        buildtextSize('ID Referral : ${mods.data.phone}', Colors.black54,
            getProportionateScreenWidth(12))
      ],
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
