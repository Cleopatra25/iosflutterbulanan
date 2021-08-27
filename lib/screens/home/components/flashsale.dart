import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelFlashsale.dart';
import 'package:bulanan/screens/home/components/childlistflashsale.dart';
import 'package:bulanan/screens/home/components/flashsalecountdown.dart';
import 'package:bulanan/screens/home/components/section_title.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Flashsale extends StatefulWidget {
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final String idMembers;
  final Function updatecarts;
  Flashsale(
      {Key key,
      this.authHeaders,
      this.idDevices,
      this.idCitys,
      this.idMembers,
      this.updatecarts})
      : super(key: key);
  @override
  _FlashsaleState createState() => _FlashsaleState();
}

class _FlashsaleState extends State<Flashsale> {
  ModelFlashsale model;
  bool visiblitys = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visiblitys,
        child: SizedBox(
          height: getProportionateScreenHeight(290),
          width: double.infinity,
          child: _buildflashsale(context),
        ));
  }

  FutureBuilder<Response<dynamic>> _buildflashsale(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getFlashsale('sembako168', widget.idCitys),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.isSuccessful) {
            print(json.decode(snapshot.data.bodyString));
            model = ModelFlashsale.fromJson(snapshot.data.body);
            // print(bannerlist);
            return _buildFlashsalelayout(context, model);
          } else {
            return null;
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column _buildFlashsalelayout(
      BuildContext context, ModelFlashsale modelproduct) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
            width: double.infinity,
            height: getProportionateScreenHeight(50),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SectionTitle(title: 'FlashSale', press: () {}),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FlashsaleCountdown(enddate: model.end),
                  ),
                ],
              ),
            )),
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(220),
          child: _listFlashsale(context, modelproduct),
        ),
      ],
    );
  }

  ListView _listFlashsale(BuildContext context, ModelFlashsale modelproduct) {
    return ListView.builder(
      itemCount: modelproduct.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Card(
            child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: getProportionateScreenWidth(130),
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
                        imageUrl: modelproduct.data[index].image,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                    if (modelproduct.data[index].percent.toString() != 'null' ||
                        modelproduct.data[index].percent != null ||
                        modelproduct.data[index].percent.toString() != '0') ...[
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
                if (modelproduct.data[index].priceFlashSale.toString() == '0' ||
                    modelproduct.data[index].priceFlashSale == null) ...[
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
                          int.parse(modelproduct.data[index].priceFlashSale)),
                      accentColor),
                ],
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      right: getProportionateScreenWidth(10),
                      left: getProportionateScreenWidth(10)),
                  child: textTerjual(
                      context,
                      modelproduct.data[index].quantityBuy,
                      modelproduct.data[index].quantityFlashSale),
                ),
                Childlistflashsale(
                    quantitys: model.data[index].quantity,
                    idProduk: model.data[index].idProduct,
                    position: index,
                    authHeaders: widget.authHeaders,
                    idDevices: widget.idDevices,
                    idCitys: widget.idCitys,
                    updatecarts: widget.updatecarts)
              ],
            ),
          ),
        ));
      },
    );
  }

  Row textTerjual(
      BuildContext context, String quantitybuy, String quantityflashsale) {
    if (quantitybuy != null || quantitybuy.toString() != 'null') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildtextSize(
              quantityflashsale, kTextWhite, getProportionateScreenHeight(8)),
          buildtextSize('/', kTextWhite, getProportionateScreenHeight(8)),
          buildtextSize(
              quantitybuy, kTextWhite, getProportionateScreenHeight(8)),
          buildtextSize(
              ' Terjual', kTextWhite, getProportionateScreenHeight(8)),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildtextSize(
              quantityflashsale, kTextWhite, getProportionateScreenHeight(8)),
          buildtextSize('/', kTextWhite, getProportionateScreenHeight(8)),
          buildtextSize('0', kTextWhite, getProportionateScreenHeight(8)),
          buildtextSize(
              ' Terjual', kTextWhite, getProportionateScreenHeight(8)),
        ],
      );
    }
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
