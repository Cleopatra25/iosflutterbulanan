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
import 'package:bulanan/screens/CategoryMain/components/listtab.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';
import 'childcategorymain.dart';

// ignore: must_be_immutable
class ContentCategory extends StatefulWidget {
  final String idProductCategory;
  final String idMember;
  final String idCity;
  final String idDevice;
  final String authHeader;
  final Function updatecarts;
  ContentCategory(
      {Key key,
      this.idProductCategory,
      this.idMember,
      this.idCity,
      this.idDevice,
      this.authHeader,
      this.updatecarts})
      : super(key: key);

  @override
  _ContentCategoryState createState() => _ContentCategoryState();
}

class _ContentCategoryState extends State<ContentCategory> {
  ModelCategoryMainProduct modelcategory;
  int offsed = 0;
  List<Datas> datas = [];

  @override
  Widget build(BuildContext context) {
    return _buildchildtab(context, widget.idProductCategory);
  }

  FutureBuilder<Response<dynamic>> _buildchildtab(
      BuildContext context, String idCategory) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getMaincategoryProduct(
          'sembako168',
          widget.idMember,
          widget.idDevice,
          widget.idCity,
          idCategory,
          offsed.toString(),
          '8'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          modelcategory = ModelCategoryMainProduct.fromJson(snapshot.data.body);
          return Listtab(
            idCity: widget.idCity,
            idDevice: widget.idDevice,
            idMember: widget.idMember,
            idProductCategory: widget.idProductCategory,
            authHeader: widget.authHeader,
            updatecarts: widget.updatecarts,
            model: modelcategory,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
