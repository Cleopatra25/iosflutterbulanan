import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelRecomended.dart';
import 'package:bulanan/screens/details/details_screen.dart';
import 'package:bulanan/screens/home/components/childrecomendation.dart';
import 'package:bulanan/screens/home/components/section_title.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Recomendation extends StatefulWidget {
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final String idMembers;
  final Function updatecarts;
  Recomendation(
      {Key key,
      this.authHeaders,
      this.idDevices,
      this.idCitys,
      this.idMembers,
      this.updatecarts})
      : super(key: key);
  @override
  _RecomendationState createState() => _RecomendationState();
}

class _RecomendationState extends State<Recomendation> {
  ModelRecomended model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(354),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(getProportionateScreenWidth(8)),
            height: getProportionateScreenHeight(29),
            child: SectionTitle(title: 'Rekomendasi', press: () {}),
          ),
          Container(
            width: double.infinity,
            height: getProportionateScreenHeight(274),
            child: _buildpromo(context),
          ),
        ],
      ),
    );
  }

  FutureBuilder<Response<dynamic>> _buildpromo(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getrecomended(
          'sembako168', widget.idMembers, widget.idDevices, widget.idCitys),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          model = ModelRecomended.fromJson(snapshot.data.body);
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

  ListView _buildcitylayout(
      BuildContext context, ModelRecomended modelproduct) {
    return ListView.builder(
      itemCount: modelproduct.data.length,
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
              arguments: {'idProduct': modelproduct.data[index].idProduct},
            );
          },
          child: Container(
            width: getProportionateScreenWidth(152),
            height: double.infinity,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: getProportionateScreenWidth(110),
                      height: getProportionateScreenWidth(110),
                      margin: EdgeInsets.all(8),
                      child: CachedNetworkImage(
                        imageUrl: modelproduct.data[index].image,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                    if (modelproduct.data[index].percent.toString() != 'null' ||
                        modelproduct.data[index].percent != null) ...[
                      Container(
                        alignment: Alignment.center,
                        width: getProportionateScreenWidth(30),
                        height: getProportionateScreenHeight(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(8)),
                            color: accentColor),
                        child: Text(
                          modelproduct.data[index].percent.toString() + '%',
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
                    modelproduct.data[index].productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenHeight(10),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (modelproduct.data[index].isPromo.toString() == '0' ||
                    modelproduct.data[index].isPromo == null) ...[
                  buildtextnormal(
                      NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                          int.parse(modelproduct.data[index].pricePerUnit)),
                      kTextColor,
                      false)
                ] else ...[
                  buildtextnormal(
                      NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                          int.parse(modelproduct.data[index].pricePerUnit)),
                      kTextColor,
                      true),
                  buildtextbold(
                      NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                          int.parse(modelproduct.data[index].pricePromo)),
                      accentColor),
                ],
                Childrecomendation(
                  quantitys: model.data[index].quantity.quantity,
                  idProduk: model.data[index].idProduct,
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
