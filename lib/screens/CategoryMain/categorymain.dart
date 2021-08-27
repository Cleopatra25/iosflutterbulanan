import 'package:flutter/material.dart';
import 'package:bulanan/screens/CategoryMain/components/body.dart';

class CategorymainScreen extends StatelessWidget {
  static String routeName = "/categorymain";
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String idCatgeoryparent = '';
    String namecategory = '';

    if (arguments != null) {
      idCatgeoryparent = arguments['idCategory'];
      namecategory = arguments['namecategory'];
    }

    return Scaffold(
        body: Body(
      idCategoryparent: idCatgeoryparent,
      namecategory: namecategory,
    ));
  }
}
