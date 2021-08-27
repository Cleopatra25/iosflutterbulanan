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
import 'package:bulanan/screens/cart/components/cartcontent.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BodyAddAlamat extends StatefulWidget {
  @override
  _BodyAddAlamatState createState() => _BodyAddAlamatState();
}

class _BodyAddAlamatState extends State<BodyAddAlamat> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';
  ModelAlamat modelalamat;
  bool isloading = false;
  bool validatename = false;
  bool validatephone = false;
  bool validatealamat = false;
  TextEditingController nama = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  @override
  void initState() {
    getPreference();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void buttonregister() {
    if (nama.text.isEmpty) {
      setState(() {
        validatename = true;
      });
    } else {
      setState(() {
        validatename = false;
      });
    }

    if (alamat.text.isEmpty) {
      setState(() {
        validatealamat = true;
      });
    } else {
      setState(() {
        validatealamat = false;
      });
    }
    if (phone.text.isEmpty) {
      setState(() {
        validatephone = true;
      });
    } else {
      setState(() {
        validatephone = false;
      });
    }

    if (!validatename && !validatealamat && !validatephone) {
      addAlamat();
    } else {}
  }

  void addAlamat() async {
    setState(() {
      isloading = true;
    });
    final response =
        await Provider.of<NetworkApiService>(context, listen: false).postAlamat(
            'sembako168',
            authHeader,
            '32',
            idCity,
            '19726',
            phone.text.toString(),
            nama.text.toString(),
            alamat.text.toString(),
            '-',
            '0',
            '0');

    print(response.body);

    if (response.body['status'] == true) {
      setState(() {
        isloading = true;
      });
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body['message']),
      ));
    } else {
      setState(() {
        isloading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body['message']),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPreference(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Headers(
                      tittle: 'Tambah Alamat', routename: HomeScreen.routeName),
                ),
                Container(
                  width: double.infinity,
                  height: getProportionateScreenWidth(100),
                  margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                  padding:
                      EdgeInsets.only(top: getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    color: kTextWhite,
                    border: Border.all(
                      color: kPrimaryColor,
                    ),
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(4)),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: buildtextSizecenter(
                            'Area pengiriman Anda  adalah $nameCity',
                            Colors.black87,
                            getProportionateScreenWidth(13)),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: buildtextSizecentersoft(
                            'Pastikan Alamat Anda berada dalam jarak area pengiriman',
                            kTextColor,
                            getProportionateScreenWidth(12)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(8),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextField(
                    controller: nama,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Nama Penerima',
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      errorText:
                          validatename ? 'Nama tidak boleh kosong' : null,
                      hintText: 'Nama Penerima',
                      hintStyle: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          color: Colors.black26),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(getProportionateScreenWidth(3))),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(getProportionateScreenWidth(3))),
                          borderSide: BorderSide(color: Colors.blue)),
                      border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.white24)
                          //borderSide: const BorderSide(),
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(8),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Nomor Hp',
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      errorText:
                          validatephone ? 'Nomor Hp tidak boleh kosong' : null,
                      hintText: 'Nomor Handphone',
                      hintStyle: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          color: Colors.black26),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(getProportionateScreenWidth(3))),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(getProportionateScreenWidth(3))),
                          borderSide: BorderSide(color: Colors.blue)),
                      border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.white24)
                          //borderSide: const BorderSide(),
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(8),
                      bottom: getProportionateScreenHeight(8),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  child: TextField(
                    controller: alamat,
                    maxLines: 3,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Alamat lengkap',
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      errorText:
                          validatealamat ? 'Alamat tidak boleh kosong' : null,
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          color: Colors.black26),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(getProportionateScreenWidth(3))),
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(getProportionateScreenWidth(3))),
                          borderSide: BorderSide(color: Colors.blue)),
                      border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(color: Colors.white24)
                          //borderSide: const BorderSide(),
                          ),
                    ),
                  ),
                ),
                if (!isloading) ...[
                  GestureDetector(
                    onTap: () {
                      buttonregister();
                    },
                    child: Container(
                      width: double.infinity,
                      height: getProportionateScreenWidth(40),
                      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(4))),
                      child: Align(
                        alignment: Alignment.center,
                        child: buildtextSizecentersoft('Tambah alamat',
                            kTextWhite, getProportionateScreenWidth(10)),
                      ),
                    ),
                  ),
                ] else ...[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ]
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
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
