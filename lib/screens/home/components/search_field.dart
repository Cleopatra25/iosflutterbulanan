import 'dart:convert';

import 'package:bulanan/models/ModelCity.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class SearchField extends StatefulWidget {
  String idCitys;
  String nameCitys;
  SearchField({Key key, this.nameCitys, this.idCitys}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<SearchField> {
  ModelCity model;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: double.maxFinite,
                height: getProportionateScreenWidth(200),
                child: _buildpopupcity(context),
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Image.asset(
                "assets/images/car_icon.png",
                width: getProportionateScreenWidth(10),
                height: getProportionateScreenWidth(10),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: widget.nameCitys ?? 'Pilih kota',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(11),
                          color: kTextColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<Response<dynamic>> _buildpopupcity(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getCityHome('sembako168'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          model = ModelCity.fromJson(snapshot.data.body);

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

  ListView _buildcitylayout(BuildContext context, ModelCity isicity) {
    return ListView.builder(
      itemCount: isicity.data.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          child: ListTile(
            title: Text(isicity.data[index].cityName),
            onTap: () async {
              SharedPreferences myshare = await SharedPreferences.getInstance();
              await myshare.setString("id_city", isicity.data[index].cityId);
              await myshare.setString(
                  "name_city", isicity.data[index].cityName);
              Navigator.pop(context);
              setState(() {
                widget.idCitys = isicity.data[index].cityId;
                widget.nameCitys = isicity.data[index].cityName;
              });
            },
          ),
        );
      },
    );
  }
}
