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
import 'package:bulanan/screens/cart/components/cartcontent.dart';
import 'package:bulanan/screens/cekmutasi/cekmutasi_screen.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/checkout/components/checkoutpembayaran.dart';
import 'package:bulanan/screens/checkout/components/summarybody.dart';
import 'package:bulanan/screens/coupon/coupon_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/screens/webview/webview_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Checkoutsumarry extends StatefulWidget {
  final String idaddress;
  final String jadwal;
  Checkoutsumarry({
    Key key,
    this.idaddress,
    this.jadwal,
  }) : super(key: key);
  @override
  _CheckoutsumarryState createState() => _CheckoutsumarryState();
}

class _CheckoutsumarryState extends State<Checkoutsumarry> {
  ModelCart model;
  String rupiah = 'Rp 0';
  String discount = 'Rp 0';
  String jasaantar = 'Rp 0';

  int totalharga = 0;
  int grandtotal = 0;
  int biayakirim = 0;
  int counts = 0;
  UpdateCart bloccart = UpdateCart();
  Blocgrandtotal blocgrandtotal = Blocgrandtotal();
  UpdateHarga blocharga = UpdateHarga();
  UpdateCartDiscont blocdiscount = UpdateCartDiscont();
  UpdateCartAntar blocantar = UpdateCartAntar();
  BlocCoupon bloccoupon = BlocCoupon();
  BlocPembayaran blocpembayaran = BlocPembayaran();
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';
  String idMember = '';
  TextEditingController notes = new TextEditingController();
  String coupon = 'Pilih Coupon';
  String paymentgateway = '';
  BuildContext dialogContext;

  @override
  void initState() {
    getPreference();
    super.initState();
  }

  @override
  void dispose() {
    bloccart.dispose();
    blocharga.dispose();
    blocdiscount.dispose();
    blocantar.dispose();
    blocgrandtotal.dispose();
    bloccoupon.dispose();
    blocpembayaran.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildtextSize(
            'Pesanan Anda', Colors.black87, getProportionateScreenHeight(12)),
        FutureBuilder(
          future: getPreference(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              addCart('nool', 'nool', 'Pilih Coupon');

              return Sumarrybody(
                idCity: idCity,
                idDevice: idDevice,
                idMember: idMember,
                authHeader: authHeader,
                updatecarts: addCart,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: notes,
          autofocus: false,
          maxLines: 2,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(8),
            hintText: 'Catatan',
            hintStyle: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: Colors.black26),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(getProportionateScreenWidth(3))),
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(getProportionateScreenWidth(3))),
                borderSide: BorderSide(color: Colors.blue)),
            border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius: BorderRadius.all(Radius.circular(1.0)),
                borderSide: BorderSide(color: Colors.white24)
                //borderSide: const BorderSide(),
                ),
          ),
        ),
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(50),
          margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CouponScreen.routeName,
                      arguments: {
                        'totalharga': totalharga,
                        'biayakirim': biayakirim
                      },
                    ).then((value) {
                      Map<String, String> mydata = value;

                      addCart(mydata['type'], mydata['value'], mydata['code']);
                      print(mydata['type']);
                      print(mydata['type']);
                    });
                  },
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
                          child: StreamBuilder(
                              stream: bloccoupon.output,
                              initialData: 'Pilih Coupon',
                              builder: (context, snapshot) {
                                coupon = snapshot.data;
                                return buildtextSizeleft(
                                    snapshot.data,
                                    kTextWhite,
                                    getProportionateScreenWidth(12));
                              }),
                        ),
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
              child: buildtextSize(
                  'Discount', Colors.black87, getProportionateScreenWidth(12)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder(
                  stream: blocdiscount.output,
                  initialData: '0',
                  builder: (context, snapshot) {
                    return buildtextSize(snapshot.data.toString(), accentColor,
                        getProportionateScreenWidth(12));
                  }),
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
              child: buildtextSize('Total belanja', Colors.black87,
                  getProportionateScreenWidth(12)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder(
                  stream: blocharga.output,
                  initialData: '0',
                  builder: (context, snapshot) {
                    return buildtextSize(snapshot.data, Colors.black87,
                        getProportionateScreenWidth(12));
                  }),
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
              child: StreamBuilder(
                  stream: blocantar.output,
                  initialData: '0',
                  builder: (context, snapshot) {
                    return buildtextSize(snapshot.data, redcolor,
                        getProportionateScreenWidth(12));
                  }),
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
              child: StreamBuilder(
                  stream: blocgrandtotal.output,
                  initialData: '0',
                  builder: (context, snapshot) {
                    return buildtextSize(snapshot.data, Colors.black87,
                        getProportionateScreenWidth(14));
                  }),
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
              bottom: getProportionateScreenWidth(12)),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                buildtextSize('Pilih Metode pembayaran', Colors.black87,
                    getProportionateScreenWidth(16)),
                buildtextSize(
                    ' : ', Colors.black87, getProportionateScreenWidth(0)),
                StreamBuilder(
                    stream: blocpembayaran.output,
                    initialData: '',
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
        CheckoutPembayaran(
          paymentgateway: paymentgateway,
          pembayaran: pembayaran,
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: double.infinity,
          height: getProportionateScreenHeight(50),
          margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    height: getProportionateScreenHeight(50),
                    margin:
                        EdgeInsets.only(right: getProportionateScreenHeight(5)),
                    decoration: BoxDecoration(
                        color: kTextWhite,
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(4))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildimagescustom(
                            'assets/images/chev_left_orange.png',
                            getProportionateScreenWidth(20),
                            getProportionateScreenWidth(20)),
                        buildtextSizeleft('Pengiriman', kPrimaryColor,
                            getProportionateScreenWidth(12)),
                      ],
                    ),
                  )),
              Expanded(
                flex: 6,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        dialogContext = context;
                        return Dialog(
                            child: Container(
                          width: double.infinity,
                          height: getProportionateScreenHeight(40),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new CircularProgressIndicator(),
                              new Text("Loading"),
                            ],
                          ),
                        ));
                      },
                    );
                    buttonregister();
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
                        buildimagescustom(
                            'assets/images/chev_right_white.png',
                            getProportionateScreenWidth(20),
                            getProportionateScreenWidth(20)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addCart(String type, String value, String coupons) async {
    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .getCart('sembako168', authHeader, idDevice);

    print(response.body);

    if (response.isSuccessful) {
      bloccoupon.sinkin.add(coupons);

      model = ModelCart.fromJson(response.body);
      totalharga = model.data.totalPrice;
      biayakirim = model.data.deliveryPrice;
      if (type == 'nool') {
        rupiah = NumberFormat.currency(locale: 'id', name: 'Rp ')
            .format(model.data.totalPrice);
        counts = model.data.totalProduct;
        discount = NumberFormat.currency(locale: 'id', name: 'Rp ')
            .format(model.data.totalDiscount);
        jasaantar = NumberFormat.currency(locale: 'id', name: 'Rp ')
            .format(model.data.deliveryPrice);
        counts = model.data.totalProduct;
        print(counts);
        print(rupiah);
        grandtotal = totalharga + biayakirim;
        bloccart.sinkin.add(counts);
        blocharga.sinkin.add(rupiah);
        blocdiscount.sinkin.add(discount);
        blocantar.sinkin.add(jasaantar);
        blocgrandtotal.sinkin.add(
            NumberFormat.currency(locale: 'id', name: 'Rp ')
                .format(int.parse(grandtotal.toString())));
      } else {
        if (type == 'ongkir') {
          biayakirim = int.parse(value);
          rupiah = NumberFormat.currency(locale: 'id', name: 'Rp ')
              .format(model.data.totalPrice);
          counts = model.data.totalProduct;
          discount = NumberFormat.currency(locale: 'id', name: 'Rp ')
              .format(model.data.totalDiscount);
          jasaantar = NumberFormat.currency(locale: 'id', name: 'Rp ')
              .format(int.parse(value));
          counts = model.data.totalProduct;
          print(counts);
          print(rupiah);
          bloccart.sinkin.add(counts);
          blocharga.sinkin.add(rupiah);
          blocdiscount.sinkin.add(discount);
          blocantar.sinkin.add(jasaantar);
          grandtotal = totalharga + int.parse(value);
          blocgrandtotal.sinkin.add(
              NumberFormat.currency(locale: 'id', name: 'Rp ')
                  .format(int.parse(grandtotal.toString())));
        } else if (type == 'harga') {
          rupiah = NumberFormat.currency(locale: 'id', name: 'Rp ')
              .format(int.parse(value));
          counts = model.data.totalProduct;
          discount = NumberFormat.currency(locale: 'id', name: 'Rp ')
              .format(model.data.totalDiscount);
          jasaantar = NumberFormat.currency(locale: 'id', name: 'Rp ')
              .format(model.data.deliveryPrice);
          counts = model.data.totalProduct;
          print(counts);
          print(rupiah);
          bloccart.sinkin.add(counts);
          blocharga.sinkin.add(rupiah);
          blocdiscount.sinkin.add(discount);
          blocantar.sinkin.add(jasaantar);
          grandtotal = biayakirim + int.parse(value);
          blocgrandtotal.sinkin.add(
              NumberFormat.currency(locale: 'id', name: 'Rp ')
                  .format(int.parse(grandtotal.toString())));
        }
      }
    }
  }

  void pembayaran(String token) {
    blocpembayaran.sinkin.add(token);
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

  void buttonregister() {
    if (paymentgateway == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pilih Metode pembayran terlebih dahulu'),
      ));
    } else {
      registerAccount();
    }
  }

  void registerAccount() async {
    String couponss;
    if (coupon == 'Pilih Coupon') {
      couponss = '';
    } else {
      couponss = coupon;
    }
    // setState(() {
    //   isloading = true;
    // });
    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .postCheckout(
                'sembako168',
                authHeader,
                idMember,
                widget.idaddress,
                'Delivery',
                paymentgateway,
                'false',
                couponss,
                notes.text.toString(),
                biayakirim.toString(),
                grandtotal.toString(),
                idCity,
                widget.jadwal);

    print(response.body);

    if (response.body['status'] == true) {
      Navigator.pop(dialogContext);

      if (paymentgateway == 'COD') {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
          arguments: {
            'pesan':
                'Pesanan Anda sudah kami terima\nKami akan segera memproses pesanan anda\nDitunggu ya \n\nuntuk melihat pesanan anda buka menu notifikasi atau di bilah menu -> transaksi'
          },
        );
      } else if (paymentgateway == 'Midtrans') {
        String invoice;
        invoice = response.body['invoice'].toString();

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
        invoice = response.body['invoice'].toString();
        String amount;
        amount = response.body['amount'].toString();

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
      }
      // setState(() {
      //   isloading = false;
      // });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body['message']),
      ));
    }
  }
}
