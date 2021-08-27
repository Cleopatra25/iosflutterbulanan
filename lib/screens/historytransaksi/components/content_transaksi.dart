import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelCategoryMainProduct.dart';
import 'package:bulanan/models/ModelTransaksi.dart';
import 'package:bulanan/models/ModelproductLoadmore.dart';
import 'package:bulanan/screens/CategoryMain/components/listtab.dart';
import 'package:bulanan/screens/historytransaksi/components/transaksirow.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class ContentTransaksi extends StatefulWidget {
  final int position;
  final String idMember;
  final String idCity;
  final String idDevice;
  final String authHeader;
  ContentTransaksi({
    Key key,
    this.position,
    this.idMember,
    this.idCity,
    this.idDevice,
    this.authHeader,
  }) : super(key: key);

  @override
  _ContentTransaksiState createState() => _ContentTransaksiState();
}

class _ContentTransaksiState extends State<ContentTransaksi> {
  ModelTransaksi models;
  @override
  Widget build(BuildContext context) {
    if (widget.position == 0) {
      return _getall(context, widget.position);
    } else if (widget.position == 1) {
      return _getpending(context, widget.position);
    } else if (widget.position == 2) {
      return _getOngoing(context, widget.position);
    } else if (widget.position == 3) {
      return _getDone(context, widget.position);
    } else {
      return _getCancel(context, widget.position);
    }
  }

  FutureBuilder<Response<dynamic>> _getall(BuildContext context, int position) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getAll('sembako168', widget.authHeader, widget.idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            models = ModelTransaksi.fromJson(snapshot.data.body);
            return Transaksirow(
              models: models,
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: buildtextSize('Tidak Ada Transaksi', Colors.black87,
                    getProportionateScreenWidth(15)),
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

  FutureBuilder<Response<dynamic>> _getpending(
      BuildContext context, int position) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getPending('sembako168', widget.authHeader, widget.idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            models = ModelTransaksi.fromJson(snapshot.data.body);
            return Transaksirow(
              models: models,
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: buildtextSize('Tidak Ada Transaksi', Colors.black87,
                    getProportionateScreenWidth(15)),
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

  FutureBuilder<Response<dynamic>> _getOngoing(
      BuildContext context, int position) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getOngoing('sembako168', widget.authHeader, widget.idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            models = ModelTransaksi.fromJson(snapshot.data.body);
            return Transaksirow(
              models: models,
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: buildtextSize('Tidak Ada Transaksi', Colors.black87,
                    getProportionateScreenWidth(15)),
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

  FutureBuilder<Response<dynamic>> _getCancel(
      BuildContext context, int position) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getCancel('sembako168', widget.authHeader, widget.idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            models = ModelTransaksi.fromJson(snapshot.data.body);
            return Transaksirow(
              models: models,
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: buildtextSize('Tidak Ada Transaksi', Colors.black87,
                    getProportionateScreenWidth(15)),
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

  FutureBuilder<Response<dynamic>> _getDone(
      BuildContext context, int position) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context)
          .getCompleted('sembako168', widget.authHeader, widget.idMember),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            models = ModelTransaksi.fromJson(snapshot.data.body);
            return Transaksirow(
              models: models,
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: buildtextSize('Tidak Ada Transaksi', Colors.black87,
                    getProportionateScreenWidth(15)),
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
}
