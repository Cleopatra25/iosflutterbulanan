import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/models/ModelProduct.dart';
import 'package:bulanan/models/ModelSearch.dart';
import 'package:bulanan/screens/details/details_screen.dart';
import 'package:bulanan/screens/home/components/childlistproduct.dart';
import 'package:bulanan/screens/home/components/section_title.dart';
import 'package:bulanan/screens/search/components/childlastseen.dart';
import 'package:bulanan/screens/searchresult/searchresult_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class Searchrow extends StatefulWidget {
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final String idMembers;
  TextEditingController controllers;
  Searchrow(
      {Key key,
      this.authHeaders,
      this.idDevices,
      this.idCitys,
      this.idMembers,
      this.controllers})
      : super(key: key);
  @override
  _SearchrowState createState() => _SearchrowState();
}

class _SearchrowState extends State<Searchrow> {
  ModelSearch model;
  ModelSearch modelbayang;
  String keyword = '';
  StreamController<ModelSearch> _searchstream;
  Timer _debounce;

  @override
  void dispose() {
    widget.controllers.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  void initState() {
    _searchstream = StreamController<ModelSearch>();

    widget.controllers.addListener(() {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        print("value: ${widget.controllers.text}");
        if (widget.controllers.text != null || widget.controllers.text != '') {
          addCart(widget.controllers.text);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: _searchstream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildcitylayout(context, snapshot.data);
              } else {
                return Center(
                  child: buildtextSize('Tidak ada data yang anda cari',
                      Colors.black54, getProportionateScreenWidth(13)),
                );
              }
            }),
      ],
    );
  }

  FutureBuilder<Response<dynamic>> getlastseen(
      BuildContext context, String keyword) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).postSearch(
          'sembako168', keyword, widget.idMembers, widget.idDevices),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.body['status'] == true) {
            print(json.decode(snapshot.data.bodyString));
            model = ModelSearch.fromJson(snapshot.data.body);
            // print(bannerlist);
            return _buildcitylayout(context, model);
          } else {
            return Center(
              child: CircularProgressIndicator(),
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

  void addCart(String keys) async {
    if (widget.idMembers != null) {
      final response = await Provider.of<NetworkApiService>(context,
              listen: false)
          .postSearch('sembako168', keys, widget.idMembers, widget.idDevices);

      print(response.body);
      model = ModelSearch.fromJson(response.body);
      if (response.body['status'] == true) {
        _searchstream.add(model);
      } else {
        _searchstream.add(null);
      }
    }
  }

  ListView _buildcitylayout(BuildContext context, ModelSearch modelproduct) {
    return ListView.builder(
      itemCount: modelproduct.data.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(
              context,
              SearchResultScreen.routeName,
              arguments: {'keyword': modelproduct.data[index].productName},
            );
          },
          child: Container(
              width: double.infinity,
              height: getProportionateScreenWidth(40),
              margin: EdgeInsets.all(getProportionateScreenWidth(10)),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildimagescustom(
                              'assets/images/magnify_grey.png',
                              getProportionateScreenWidth(30),
                              getProportionateScreenWidth(30)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: buildtextSizeelipsize(
                                modelproduct.data[index].productName,
                                Colors.black87,
                                getProportionateScreenWidth(13)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: buildimagescustom(
                          'assets/images/arrowtopleft_grey.png',
                          getProportionateScreenWidth(30),
                          getProportionateScreenWidth(30)),
                    ),
                  ),
                ],
              )),
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
