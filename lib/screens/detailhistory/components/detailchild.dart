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
import 'package:bulanan/models/ModelDetailTransaksi.dart';
import 'package:bulanan/models/ModelproductLoadmore.dart';
import 'package:bulanan/screens/CategoryMain/components/childcategorymain.dart';
import 'package:bulanan/screens/CategoryMain/components/listtab.dart';
import 'package:bulanan/screens/cart/cardrow.dart';
import 'package:bulanan/screens/cart/components/childcart.dart';
import 'package:bulanan/screens/checkout/components/checkoutrow.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class Detailchild extends StatefulWidget {
  final ModelDetailTransaksi models;

  Detailchild({
    Key key,
    this.models,
  }) : super(key: key);

  @override
  _DetailchildState createState() => _DetailchildState();
}

class _DetailchildState extends State<Detailchild> {
  ModelCart model;

  @override
  Widget build(BuildContext context) {
    return _buildlistcart(context, widget.models);
  }

  ListView _buildlistcart(
      BuildContext context, ModelDetailTransaksi modeldata) {
    return ListView.builder(
        itemCount: modeldata.data.product.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: kPrimaryLightColor),
            width: double.infinity,
            height: getProportionateScreenWidth(130),
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
                          imageUrl: modeldata.data.product[index].image,
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(10)),
                        child: Column(
                          children: [
                            Container(
                              width: getProportionateScreenWidth(200),
                              child: Text(
                                modeldata.data.product[index].productName,
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
                            Row(
                              children: [
                                buildtextnormal(
                                    modeldata.data.product[index].quantity,
                                    kTextColor,
                                    false),
                                buildtextnormal(' x ', kTextColor, false),
                                buildtextnormal(
                                    NumberFormat.currency(
                                            locale: 'id', name: 'Rp ')
                                        .format(int.parse(modeldata
                                            .data.product[index].totalPrice)),
                                    kTextColor,
                                    false)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                print('Card tapped.');
              },
            ),
          );
        });
  }
}
