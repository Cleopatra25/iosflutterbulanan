import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelHighlight.dart';
import 'package:bulanan/screens/details/details_screen.dart';
import 'package:bulanan/screens/home/components/childlisthighlight.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Highlight extends StatefulWidget {
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final String idMembers;
  final Function updatecarts;
  Highlight(
      {Key key,
      this.authHeaders,
      this.idDevices,
      this.idCitys,
      this.idMembers,
      this.updatecarts})
      : super(key: key);
  @override
  _HighlightState createState() => _HighlightState();
}

class _HighlightState extends State<Highlight> {
  ModelHighlight model;
  double margincard = getProportionateScreenWidth(30);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildhighlight(context);
  }

  FutureBuilder<Response<dynamic>> _buildhighlight(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getHighlight(
          'sembako168', widget.idMembers, widget.idDevices, widget.idCitys),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          model = ModelHighlight.fromJson(snapshot.data.body);
          // print(bannerlist);
          return _buildhighlightlayout(context, model);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildhighlightlayout(
      BuildContext context, ModelHighlight modelproduct) {
    return ListView.builder(
      itemCount: modelproduct.data.length,
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          height: getProportionateScreenHeight(355),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: getProportionateScreenHeight(35),
                margin: EdgeInsets.only(
                  right: getProportionateScreenWidth(10),
                  left: getProportionateScreenWidth(10),
                ),
                child: buildtextbold(
                    modelproduct.data[index].tittle, Colors.black87),
              ),
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(320),
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  modelproduct.data[index].image)))),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: getProportionateScreenHeight(20)),
                      width: double.infinity,
                      height: getProportionateScreenHeight(274),
                      child: _buildListhighlight(context, index, modelproduct),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  ListView _buildListhighlight(
      BuildContext context, int position, ModelHighlight modelproduct) {
    return ListView.builder(
      itemCount: modelproduct.data[position].product.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
              margin: EdgeInsets.only(left: getProportionateScreenWidth(150)),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: {
                      'idProduct':
                          modelproduct.data[position].product[index].idProduct
                    },
                  );
                },
                child: Container(
                  width: getProportionateScreenWidth(152),
                  height: double.infinity,
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                              margin: EdgeInsets.all(
                                  getProportionateScreenWidth(9)),
                              width: getProportionateScreenHeight(110),
                              height: getProportionateScreenHeight(110),
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      image: NetworkImage(modelproduct
                                          .data[position]
                                          .product[index]
                                          .image)))),
                          if (modelproduct.data[position].product[index].percent
                                      .toString() !=
                                  'null' ||
                              modelproduct
                                      .data[position].product[index].percent !=
                                  null) ...[
                            Container(
                              alignment: Alignment.center,
                              width: getProportionateScreenWidth(30),
                              height: getProportionateScreenHeight(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(8)),
                                  color: accentColor),
                              child: Text(
                                modelproduct
                                        .data[position].product[index].percent
                                        .toString() +
                                    '%',
                                style: TextStyle(
                                  color: kTextWhite,
                                  fontSize: getProportionateScreenHeight(10),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                        child: Text(
                          modelproduct
                              .data[position].product[index].productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: getProportionateScreenHeight(10),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (modelproduct.data[position].product[index].discount
                                  .toString() ==
                              '0' ||
                          modelproduct.data[position].product[index].discount ==
                              null) ...[
                        buildtextnormal(
                            NumberFormat.currency(locale: 'id', name: 'Rp ')
                                .format(int.parse(modelproduct.data[position]
                                    .product[index].pricePerUnit)),
                            kTextColor,
                            false)
                      ] else ...[
                        buildtextnormal(
                            NumberFormat.currency(locale: 'id', name: 'Rp ')
                                .format(int.parse(modelproduct.data[position]
                                    .product[index].pricePerUnit)),
                            kTextColor,
                            true),
                        buildtextbold(
                            NumberFormat.currency(locale: 'id', name: 'Rp ')
                                .format(int.parse(modelproduct
                                    .data[position].product[index].discount)),
                            accentColor),
                      ],
                      Childlisthighlight(
                          quantitys: modelproduct
                              .data[position].product[index].quantity,
                          idProduk: modelproduct
                              .data[position].product[index].idProduct,
                          position: index,
                          authHeaders: widget.authHeaders,
                          idDevices: widget.idDevices,
                          idCitys: widget.idCitys,
                          updatecarts: widget.updatecarts)
                    ],
                  ),
                ),
              ));
        } else {
          return Card(
              child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: {
                  'idProduct':
                      modelproduct.data[position].product[index].idProduct
                },
              );
            },
            child: Container(
              width: getProportionateScreenWidth(152),
              height: double.infinity,
              margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: getProportionateScreenHeight(110),
                        height: getProportionateScreenHeight(110),
                        child: CachedNetworkImage(
                          imageUrl:
                              modelproduct.data[position].product[index].image,
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                      if (modelproduct.data[position].product[index].percent
                                  .toString() !=
                              'null' ||
                          modelproduct.data[position].product[index].percent !=
                              null) ...[
                        Container(
                          alignment: Alignment.center,
                          width: getProportionateScreenWidth(30),
                          height: getProportionateScreenHeight(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(8)),
                              color: accentColor),
                          child: Text(
                            modelproduct.data[position].product[index].percent
                                    .toString() +
                                '%',
                            style: TextStyle(
                              color: kTextWhite,
                              fontSize: getProportionateScreenHeight(10),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                    child: Text(
                      modelproduct.data[position].product[index].productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: getProportionateScreenHeight(10),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (modelproduct.data[position].product[index].discount
                              .toString() ==
                          '0' ||
                      modelproduct.data[position].product[index].discount ==
                          null) ...[
                    buildtextnormal(
                        NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                            int.parse(modelproduct
                                .data[position].product[index].pricePerUnit)),
                        kTextColor,
                        false)
                  ] else ...[
                    buildtextnormal(
                        NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                            int.parse(modelproduct
                                .data[position].product[index].pricePerUnit)),
                        kTextColor,
                        true),
                    buildtextbold(
                        NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                            int.parse(modelproduct
                                .data[position].product[index].discount)),
                        accentColor),
                  ],
                  Childlisthighlight(
                    quantitys:
                        modelproduct.data[position].product[index].quantity,
                    idProduk:
                        modelproduct.data[position].product[index].idProduct,
                    position: index,
                    authHeaders: widget.authHeaders,
                    idDevices: widget.idDevices,
                    idCitys: widget.idCitys,
                    updatecarts: widget.updatecarts,
                  )
                ],
              ),
            ),
          ));
        }
      },
    );
  }

  bool getVisiblity(String isi) {
    bool anying = false;
    if (isi == null || isi.toString() == 'null') {
      anying = false;
    } else {
      anying = true;
    }
    return anying;
  }
}
