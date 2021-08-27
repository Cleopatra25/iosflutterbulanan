import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Bloc/updatecart.dart';
import 'package:bulanan/Bloc/updateharga.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/screens/cart/cart_screen.dart';
import 'package:bulanan/screens/home/components/flashsale.dart';
import 'package:bulanan/screens/home/components/highlight.dart';
import 'package:bulanan/screens/home/components/maincategory.dart';
import 'package:bulanan/screens/home/components/promo.dart';
import 'package:bulanan/screens/home/components/recomendation.dart';
import 'package:bulanan/screens/home/components/searchbar.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';

class Body extends StatefulWidget with WidgetsBindingObserver {
  final String pesan;

  Body({
    Key key,
    this.pesan,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';

  String idMember = '';
  String rupiah = 'Rp 0';
  int counts = 0;
  ModelCart model;
  UpdateCart bloccart = UpdateCart();
  UpdateHarga blocharga = UpdateHarga();
  @override
  void initState() {
    getPreference();

    super.initState();
  }

  @override
  void dispose() {
    bloccart.dispose();
    blocharga.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: getPreference(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      addCart();

                      return HomeHeader(
                        idCitys: idCity,
                        nameCitys: nameCity,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: getProportionateScreenWidth(10)),
                DiscountBanner(),
                Searchbar(),
                Categories(),
                FutureBuilder(
                  future: getPreference(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Promo(
                        authHeaders: authHeader,
                        idCitys: idCity,
                        idDevices: idDevice,
                        idMembers: idMember,
                        updatecarts: addCart,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                FutureBuilder(
                  future: getPreference(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Flashsale(
                        authHeaders: authHeader,
                        idCitys: idCity,
                        idDevices: idDevice,
                        idMembers: idMember,
                        updatecarts: addCart,
                      );
                    } else
                      return CircularProgressIndicator();
                  },
                ),
                FutureBuilder(
                  future: getPreference(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Highlight(
                        authHeaders: authHeader,
                        idCitys: idCity,
                        idDevices: idDevice,
                        idMembers: idMember,
                        updatecarts: addCart,
                      );
                    } else
                      return CircularProgressIndicator();
                  },
                ),
                FutureBuilder(
                  future: getPreference(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Maincategory(
                        authHeaders: authHeader,
                        idCitys: idCity,
                        idDevices: idDevice,
                        idMembers: idMember,
                        updatecarts: addCart,
                      );
                    } else
                      return CircularProgressIndicator();
                  },
                ),
                FutureBuilder(
                  future: getPreference(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Recomendation(
                        authHeaders: authHeader,
                        idCitys: idCity,
                        idDevices: idDevice,
                        idMembers: idMember,
                        updatecarts: addCart,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CartScreen.routeName,
                ).then((value) {
                  setState(() {});
                  print('were back');
                });
              },
              child: Container(
                width: double.infinity,
                height: getProportionateScreenHeight(55),
                decoration: BoxDecoration(color: accentColor),
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(13)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: buildimagescustom(
                            'assets/images/addcart_white.png',
                            getProportionateScreenWidth(24),
                            getProportionateScreenHeight(24)),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          children: [
                            StreamBuilder(
                                stream: bloccart.output,
                                initialData: 0,
                                builder: (context, snapshot) {
                                  return buildtextSize(
                                      '${snapshot.data} Barang',
                                      kTextWhite,
                                      getProportionateScreenWidth(13));
                                }),
                            Container(
                              margin: EdgeInsets.only(
                                  left: getProportionateScreenWidth(10)),
                              child: StreamBuilder(
                                  stream: blocharga.output,
                                  initialData: '0',
                                  builder: (context, snapshot) {
                                    return buildtextSize(
                                        snapshot.data,
                                        kTextWhite,
                                        getProportionateScreenWidth(13));
                                  }),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buildtextSize('Ke kasir >', kTextWhite,
                            getProportionateScreenWidth(15)),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }

  void addCart() async {
    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .getCart('sembako168', authHeader, idDevice);

    print(response.body);

    if (response.isSuccessful) {
      if (response.body['status'] == true) {
        model = ModelCart.fromJson(response.body);
        rupiah = NumberFormat.currency(locale: 'id', name: 'Rp ')
            .format(model.data.totalPrice);
        counts = model.data.totalProduct;
        print(counts);
        print(rupiah);
        bloccart.sinkin.add(counts);
        blocharga.sinkin.add(rupiah);
      }
    }
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
