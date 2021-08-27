import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Bloc/bloccoupon.dart';
import 'package:bulanan/Bloc/blocgrandtotal.dart';
import 'package:bulanan/Bloc/blocpembayaran.dart';
import 'package:bulanan/Bloc/updatecart.dart';
import 'package:bulanan/Bloc/updatecartantar.dart';
import 'package:bulanan/Bloc/updatecartdiscount.dart';
import 'package:bulanan/Bloc/updateharga.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/header.dart';
import 'package:bulanan/models/Cart.dart';
import 'package:bulanan/models/ModelCart.dart';
import 'package:bulanan/models/ModelDetailTransaksi.dart';
import 'package:bulanan/screens/cart/components/cartcontent.dart';
import 'package:bulanan/screens/cekmutasi/cekmutasi_screen.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/checkout/components/checkoutpembayaran.dart';
import 'package:bulanan/screens/checkout/components/summarybody.dart';
import 'package:bulanan/screens/coupon/coupon_screen.dart';
import 'package:bulanan/screens/detailhistory/components/detailchild.dart';
import 'package:bulanan/screens/detailhistory/components/detailtransaksipembayaran.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/screens/webview/webview_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Detailcomponents extends StatefulWidget {
  final String idTransaction;
  final String idMember;
  final String auth;
  Detailcomponents({
    Key key,
    this.idTransaction,
    this.idMember,
    this.auth,
  }) : super(key: key);
  @override
  _DetailcomponentsState createState() => _DetailcomponentsState();
}

class _DetailcomponentsState extends State<Detailcomponents> {
  ModelDetailTransaksi model;
  BlocPembayaran blocpembayaran = BlocPembayaran();
  String paymentgateway = '';
  String transactioncode = '';
  String noinvoice = '';
  String grandtotalunique = '';
  BuildContext dialogContext;
  BuildContext alertContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    blocpembayaran.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getDetailtransaction(context);
  }

  FutureBuilder<Response<dynamic>> _getDetailtransaction(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<NetworkApiService>(context).getDetailTransaction(
          'sembako168', widget.auth, widget.idTransaction),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(json.decode(snapshot.data.bodyString));
          model = ModelDetailTransaksi.fromJson(snapshot.data.body);
          paymentgateway = model.data.transaction.paymentGateway;
          transactioncode = model.data.transaction.transactionCode;
          grandtotalunique = model.data.transaction.grandTotalUnique;
          print('catatanadalah');
          print(model.data.transaction.note);
          return SingleChildScrollView(
            child: _layoutdetailtransaksi(context, model),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Column _layoutdetailtransaksi(
      BuildContext context, ModelDetailTransaksi models) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(100),
          decoration: BoxDecoration(color: kTextWhite),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize(models.data.transaction.status,
                        Colors.black87, getProportionateScreenWidth(15)),
                  ),
                  Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(top: getProportionateScreenWidth(5)),
                    height: getProportionateScreenWidth(1),
                    decoration: BoxDecoration(color: Colors.black12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              buildtextleftnormal(
                                'Nomor Invoice : ',
                                Colors.black87,
                              ),
                              buildtextleftnormal(
                                models.data.transaction.transactionCode,
                                Colors.black87,
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: buildtextleftnormal(
                                models.data.transaction.createdDate,
                                Colors.black87),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(100),
          decoration: BoxDecoration(color: kTextWhite),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Alamat pengiriman', Colors.black87,
                        getProportionateScreenWidth(15)),
                  ),
                  Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(top: getProportionateScreenWidth(5)),
                    height: getProportionateScreenWidth(1),
                    decoration: BoxDecoration(color: Colors.black12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildtextleftnormal(
                    models.data.transaction.address.address,
                    Colors.black87,
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Pesanan Anda', Colors.black87,
                        getProportionateScreenWidth(15)),
                  ),
                  Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(top: getProportionateScreenWidth(5)),
                    height: getProportionateScreenWidth(1),
                    decoration: BoxDecoration(color: Colors.black12),
                  ),
                  Detailchild(
                    models: models,
                  ),
                ],
              )),
        ),
        Card(
            child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: buildtextSize('Catatan Anda  ', Colors.black87,
                          getProportionateScreenWidth(15)),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(top: getProportionateScreenWidth(5)),
                      height: getProportionateScreenWidth(1),
                      decoration: BoxDecoration(color: Colors.black12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (models.data.transaction.note == '' ||
                        models.data.transaction.note == null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: buildtextleftnormal(
                          'Tidak ada catatn untuk pembelian ini',
                          Colors.black87,
                        ),
                      )
                    ] else ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: buildtextleftnormal(
                            models.data.transaction.note, Colors.black87),
                      )
                    ],
                  ],
                ))),
        SizedBox(
          height: 16,
        ),
        if (models.data.transaction.couponCode == '' ||
            models.data.transaction.couponCode == null)
          ...[]
        else ...[
          Container(
            width: double.infinity,
            height: getProportionateScreenHeight(50),
            margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    height: getProportionateScreenHeight(40),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(4))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(
                                left: getProportionateScreenWidth(10),
                                right: getProportionateScreenWidth(10)),
                            alignment: Alignment.centerLeft,
                            height: getProportionateScreenWidth(30),
                            width: getProportionateScreenWidth(30),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SvgPicture.asset("assets/icons/receipt.svg"),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: buildtextSizeleft(
                            models.data.transaction.couponCode,
                            kTextWhite,
                            getProportionateScreenWidth(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        Card(
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            child: Column(children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Total belanja', Colors.black87,
                        getProportionateScreenWidth(12)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: buildtextSize(
                        NumberFormat.currency(locale: 'id', name: 'Rp ').format(
                            int.parse(models.data.transaction.totalNominal)),
                        Colors.black87,
                        getProportionateScreenWidth(12)),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(2),
                decoration: BoxDecoration(color: Colors.black12),
                margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(1),
                    right: getProportionateScreenWidth(1),
                    top: getProportionateScreenWidth(8),
                    bottom: getProportionateScreenWidth(8)),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Biaya Tambahan', Colors.black87,
                        getProportionateScreenWidth(12)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: buildtextSize(
                        'Rp 0', redcolor, getProportionateScreenWidth(12)),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(2),
                decoration: BoxDecoration(color: Colors.black12),
                margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(1),
                    right: getProportionateScreenWidth(1),
                    top: getProportionateScreenWidth(8),
                    bottom: getProportionateScreenWidth(8)),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Jasa Antar', Colors.black87,
                        getProportionateScreenWidth(12)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: buildtextSize(
                          NumberFormat.currency(locale: 'id', name: 'Rp ')
                              .format(int.parse(
                                  models.data.transaction.deliveryPrice)),
                          Colors.black87,
                          getProportionateScreenWidth(12)),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(2),
                decoration: BoxDecoration(color: Colors.black12),
                margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(1),
                    right: getProportionateScreenWidth(1),
                    top: getProportionateScreenWidth(8),
                    bottom: getProportionateScreenWidth(8)),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildtextSize('Total Pembayaran', Colors.black87,
                        getProportionateScreenWidth(14)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: buildtextSize(
                          NumberFormat.currency(locale: 'id', name: 'Rp ')
                              .format(int.parse(
                                  models.data.transaction.grandTotal)),
                          Colors.black87,
                          getProportionateScreenWidth(12)),
                    ),
                  ),
                ],
              ),
              if (models.data.transaction.status == 'Pending') ...[
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(2),
                  decoration: BoxDecoration(color: Colors.black12),
                  margin: EdgeInsets.only(
                      left: getProportionateScreenWidth(1),
                      right: getProportionateScreenWidth(1),
                      top: getProportionateScreenWidth(8),
                      bottom: getProportionateScreenWidth(12)),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        buildtextSize('Ubah Metode pembayaran', Colors.black87,
                            getProportionateScreenWidth(16)),
                        buildtextSize(' : ', Colors.black87,
                            getProportionateScreenWidth(0)),
                        StreamBuilder(
                            stream: blocpembayaran.output,
                            initialData: paymentgateway,
                            builder: (context, snapshot) {
                              paymentgateway = snapshot.data;
                              return buildtextSize(snapshot.data, kPrimaryColor,
                                  getProportionateScreenHeight(0));
                            }),
                      ],
                    )),
                SizedBox(
                  height: 12,
                ),
                DetailPembayaran(
                  pembayaranmetode: paymentgateway,
                  pembayaran: pembayaran,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(50),
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                alertContext = context;
                                return Dialog(
                                    child: Container(
                                  width: double.infinity,
                                  height: getProportionateScreenHeight(40),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      new CircularProgressIndicator(),
                                      new Text("Loading"),
                                    ],
                                  ),
                                ));
                              },
                            );
                            registerAccount(paymentgateway);
                          },
                          child: Container(
                            height: getProportionateScreenHeight(50),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                border: Border.all(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(4))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildtextSizeleft('Bayar', kTextWhite,
                                    getProportionateScreenWidth(12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(50),
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                alertContext = context;
                                return Dialog(
                                    child: Container(
                                  width: double.infinity,
                                  height: getProportionateScreenHeight(40),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      new CircularProgressIndicator(),
                                      new Text("Loading"),
                                    ],
                                  ),
                                ));
                              },
                            );
                            postcancel();
                          },
                          child: Container(
                            height: getProportionateScreenHeight(50),
                            decoration: BoxDecoration(
                                color: redcolor,
                                border: Border.all(color: redcolor),
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(4))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildtextSizeleft(
                                    'Batalkan pesanan',
                                    kTextWhite,
                                    getProportionateScreenWidth(12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ]),
          ),
        ),
      ],
    );
  }

  void pembayaran(String token) {
    blocpembayaran.sinkin.add(token);
  }

  void registerAccount(String ubahnya) async {
    // setState(() {
    //   isloading = true;
    // });
    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .changePembayaran(
                'sembako168', widget.idMember, transactioncode, ubahnya);

    print(response.body);

    if (response.body['status'] == true) {
      Navigator.pop(alertContext);

      if (paymentgateway == 'COD') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            dialogContext = context;
            return Dialog(
                child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              width: double.infinity,
              height: getProportionateScreenHeight(230),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildtextSize('Info Pesanan Dirubah', Colors.black87,
                      getProportionateScreenWidth(15)),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: buildtextSizecentersoft(
                          'Pesanan Anda  dirubah kemetode pesanan COD kami akan segera memproses pesanan anda pastikan Alamat pengiriman Anda sesuai\n Trimakasih',
                          Colors.black87,
                          getProportionateScreenWidth(15))),
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeName,
                          (route) => false,
                          arguments: {
                            'pesan':
                                'Pesanan Anda sudah kami terima\nKami akan segera memproses pesanan anda \nditunggu ya\n\nuntuk melihat pesanan anda buka menu notifikasi atau di bilah menu -> transaksi'
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(40),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(4)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildtextSize('Baiklah', kTextWhite,
                              getProportionateScreenWidth(11)),
                        ),
                      ))
                ],
              ),
            ));
          },
        );
      } else if (paymentgateway == 'Midtrans') {
        String invoice;
        invoice = transactioncode;

        Navigator.pushNamed(
          context,
          WebviewScreen.routeName,
          arguments: {
            'url': 'https://bulanan.app/payments/checkout/process/$invoice'
          },
        ).then((value) {
          print('were back');
        });
      } else if (paymentgateway == 'Cekmutasi') {
        String invoice;
        invoice = transactioncode;
        String amount;
        amount = grandtotalunique;

        Navigator.pushNamed(
          context,
          Cekmutasi.routeName,
          arguments: {
            'invoice': invoice.toString(),
            'totaltransaksi': amount.toString()
          },
        ).then((value) {
          print('were back');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body['message']),
        ));
      }
    }
  }

  void postcancel() async {
    // setState(() {
    //   isloading = true;
    // });
    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .postcanceltransaksi(
                'sembako168', widget.auth, transactioncode, widget.idMember);

    print(response.body);

    if (response.body['status'] == true) {
      Navigator.pop(alertContext);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
        arguments: {
          'pesan':
              'Pesanan Anda dibatalkan\n\n\nuntuk melihat pesanan anda buka menu notifikasi atau di bilah menu -> transaksi'
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body['message']),
      ));
    }
  }
}
