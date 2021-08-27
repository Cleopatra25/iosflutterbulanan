import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/default_button.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/models/ModelDetailProduct.dart';
import 'package:bulanan/models/Product.dart';
import 'package:bulanan/screens/cart/cart_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/size_config.dart';

import '../details_screen.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final String idProduct;

  const Body({Key key, this.idProduct}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';

  String idMember = '';
  BuildContext alertcontext;

  ModelDetailProduct models;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: FutureBuilder(
        future: getPreference(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return getDetailProduct(context);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    ));
  }

  FutureBuilder<Response<dynamic>> getDetailProduct(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getDetailProduct('sembako168', widget.idProduct),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          models = ModelDetailProduct.fromJson(snapshot.data.body);
          // print(bannerlist);
          return buildlayoutDetail(context, models);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column buildlayoutDetail(
      BuildContext context, ModelDetailProduct modelproduct) {
    return Column(
      children: [
        Headers(tittle: 'Detail Product', routename: HomeScreen.routeName),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(190),
                child: CachedNetworkImage(
                  imageUrl: modelproduct.data.product.image,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        buildtextSize(modelproduct.data.product.productName,
                            Colors.black87, getProportionateScreenWidth(15))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        if (modelproduct.data.product.isPromo.toString() ==
                                '0' ||
                            modelproduct.data.product.isPromo == null) ...[
                          Align(
                              alignment: Alignment.centerRight,
                              child: buildtextSizeleftsoft(
                                  NumberFormat.currency(
                                          locale: 'id', name: 'Rp ')
                                      .format(int.parse(modelproduct
                                          .data.product.pricePerUnit)),
                                  kPrimaryColor,
                                  getProportionateScreenWidth(14))),
                        ] else ...[
                          if (models.data.product.discount == '0' ||
                              models.data.product.discount == null) ...[
                            Align(
                                alignment: Alignment.centerRight,
                                child: buildtextSizeleftsoft(
                                    NumberFormat.currency(
                                            locale: 'id', name: 'Rp ')
                                        .format(int.parse(modelproduct
                                            .data.product.pricePerUnit)),
                                    kPrimaryColor,
                                    getProportionateScreenWidth(14)))
                          ] else ...[
                            Align(
                                alignment: Alignment.centerRight,
                                child: buildtextSizeleftsoft(
                                    NumberFormat.currency(
                                            locale: 'id', name: 'Rp ')
                                        .format(int.parse(modelproduct
                                            .data.product.discount)),
                                    kPrimaryColor,
                                    getProportionateScreenWidth(14))),
                          ]
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: buildtextleftnormal(
                    modelproduct.data.product.description, Colors.black87),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: buildtextleftnormal(
                    'Ukuran : ' + modelproduct.data.product.unit,
                    Colors.black87),
              ),
              Align(
                child: buildtextleftnormal(
                    'Stock : ' + modelproduct.data.product.stock,
                    Colors.black87),
                alignment: Alignment.centerRight,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: buildtextleftnormal(
                    'Expire Date : ' + modelproduct.data.product.expDate,
                    Colors.black87),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      alertcontext = context;
                      return Dialog(
                          child: Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(40),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new CircularProgressIndicator(),
                            new Text("Loading"),
                          ],
                        ),
                      ));
                    },
                  );
                  addCart(modelproduct.data.product.idProduct);
                },
                child: Container(
                  height: getProportionateScreenHeight(50),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(4))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildtextSizeleft('Tambah ke keranjang', kTextWhite,
                          getProportionateScreenWidth(12)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: buildtextSize('Produck Terkait', Colors.black87,
                    getProportionateScreenWidth(14)),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(220),
                child: _buildcitylayout(context, modelproduct),
              )
            ],
          ),
        ),
      ],
    );
  }

  ListView _buildcitylayout(
      BuildContext context, ModelDetailProduct modelproducts) {
    return ListView.builder(
      itemCount: modelproducts.data.relatedProduct.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Card(
            child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: {
                'idProduct': modelproducts.data.relatedProduct[index].idProduct
              },
            );
          },
          child: Container(
            width: getProportionateScreenWidth(132),
            height: double.infinity,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: getProportionateScreenHeight(100),
                      height: getProportionateScreenHeight(90),
                      child: CachedNetworkImage(
                        imageUrl:
                            modelproducts.data.relatedProduct[index].image,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                  child: Text(
                    modelproducts.data.relatedProduct[index].productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenHeight(10),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (modelproducts.data.relatedProduct[index].discount
                            .toString() ==
                        '0' ||
                    modelproducts.data.relatedProduct[index].discount ==
                        null) ...[
                  buildtextnormal(
                      NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                          int.parse(modelproducts
                              .data.relatedProduct[index].pricePerUnit)),
                      kTextColor,
                      false)
                ] else ...[
                  buildtextnormal(
                      NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                          int.parse(modelproducts
                              .data.relatedProduct[index].pricePerUnit)),
                      kTextColor,
                      true),
                  buildtextbold(
                      NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                          int.parse(modelproducts
                              .data.relatedProduct[index].discount)),
                      accentColor),
                ],
              ],
            ),
          ),
        ));
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

  Future<void> addCart(String idProduct) async {
    final response =
        await Provider.of<NetworkApiService>(context, listen: false).postCart(
            'sembako168', authHeader, idProduct, idDevice, idCity, '1');

    print(response.body);

    if (response.isSuccessful) {
      if (response.body['status'] == true) {
        Navigator.pushReplacementNamed(context, CartScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body['message']),
        ));
      }
    }
  }
}
