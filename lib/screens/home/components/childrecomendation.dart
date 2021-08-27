import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class Childrecomendation extends StatefulWidget {
  int quantitys;
  final String idProduk;
  final int position;
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final Function updatecarts;
  Childrecomendation(
      {Key key,
      this.quantitys,
      this.idProduk,
      this.position,
      this.authHeaders,
      this.idDevices,
      this.idCitys,
      this.updatecarts})
      : super(key: key);

  @override
  _ChildrecomendationState createState() => _ChildrecomendationState();
}

class _ChildrecomendationState extends State<Childrecomendation> {
  @override
  Widget build(BuildContext context) {
    int quants = widget.quantitys != null ? widget.quantitys : 'null';

    if (quants == null || quants == 0) {
      return GestureDetector(
          onTap: () {
            addCart(widget.idProduk, quants, widget.position, '1');
          },
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(8),
            width: double.infinity,
            height: getProportionateScreenHeight(40),
            decoration: BoxDecoration(
                color: kTextWhite,
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(7)),
                border: Border.all(
                    color: kPrimaryColor,
                    width: getProportionateScreenWidth(1))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(right: getProportionateScreenWidth(15)),
                  child: buildimages('assets/images/cart_primary.png'),
                ),
                buildtextbold('Tambah', kPrimaryColor)
              ],
            ),
          ));
    } else {
      return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(6),
        width: double.infinity,
        height: getProportionateScreenHeight(58),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenHeight(5)),
              child: GestureDetector(
                onTap: () {
                  addCart(widget.idProduk, quants, widget.position, '4');
                },
                child: buildimages('assets/images/delete.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenHeight(5)),
              child: GestureDetector(
                onTap: () {
                  addCart(widget.idProduk, quants, widget.position, '3');
                },
                child: buildimages('assets/images/min.png'),
              ),
            ),
            buildtextbold(
              widget.quantitys.toString(),
              kPrimaryColor,
            ),
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenHeight(5)),
              child: GestureDetector(
                onTap: () {
                  addCart(widget.idProduk, quants, widget.position, '2');
                },
                child: buildimagescustom(
                    'assets/images/plush.png',
                    getProportionateScreenHeight(40),
                    getProportionateScreenWidth(40)),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> addCart(
      String idProduct, int quantity, int position, String status) async {
    int quantityPost;

    if (status == '1') {
      quantityPost = 1;
    } else if (status == '2') {
      quantityPost = quantity + 1;
    } else if (status == '3') {
      quantityPost = quantity - 1;
    } else if (status == '4') {
      quantityPost = 0;
    }

    final response =
        await Provider.of<NetworkApiService>(context, listen: false).postCart(
            'sembako168',
            widget.authHeaders,
            idProduct,
            widget.idDevices,
            widget.idCitys,
            quantityPost.toString());

    print(response.body);

    if (response.isSuccessful) {
      if (response.body['status'] == true) {
        widget.updatecarts();
        setState(() {
          widget.quantitys = quantityPost;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body['message']),
        ));
      }
    }
  }
}
