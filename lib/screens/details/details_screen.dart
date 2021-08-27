import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String idProduct = '';

    if (arguments != null) {
      idProduct = arguments['idProduct'];
    }
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(idProduct: idProduct),
    );
  }
}
