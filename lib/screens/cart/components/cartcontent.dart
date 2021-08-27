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
import 'package:bulanan/screens/cart/cardrow.dart';
import 'package:bulanan/screens/cart/components/childcart.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class Cartcontent extends StatefulWidget {
  final String idMember;
  final String idCity;
  final String idDevice;
  final String authHeader;
  final Function updatecarts;
  Cartcontent(
      {Key key,
      this.idMember,
      this.idCity,
      this.idDevice,
      this.authHeader,
      this.updatecarts})
      : super(key: key);

  @override
  _CartcontentState createState() => _CartcontentState();
}

class _CartcontentState extends State<Cartcontent> {
  ModelCart model;

  @override
  Widget build(BuildContext context) {
    return _buildchildtab(context);
  }

  FutureBuilder<Response<dynamic>> _buildchildtab(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getCart(
        'sembako168',
        widget.authHeader,
        widget.idDevice,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            model = ModelCart.fromJson(snapshot.data.body);
            return _buildlistcart(context, model);
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: buildtextSize('Keranjang kosong', Colors.black87,
                    getProportionateScreenWidth(12)),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildlistcart(BuildContext context, ModelCart modelproduct) {
    return ListView.builder(
        itemCount: modelproduct.data.product.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (modelproduct.data.product[index].quantity == '0' ||
              modelproduct.data.product[index].quantity == null) {
            return null;
          } else {
            return Cartrow(
              idCity: widget.idCity,
              idDevice: widget.idDevice,
              idMember: widget.idMember,
              authHeader: widget.authHeader,
              updatecarts: widget.updatecarts,
              position: index,
              models: modelproduct,
            );
          }
        });
  }

  void removedata(int position) {
    setState(() {
      model.data.product.removeAt(position);
    });
  }
}
