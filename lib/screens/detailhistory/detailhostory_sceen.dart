import 'package:flutter/material.dart';
import 'package:bulanan/screens/checkout/components/body.dart';
import 'package:bulanan/screens/detailhistory/components/bodydetailhistory.dart';

class DetailHistoryScreen extends StatefulWidget {
  static String routeName = "/detailhistory";

  @override
  _DetailHistoryScreenState createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String idtransaction = '';

    if (arguments != null) {
      idtransaction = arguments['idtransaction'];
    }

    return Scaffold(
        body: BodyDetailHistory(
      idtranscation: idtransaction,
    ));
  }
}
