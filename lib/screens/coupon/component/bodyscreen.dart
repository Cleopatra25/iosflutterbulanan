import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/models/ModelAlamat.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/models/ModelCoupon.dart';
import 'package:bulanan/models/ModelCouponsingle.dart';
import 'package:bulanan/screens/addalamat/addalamatscreen.dart';
import 'package:bulanan/screens/cart/components/cartcontent.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BodyCoupon extends StatefulWidget {
  final int totalharga;
  final int biayakirim;
  BodyCoupon({
    Key key,
    this.totalharga,
    this.biayakirim,
  }) : super(key: key);
  @override
  _BodyCouponState createState() => _BodyCouponState();
}

class _BodyCouponState extends State<BodyCoupon> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';
  bool islist = true;
  ModelCoupon modelcoupon;
  ModelCouponsingle modelcoupons;
  TextEditingController nama = new TextEditingController();

  @override
  void initState() {
    getPreference();
    print(widget.totalharga);
    print(widget.biayakirim);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updatelist(String token) {
    if (token == 'list') {
      setState(() {
        islist = true;
      });
    } else {
      print('iam here');
      setState(() {
        islist = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Headers(tittle: 'Coupon', routename: HomeScreen.routeName),
        ),
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(70),
          margin: EdgeInsets.only(
              top: getProportionateScreenHeight(100),
              left: getProportionateScreenWidth(8),
              right: getProportionateScreenWidth(8),
              bottom: getProportionateScreenWidth(8)),
          child: Card(
            child: Container(
                width: double.infinity,
                height: getProportionateScreenHeight(60),
                padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: TextField(
                        controller: nama,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'Kode Coupon',
                          hintStyle: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black26),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  getProportionateScreenWidth(3))),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  getProportionateScreenWidth(3))),
                              borderSide: BorderSide(color: Colors.blue)),
                          border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(color: Colors.white24)
                              //borderSide: const BorderSide(),
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () {
                          updatelist('card');
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(10)),
                          margin:
                              EdgeInsets.all(getProportionateScreenHeight(3)),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(4)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: buildtextSize('Gunakan', kTextWhite,
                                getProportionateScreenWidth(12)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
                top: getProportionateScreenHeight(170),
                bottom: getProportionateScreenWidth(75)),
            child: FutureBuilder(
              future: getPreference(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (islist) {
                    return _getCouponlist(context);
                  } else {
                    return _getCouponlistsingle(context);
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            )),
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

  FutureBuilder<Response<dynamic>> _getCouponlist(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getCouponList('sembako168', authHeader),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          modelcoupon = ModelCoupon.fromJson(snapshot.data.body);
          // print(bannerlist);
          return _couponlayoutList(context, modelcoupon);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _couponlayoutList(BuildContext context, ModelCoupon models) {
    return ListView.builder(
      itemCount: modelcoupon.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(getProportionateScreenWidth(12)),
          elevation: 2,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              if (models.data[index].type == 'ongkir') {
                if (int.parse(models.data[index].minimunOrder) >
                    widget.totalharga) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Pesanan Anda kurang dari minimal order Coupon ini'),
                  ));
                } else if (widget.biayakirim < 1 || widget.biayakirim == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Anda telah mendapatkan gratis ongkir coupon ini tidak bisa dipakai'),
                  ));
                } else {
                  int a;
                  a = widget.biayakirim -
                      int.parse(models.data[index].couponAmount);
                  if (a < 0) {
                    a = 0;
                  }

                  Navigator.pop(context, {
                    'value': a.toString(),
                    'type': 'ongkir',
                    'code': models.data[index].couponCode
                  });
                }
              } else {
                if (int.parse(models.data[index].minimunOrder) >
                    widget.totalharga) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Pesanan Anda kurang dari minimal order Coupon ini'),
                  ));
                } else {
                  if (models.data[index].persentasi == null ||
                      models.data[index].persentasi == '0') {
                    int a;
                    a = widget.totalharga -
                        int.parse(models.data[index].couponAmount);
                    if (a < 0) {
                      a = 0;
                    }

                    Navigator.pop(context, {
                      'value': a.toString(),
                      'type': 'harga',
                      'code': models.data[index].couponCode
                    });
                  } else {
                    int a;

                    a = widget.totalharga *
                        int.parse(models.data[index].persentasi);
                    double b;
                    b = a / 100;
                    if (models.data[index].maximalPrice != '0') {
                      if (b > int.parse(models.data[index].maximalPrice)) {
                        b = double.parse(models.data[index].maximalPrice);
                      }
                    }

                    double c;
                    c = widget.totalharga - b;

                    int d = c.toInt();

                    Navigator.pop(context, {
                      'value': d.toString(),
                      'type': 'harga',
                      'code': models.data[index].couponCode
                    });
                  }
                }
              }
            },
            child: Stack(alignment: Alignment.bottomRight, children: [
              Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(70),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: models.data[index].image,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildtextSizeleft(models.data[index].couponName,
                          Colors.black87, getProportionateScreenWidth(12)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildtextleftnormal(
                          models.data[index].couponDescription, kTextColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              buildimagescustom(
                                  'assets/images/time_outlines.png',
                                  getProportionateScreenWidth(17),
                                  getProportionateScreenWidth(16)),
                              buildtextSize(
                                  models.data[index].validFrom.toString(),
                                  kTextColor,
                                  getProportionateScreenWidth(11))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            height: getProportionateScreenHeight(30),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(4)),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: buildtextSize('Gunakan', kTextWhite,
                                  getProportionateScreenWidth(12)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  FutureBuilder<Response<dynamic>> _getCouponlistsingle(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .postCoupon('sembako168', authHeader, nama.text.toString(), idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('codecoupon');
          print(snapshot.data.body['status']);
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            modelcoupons = ModelCouponsingle.fromJson(snapshot.data.body);
            // print(bannerlist);
            return _couponlayoutListsingle(context, modelcoupons);
          } else {
            return Center(
              child: buildtextSize('Coupon tidak ditemukan', Colors.black87,
                  getProportionateScreenWidth(11)),
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

  Card _couponlayoutListsingle(BuildContext context, ModelCouponsingle models) {
    return Card(
      margin: EdgeInsets.all(getProportionateScreenWidth(12)),
      elevation: 2,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          if (models.data.type == 'ongkir') {
            if (int.parse(models.data.minimunOrder) > widget.totalharga) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Pesanan Anda kurang dari minimal order Coupon ini'),
              ));
            } else if (widget.biayakirim < 1 || widget.biayakirim == 0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Anda telah mendapatkan gratis ongkir coupon ini tidak bisa dipakai'),
              ));
            } else {
              int a;
              a = widget.biayakirim - int.parse(models.data.couponAmount);
              if (a < 0) {
                a = 0;
              }

              Navigator.pop(context, {
                'value': a.toString(),
                'type': 'ongkir',
                'code': models.data.couponCode
              });
            }
          } else {
            if (int.parse(models.data.minimunOrder) > widget.totalharga) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Pesanan Anda kurang dari minimal order Coupon ini'),
              ));
            } else {
              if (models.data.persentasi == null ||
                  models.data.persentasi == '0') {
                int a;
                a = widget.totalharga - int.parse(models.data.couponAmount);
                if (a < 0) {
                  a = 0;
                }

                Navigator.pop(context, {
                  'value': a.toString(),
                  'type': 'harga',
                  'code': models.data.couponCode
                });
              } else {
                int a;

                a = widget.totalharga * int.parse(models.data.persentasi);
                double b;
                b = a / 100;
                if (models.data.maximalPrice != '0') {
                  if (b > int.parse(models.data.maximalPrice)) {
                    b = double.parse(models.data.maximalPrice);
                  }
                }

                double c;
                c = widget.totalharga - b;

                int d = c.toInt();

                Navigator.pop(context, {
                  'value': d.toString(),
                  'type': 'harga',
                  'code': models.data.couponCode
                });
              }
            }
          }
        },
        child: Stack(alignment: Alignment.bottomRight, children: [
          Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(70),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: models.data.image,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: buildtextSizeleft(models.data.couponName,
                      Colors.black87, getProportionateScreenWidth(12)),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: buildtextleftnormal(
                      models.data.couponDescription, kTextColor),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          buildimagescustom(
                              'assets/images/time_outlines.png',
                              getProportionateScreenWidth(17),
                              getProportionateScreenWidth(16)),
                          buildtextSize(models.data.validFrom.toString(),
                              kTextColor, getProportionateScreenWidth(11))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(30),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(4)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize('Gunakan', kTextWhite,
                              getProportionateScreenWidth(12)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
