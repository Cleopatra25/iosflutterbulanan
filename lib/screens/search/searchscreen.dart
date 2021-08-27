import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/models/Cart.dart';
import 'package:bulanan/screens/search/components/bodySearch.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySearch(),
    );
  }
}
