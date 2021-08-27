import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/models/ModelCategoryMainProduct.dart';
import 'package:bulanan/models/ModelproductLoadmore.dart';
import 'package:bulanan/screens/CategoryMain/components/childcategorymain.dart';
import 'package:bulanan/screens/CategoryMain/components/listtab.dart';
import 'package:bulanan/screens/cart/components/childcart.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class Cartrow extends StatefulWidget {
  final String idMember;
  final String idCity;
  final String idDevice;
  final String authHeader;
  final int position;
  ModelCart models;
  final Function updatecarts;

  Cartrow({
    Key key,
    this.idMember,
    this.idCity,
    this.idDevice,
    this.authHeader,
    this.updatecarts,
    this.position,
    this.models,
  }) : super(key: key);

  @override
  _CartrowState createState() => _CartrowState();
}

class _CartrowState extends State<Cartrow> {
  bool active = true;
  @override
  Widget build(BuildContext context) {
    return _containercart(context, widget.position, widget.models);
  }

  Container _containercart(
      BuildContext context, int index, ModelCart modelproduct) {
    if (!active) {
      return Container(width: 0.0, height: 0.0);
    } else {
      return Container(
        width: double.infinity,
        height: getProportionateScreenWidth(130),
        child: Card(
          margin: EdgeInsets.all(getProportionateScreenWidth(8)),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Row(
                  children: [
                    Container(
                      width: getProportionateScreenHeight(100),
                      height: getProportionateScreenHeight(90),
                      child: CachedNetworkImage(
                        imageUrl: modelproduct.data.product[index].productPhoto,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      child: Column(
                        children: [
                          Container(
                            width: getProportionateScreenWidth(200),
                            child: Text(
                              modelproduct.data.product[index].productName,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: getProportionateScreenHeight(10),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (modelproduct.data.product[index].productDiscount
                                      .toString() ==
                                  '0' ||
                              modelproduct
                                      .data.product[index].productDiscount ==
                                  null) ...[
                            if (modelproduct.data.product[index].promoPrice
                                        .toString() ==
                                    '0' ||
                                modelproduct.data.product[index].promoPrice ==
                                    null) ...[
                              Container(
                                  width: getProportionateScreenWidth(200),
                                  child: buildtextnormal(
                                      NumberFormat.currency(
                                              locale: 'id', name: 'Rp ')
                                          .format(int.parse(modelproduct.data
                                              .product[index].productPrice)),
                                      kTextColor,
                                      false)),
                            ] else ...[
                              Container(
                                width: getProportionateScreenWidth(200),
                                child: buildtextnormal(
                                    NumberFormat.currency(
                                            locale: 'id', name: 'Rp ')
                                        .format(int.parse(modelproduct
                                            .data.product[index].productPrice)),
                                    kTextColor,
                                    true),
                              ),
                              Container(
                                width: getProportionateScreenWidth(200),
                                child: buildtextbold(
                                    NumberFormat.currency(
                                            locale: 'id', name: 'Rp ')
                                        .format(int.parse(modelproduct
                                            .data.product[index].promoPrice)),
                                    accentColor),
                              ),
                            ]
                          ] else ...[
                            Container(
                              width: getProportionateScreenWidth(200),
                              child: buildtextnormal(
                                  NumberFormat.currency(
                                          locale: 'id', name: 'Rp ')
                                      .format(int.parse(modelproduct
                                          .data.product[index].productPrice)),
                                  kTextColor,
                                  true),
                            ),
                            Container(
                              width: getProportionateScreenWidth(200),
                              child: buildtextbold(
                                  NumberFormat.currency(
                                          locale: 'id', name: 'Rp ')
                                      .format(int.parse(modelproduct.data
                                          .product[index].productDiscount)),
                                  accentColor),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Childcart(
                    quantitys:
                        int.parse(modelproduct.data.product[index].quantity),
                    idProduk: modelproduct.data.product[index].idProduct,
                    position: index,
                    authHeaders: widget.authHeader,
                    idDevices: widget.idDevice,
                    idCitys: widget.idCity,
                    updatecarts: widget.updatecarts,
                    removedata: removedata,
                  ),
                )
              ],
            ),
            onTap: () {
              print('Card tapped.');
            },
          ),
        ),
      );
    }
  }

  void removedata(int position) {
    setState(() {
      widget.models.data.product.removeAt(position);
      active = false;
    });
  }
}
