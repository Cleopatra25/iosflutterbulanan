import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/screens/search/components/searchrow.dart';
import 'package:bulanan/screens/searchresult/searchresult_screen.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class SearchContent extends StatefulWidget {
  final String authHeaders;
  final String idDevices;
  final String idCitys;
  final String idMember;
  final Function updatecarts;
  SearchContent({
    Key key,
    this.idMember,
    this.authHeaders,
    this.idDevices,
    this.idCitys,
    this.updatecarts,
  }) : super(key: key);

  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  TextEditingController searchcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: getProportionateScreenWidth(40),
          margin: EdgeInsets.only(
              top: getProportionateScreenWidth(10),
              bottom: getProportionateScreenHeight(20)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: buildimagescustom(
                        'assets/images/left_back_grey.png',
                        getProportionateScreenWidth(30),
                        getProportionateScreenWidth(30)),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(4))),
                    margin: EdgeInsets.only(
                        right: getProportionateScreenWidth(30),
                        left: getProportionateScreenWidth(20)),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        Navigator.pushNamed(
                          context,
                          SearchResultScreen.routeName,
                          arguments: {'keyword': value.toString()},
                        );
                      },
                      controller: searchcontroller,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Cari Produk ',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Searchrow(
          idCitys: widget.idCitys,
          idDevices: widget.idDevices,
          idMembers: widget.idMember,
          authHeaders: widget.authHeaders,
          controllers: searchcontroller,
        )
      ],
    );
  }
}
