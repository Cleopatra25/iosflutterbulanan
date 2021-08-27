import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelProduct.dart';
import 'package:bulanan/models/Modellastseen.dart';
import 'package:bulanan/screens/details/details_screen.dart';
import 'package:bulanan/screens/home/components/childlistproduct.dart';
import 'package:bulanan/screens/home/components/section_title.dart';
import 'package:bulanan/screens/search/components/childlastseen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Terakhir extends StatefulWidget {
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final String idMembers;
  final Function updatecarts;
  Terakhir(
      {Key key,
      this.authHeaders,
      this.idDevices,
      this.idCitys,
      this.idMembers,
      this.updatecarts})
      : super(key: key);
  @override
  _TerakhirState createState() => _TerakhirState();
}

class _TerakhirState extends State<Terakhir> {
  Modellastseen model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getlastseen(context);
  }

  FutureBuilder<Response<dynamic>> getlastseen(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getLastseen('sembako168', widget.idMembers, widget.idDevices),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          model = Modellastseen.fromJson(snapshot.data.body);
          // print(bannerlist);
          return _buildcitylayout(context, model);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildcitylayout(BuildContext context, Modellastseen modelproduct) {
    return ListView.builder(
      itemCount: modelproduct.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
            child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: {'idProduct': modelproduct.data[index].idProduct},
            );
          },
          child: Container(
              width: double.infinity,
              height: getProportionateScreenWidth(130),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Row(
                    children: [
                      Container(
                        width: getProportionateScreenHeight(100),
                        height: getProportionateScreenHeight(90),
                        child: CachedNetworkImage(
                          imageUrl: modelproduct.data[index].image,
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
                                modelproduct.data[index].productName,
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
                            if (modelproduct.data[index].discount.toString() ==
                                    '0' ||
                                modelproduct.data[index].discount == null) ...[
                              Container(
                                  width: getProportionateScreenWidth(200),
                                  child: buildtextnormal(
                                      NumberFormat.currency(
                                              locale: 'id', name: 'Rp ')
                                          .format(int.parse(modelproduct
                                              .data[index].pricePerUnit)),
                                      kTextColor,
                                      false)),
                            ] else ...[
                              Container(
                                width: getProportionateScreenWidth(200),
                                child: buildtextnormal(
                                    NumberFormat.currency(
                                            locale: 'id', name: 'Rp ')
                                        .format(int.parse(modelproduct
                                            .data[index].pricePerUnit)),
                                    kTextColor,
                                    true),
                              ),
                              Container(
                                width: getProportionateScreenWidth(200),
                                child: buildtextbold(
                                    NumberFormat.currency(
                                            locale: 'id', name: 'Rp ')
                                        .format(int.parse(
                                            modelproduct.data[index].discount)),
                                    accentColor),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
      },
    );
  }
}
