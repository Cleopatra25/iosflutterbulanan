import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/models/ModelAlamat.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/screens/addalamat/addalamatscreen.dart';
import 'package:bulanan/screens/cart/components/cartcontent.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BodyAlamat extends StatefulWidget {
  @override
  _BodyAlamatState createState() => _BodyAlamatState();
}

class _BodyAlamatState extends State<BodyAlamat> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';
  ModelAlamat modelalamat;

  @override
  void initState() {
    getPreference();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Headers(tittle: 'Alamat', routename: HomeScreen.routeName),
        ),
        Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
                top: getProportionateScreenHeight(80),
                bottom: getProportionateScreenWidth(75)),
            child: FutureBuilder(
              future: getPreference(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _getalamat(context);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AddAlamatScreen.routeName,
              ).then((value) {
                setState(() {});
                print('were back');
              });
            },
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(3)),
              width: double.infinity,
              height: getProportionateScreenWidth(70),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Align(
                alignment: Alignment.center,
                child: buildtextSize('Tambah Alamat', kTextWhite,
                    getProportionateScreenWidth(12)),
              ),
            ),
          ),
        ),
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

  FutureBuilder<Response<dynamic>> _getalamat(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getAlamat('sembako168', authHeader, idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          modelalamat = ModelAlamat.fromJson(snapshot.data.body);
          // print(bannerlist);
          return _alamatlayout(context, modelalamat);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _alamatlayout(BuildContext context, ModelAlamat models) {
    return ListView.builder(
      itemCount: modelalamat.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(getProportionateScreenWidth(12)),
          elevation: 2,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.pop(context, {
                'id_address': modelalamat.data[index].idAddress,
                'address': modelalamat.data[index].address
              });
            },
            child: Stack(alignment: Alignment.bottomRight, children: [
              Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildtextSizeleft(models.data[index].nameAcc,
                          kTextColor, getProportionateScreenWidth(12)),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildtextleftnormal(
                          models.data[index].address, kTextColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildtextSizeleft(models.data[index].phone,
                          kPrimaryColor, getProportionateScreenWidth(12)),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
              Container(
                width: getProportionateScreenWidth(80),
                height: getProportionateScreenWidth(20),
                margin: EdgeInsets.only(
                    bottom: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  color: kTextWhite,
                  border: Border.all(color: kPrimaryColor),
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(4)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: buildtextSize('Pilih Alamat', kPrimaryColor,
                      getProportionateScreenWidth(10)),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
