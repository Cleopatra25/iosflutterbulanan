import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Bloc/updatecart.dart';
import 'package:bulanan/Bloc/updateharga.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/models/ModelCategoryMain.dart';
import 'package:bulanan/models/ModelCategoryMainProduct.dart';
import 'package:bulanan/screens/CategoryMain/components/contentCategory.dart';
import 'package:bulanan/screens/CategoryMain/components/cutomTab.dart';
import 'package:bulanan/screens/cart/cart_screen.dart';
import 'package:bulanan/screens/home/components/childlistproduct.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final String idCategoryparent;
  final String namecategory;

  @override
  _BodyState createState() => _BodyState();

  Body({
    Key key,
    this.idCategoryparent,
    this.namecategory,
  }) : super(key: key);
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
  ModelCategoryMain modelcategry;
  ModelCategoryMainProduct modelcategryproduct;
  UpdateCart bloccart = UpdateCart();
  UpdateHarga blocharga = UpdateHarga();
  int limit = 0;
  int offsed = 0;
  @override
  void initState() {
    getPreference();
    print(widget.idCategoryparent);

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
          child: Headers(
            tittle: widget.namecategory,
            routename: HomeScreen.routeName,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(
              top: getProportionateScreenHeight(100),
              bottom: getProportionateScreenHeight(50)),
          child: FutureBuilder(
            future: getPreference(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                addCart();

                return _buildCustomtab(context);
              } else {
                return CircularProgressIndicator();
              }
            },
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
            ),
          ),
        ),
      ],
    );
  }

  FutureBuilder<Response<dynamic>> _buildCustomtab(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getMaincategory(
          'sembako168',
          idMember,
          idDevice,
          idCity,
          widget.idCategoryparent,
          '0',
          '0'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          modelcategry = ModelCategoryMain.fromJson(snapshot.data.body);
          // print(bannerlist);
          return _buildtab(context, modelcategry);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  CustomTabView _buildtab(BuildContext context, ModelCategoryMain models) {
    return CustomTabView(
      initPosition: 0,
      itemCount: models.data.length,
      tabBuilder: (context, index) {
        return Tab(
          text: models.data[index].categoryName,
        );
      },
      pageBuilder: (context, index) {
        return ContentCategory(
          idProductCategory: models.data[index].idProductCategory,
          idMember: idMember,
          idCity: idCity,
          idDevice: idDevice,
          authHeader: authHeader,
          updatecarts: addCart,
        );
      },
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
