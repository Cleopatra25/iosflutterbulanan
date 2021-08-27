import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/models/Cart.dart';
import 'package:bulanan/screens/search/components/bodySearch.dart';
import 'package:bulanan/screens/searchresult/components/bodysearchresult.dart';

class SearchResultScreen extends StatefulWidget {
  static String routeName = "/searchresult";

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String keyword = '';

    if (arguments != null) {
      keyword = arguments['keyword'];
    }
    return Scaffold(
      body: BodySearchResult(keyword: keyword),
    );
  }
}
