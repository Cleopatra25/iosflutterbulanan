import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelCategory.dart';

import 'maincategorycomponen.dart';

class Maincategory extends StatefulWidget {
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final String idMembers;
  final Function updatecarts;
  Maincategory(
      {Key key,
      this.authHeaders,
      this.idDevices,
      this.idCitys,
      this.idMembers,
      this.updatecarts})
      : super(key: key);
  @override
  _MaincategoryState createState() => _MaincategoryState();
}

class _MaincategoryState extends State<Maincategory> {
  ModelCategory model;

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
      future: Provider.of<NetworkApiService>(context)
          .getHomeCategory2('sembako168', widget.idCitys, '0', '0'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          model = ModelCategory.fromJson(snapshot.data.body);
          // print(bannerlist);
          return buildlistcategory(context, model);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView buildlistcategory(BuildContext context, ModelCategory modelproduct) {
    return ListView.builder(
      itemCount: modelproduct.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Maincategorycomponen(
          modelCategory: modelproduct,
          index: index,
          updatecarts: widget.updatecarts,
        );
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
