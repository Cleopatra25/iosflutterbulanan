import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bulanan/models/ModelCategory.dart';
import 'package:bulanan/screens/CategoryMain/categorymain.dart';
import 'package:bulanan/size_config.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class Maincategorycomponen extends StatefulWidget {
  final ModelCategory modelCategory;
  final int index;
  final Function updatecarts;

  Maincategorycomponen({
    Key key,
    this.modelCategory,
    this.index,
    this.updatecarts,
  }) : super(key: key);

  @override
  _MaincategorycomponenState createState() => _MaincategorycomponenState();
}

class _MaincategorycomponenState extends State<Maincategorycomponen> {
  bool isexpanded = false;
  String imagearrow = 'assets/images/adown_orange.png';
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            setState(() {
              if (isexpanded) {
                isexpanded = false;
                imagearrow = 'assets/images/adown_orange.png';
              } else {
                isexpanded = true;
                imagearrow = 'assets/images/aup_orange.png';
              }
            });
          },
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: getProportionateScreenWidth(5)),
                  height: getProportionateScreenHeight(120),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          width: getProportionateScreenHeight(90),
                          height: getProportionateScreenHeight(90),
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                                  image: NetworkImage(widget.modelCategory
                                      .data[widget.index].image)))),
                      Container(
                        width: getProportionateScreenWidth(210),
                        height: getProportionateScreenHeight(120),
                        margin: EdgeInsets.only(
                            left: getProportionateScreenWidth(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: buildtextSize(
                                    widget.modelCategory.data[widget.index]
                                        .discFrom
                                        .toString(),
                                    accentColor,
                                    getProportionateScreenHeight(10))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: buildtextbold(
                                    widget.modelCategory.data[widget.index]
                                        .categoryName
                                        .toString(),
                                    kPrimaryColor)),
                            Align(
                                alignment: Alignment.topLeft,
                                child: buildtextSize(
                                    widget.modelCategory.data[widget.index]
                                        .description
                                        .toString(),
                                    kTextColor,
                                    getProportionateScreenHeight(10))),
                          ],
                        ),
                      ),
                      buildimagescustom(
                          imagearrow,
                          getProportionateScreenWidth(20),
                          getProportionateScreenWidth(20))
                    ],
                  )),
              if (isexpanded) ...[
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: new List<Widget>.generate(
                      widget.modelCategory.data[widget.index].sub.length,
                      (indexing) {
                    return new GridTile(
                      child: InkResponse(
                          // color:Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: getProportionateScreenHeight(60),
                                  height: getProportionateScreenHeight(60),
                                  decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                          image: NetworkImage(widget
                                              .modelCategory
                                              .data[widget.index]
                                              .sub[indexing]
                                              .image)))),
                              Align(
                                  alignment: Alignment.center,
                                  child: buildtextSizecenter(
                                      widget.modelCategory.data[widget.index]
                                          .sub[indexing].categoryName,
                                      Colors.black54,
                                      getProportionateScreenHeight(10))),
                            ],
                          ),
                          enableFeedback: true,
                          onTap: () {
                            // print(widget
                            //     .modelCategory.data[indexing].idProductCategory
                            //     .toString());
                            Navigator.pushNamed(
                              context,
                              CategorymainScreen.routeName,
                              arguments: {
                                'idCategory': widget
                                    .modelCategory
                                    .data[widget.index]
                                    .sub[indexing]
                                    .idProductCategory
                                    .toString(),
                                'namecategory': widget
                                    .modelCategory
                                    .data[widget.index]
                                    .sub[indexing]
                                    .categoryName
                              },
                            ).then((value) {
                              widget.updatecarts();
                              print('were back');
                            });
                          }), // Whatever you want on tap
                    );
                  }),
                ),
              ],
            ],
          )),
    );
  }
}
