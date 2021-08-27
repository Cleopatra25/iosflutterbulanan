import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  FutureBuilder<Response<dynamic>> _buildBody(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getBanner('sembako168'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));

          Map<String, dynamic> data = new Map<String, dynamic>.from(
              json.decode(snapshot.data.bodyString));

          List<dynamic> bannerlist = data["data"];
          // print(bannerlist);

          return _buildbanner(context, bannerlist);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  CarouselSlider _buildbanner(BuildContext context, List<dynamic> listbanner) {
    return CarouselSlider(
      options: CarouselOptions(
        height: getProportionateScreenWidth(180),
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: <Widget>[
        for (var i = 0; i < listbanner.length; i++)
          Container(
            margin: EdgeInsets.all(getProportionateScreenWidth(4)),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(listbanner[i]['image'], headers: {
                  'Access-Control-Allow-Origin': '*',
                  'api-key': 'sembako168'
                }),
                fit: BoxFit.fill,
              ),
              // border:
              //     Border.all(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
      ],
    );
  }
}
