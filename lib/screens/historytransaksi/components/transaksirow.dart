import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bulanan/models/ModelTransaksi.dart';
import 'package:bulanan/screens/detailhistory/detailhostory_sceen.dart';

import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class Transaksirow extends StatefulWidget {
  final ModelTransaksi models;

  Transaksirow({
    Key key,
    this.models,
  }) : super(key: key);

  @override
  _TransaksirowState createState() => _TransaksirowState();
}

class _TransaksirowState extends State<Transaksirow> {
  @override
  Widget build(BuildContext context) {
    return _buildlist(context, widget.models);
  }

  ListView _buildlist(BuildContext context, ModelTransaksi modelproduct) {
    return ListView.builder(
        itemCount: modelproduct.data.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(getProportionateScreenWidth(10)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailHistoryScreen.routeName,
                  arguments: {
                    'idtransaction': modelproduct.data[index].transactionCode,
                  },
                ).then((value) {
                  print('were back');
                });
              },
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            buildtextSize('No Invoice : ', kPrimaryColor,
                                getProportionateScreenWidth(12)),
                            SizedBox(
                              width: 10,
                            ),
                            buildtextSize(
                                modelproduct.data[index].transactionCode,
                                kPrimaryColor,
                                getProportionateScreenWidth(12))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            buildtextSize(
                                'Tanggal Transaksi : ',
                                Colors.black87,
                                getProportionateScreenWidth(12)),
                            SizedBox(
                              width: 10,
                            ),
                            buildtextSize(modelproduct.data[index].createdDate,
                                Colors.black87, getProportionateScreenWidth(12))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildtextSize(
                              NumberFormat.currency(locale: 'id', name: 'Rp ')
                                  .format(int.parse(
                                      modelproduct.data[index].totalNominal)),
                              Colors.black87,
                              getProportionateScreenWidth(12)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          height: getProportionateScreenHeight(50),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: listproduct(context, index),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        buildtextSize('Lihat Semua', accentColor,
                            getProportionateScreenWidth(11)),
                      ],
                    ),
                    if (modelproduct.data[index].status == 'Pending') ...[
                      Container(
                        width: getProportionateScreenWidth(70),
                        height: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                            color: yellowcolor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10))),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize(modelproduct.data[index].status,
                              kTextWhite, getProportionateScreenWidth(11)),
                        ),
                      ),
                    ] else if (modelproduct.data[index].status ==
                        'Processing') ...[
                      Container(
                        width: getProportionateScreenWidth(70),
                        height: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10))),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize(modelproduct.data[index].status,
                              kTextWhite, getProportionateScreenWidth(11)),
                        ),
                      ),
                    ] else if (modelproduct.data[index].status ==
                        'Canceled') ...[
                      Container(
                        width: getProportionateScreenWidth(70),
                        height: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                            color: redcolor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10))),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize(modelproduct.data[index].status,
                              kTextWhite, getProportionateScreenWidth(11)),
                        ),
                      ),
                    ] else if (modelproduct.data[index].status ==
                        'Completed') ...[
                      Container(
                        width: getProportionateScreenWidth(70),
                        height: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(10))),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize(modelproduct.data[index].status,
                              kTextWhite, getProportionateScreenWidth(11)),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        });
  }

  ListView listproduct(BuildContext context, int position) {
    return ListView.builder(
        itemCount: widget.models.data[position].products.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: getProportionateScreenHeight(50),
            height: getProportionateScreenHeight(50),
            alignment: Alignment.centerLeft,
            child: CachedNetworkImage(
              imageUrl: widget.models.data[position].products[index].image,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          );
        });
  }
}
