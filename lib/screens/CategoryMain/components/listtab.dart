import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelCategoryMainProduct.dart';
import 'package:bulanan/models/ModelproductLoadmore.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';
import 'childcategorymain.dart';

// ignore: must_be_immutable
class Listtab extends StatefulWidget {
  final String idProductCategory;
  final String idMember;
  final String idCity;
  final String idDevice;
  final String authHeader;
  ModelCategoryMainProduct model;
  final Function updatecarts;
  Listtab(
      {Key key,
      this.idProductCategory,
      this.idMember,
      this.idCity,
      this.idDevice,
      this.authHeader,
      this.updatecarts,
      this.model})
      : super(key: key);

  @override
  _ListtabState createState() => _ListtabState();
}

class _ListtabState extends State<Listtab> {
  int offsed = 0;
  ScrollController _sc = new ScrollController();
  List<Datas> datas = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        offsed++;
        loadmore(offsed);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildchildtabview(context, widget.model);
  }

  ListView _buildchildtabview(
      BuildContext context, ModelCategoryMainProduct modelproduct) {
    return ListView.builder(
      controller: _sc,
      itemCount: modelproduct.data.length + 1,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        if (index == modelproduct.data.length) {
          return _buildProgressIndicator();
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
                              if (modelproduct.data[index].discount
                                          .toString() ==
                                      '0' ||
                                  modelproduct.data[index].discount ==
                                      null) ...[
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
                                          .format(int.parse(modelproduct
                                              .data[index].discount)),
                                      accentColor),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (modelproduct.data[index].percent.toString() != 'null' ||
                        modelproduct.data[index].percent != null) ...[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5),
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
                      )
                    ],
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ChildCategorymain(
                        quantitys: modelproduct.data[index].quantity,
                        idProduk: modelproduct.data[index].idProduct,
                        position: index,
                        authHeaders: widget.authHeader,
                        idDevices: widget.idDevice,
                        idCitys: widget.idCity,
                        updatecarts: widget.updatecarts,
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
      },
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> loadmore(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final response =
          await Provider.of<NetworkApiService>(context, listen: false)
              .getMaincategoryProduct(
                  'sembako168',
                  widget.idMember,
                  widget.idDevice,
                  widget.idCity,
                  widget.idProductCategory,
                  page.toString(),
                  '8');

      print(response.body);
      ModelCategoryMainProduct modelnew =
          ModelCategoryMainProduct.fromJson(response.body);

      setState(() {
        isLoading = false;

        widget.model.data.addAll(modelnew.data);
      });
    }
  }
}
