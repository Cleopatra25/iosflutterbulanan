import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Bloc/updatecart.dart';
import 'package:bulanan/Bloc/updateharga.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/models/Cart.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/screens/cart/components/cartcontent.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/screens/search/components/lastseen.dart';
import 'package:bulanan/screens/search/components/searchcontent.dart';
import 'package:bulanan/screens/search/components/terakhirdilihat.dart';
import 'package:bulanan/screens/searchresult/components/searchresultcontent.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BodySearchResult extends StatefulWidget {
  final String keyword;
  BodySearchResult({
    Key key,
    this.keyword,
  }) : super(key: key);

  @override
  _BodySearchResultState createState() => _BodySearchResultState();
}

class _BodySearchResultState extends State<BodySearchResult> {
  ModelCart model;
  String rupiah = 'Rp 0';
  int counts = 0;
  UpdateCart bloccart = UpdateCart();
  UpdateHarga blocharga = UpdateHarga();
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';

  @override
  void initState() {
    getPreference();
    super.initState();
  }

  @override
  void dispose() {
    bloccart.dispose();
    blocharga.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: getPreference(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          addCart();

          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CheckoutScreen.routeName,
                    ).then((value) {
                      setState(() {});
                      print('were back');
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(55),
                    decoration: BoxDecoration(color: accentColor),
                    child: Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(13)),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: buildimagescustom(
                                'assets/images/addcart_white.png',
                                getProportionateScreenWidth(24),
                                getProportionateScreenHeight(24)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Wrap(
                              children: [
                                StreamBuilder(
                                    stream: bloccart.output,
                                    initialData: 0,
                                    builder: (context, snapshot) {
                                      return buildtextSize(
                                          '${snapshot.data} Barang',
                                          kTextWhite,
                                          getProportionateScreenWidth(13));
                                    }),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: getProportionateScreenWidth(10)),
                                  child: StreamBuilder(
                                      stream: blocharga.output,
                                      initialData: '0',
                                      builder: (context, snapshot) {
                                        return buildtextSize(
                                            snapshot.data,
                                            kTextWhite,
                                            getProportionateScreenWidth(13));
                                      }),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: buildtextSize('Ke kasir >', kTextWhite,
                                getProportionateScreenWidth(15)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: double.maxFinite,
                width: double.infinity,
                margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(15),
                    right: getProportionateScreenWidth(15),
                    bottom: getProportionateScreenHeight(100)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SearchResultContent(
                        idCitys: idCity,
                        idDevices: idDevice,
                        idMember: idMember,
                        authHeaders: authHeader,
                        updatecarts: addCart,
                        keyword: widget.keyword,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    ));
  }

  void addCart() async {
    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .getCart('sembako168', authHeader, idDevice);

    print(response.body);

    if (response.isSuccessful) {
      if (response.body['status'] == true) {
        model = ModelCart.fromJson(response.body);
        rupiah = NumberFormat.currency(locale: 'id', name: 'Rp ')
            .format(model.data.totalPrice);
        counts = model.data.totalProduct;
        print(counts);
        print(rupiah);
        bloccart.sinkin.add(counts);
        blocharga.sinkin.add(rupiah);
      }
    }
  }

  Future<String> getPreference() async {
    SharedPreferences myshare = await SharedPreferences.getInstance();
    idCity = myshare.getString('id_city') ?? '3271';
    idDevice = myshare.getString('id_device') ?? '';
    idMember = myshare.getString('id_member') ?? '';
    authHeader = myshare.getString('auth') ?? '';
    nameCity = myshare.getString('name_city') ?? 'Bogor';
    return idCity;
  }
}
