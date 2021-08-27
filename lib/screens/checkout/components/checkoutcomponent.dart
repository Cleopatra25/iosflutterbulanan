import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/models/ModelPostRegister.dart';
import 'package:bulanan/screens/alamat/alamatscreen.dart';
import 'package:bulanan/screens/checkout/components/checkoutsummary.dart';
import 'package:bulanan/screens/jadwal/jadwal_screen.dart';
import 'package:bulanan/size_config.dart';

class Chekcoutcomponents extends StatefulWidget {
  final String idMember;
  final String idDevice;
  final String authheader;
  final String idCity;

  Chekcoutcomponents({
    Key key,
    this.idMember,
    this.idDevice,
    this.authheader,
    this.idCity,
  }) : super(key: key);

  @override
  _ChekcoutcomponentsState createState() => _ChekcoutcomponentsState();
}

class _ChekcoutcomponentsState extends State<Chekcoutcomponents> {
  String adress = 'Pilih Alamat Pengiriman';
  String idadress = '';
  String jadwal = 'Pilih Jadwal Pengiriman';

  int _currentStep = 0;
  int _countstep = 2;
  StepperType stepperType = StepperType.vertical;
  bool _obscureText = true;
  ModelPostRegister modelpost;

  String urlbuatakun = 'assets/images/circle_active.png';
  String urlpengiriman = 'assets/images/circle_inactives_black.png';
  String urlpembayaran = 'assets/images/circle_inactives_black.png';
  String positions = 'akun';

  bool isloading = false;
  bool validatename = false;
  bool validateemail = false;
  bool validatephone = false;
  bool validatepassword = false;
  TextEditingController nama = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  void initState() {
    if (widget.idMember == '') {
      setState(() {
        changePosition('akun');
      });
    } else {
      setState(() {
        changePosition('pengiriman');
      });
    }

    super.initState();
  }

  void changePosition(String position) {
    setState(() {
      if (position == 'akun') {
        urlbuatakun = 'assets/images/circle_active.png';
        urlpembayaran = 'assets/images/circle_inactives_black.png';
        urlpengiriman = 'assets/images/circle_inactives_black.png';
        positions = position;
      } else if (position == 'pengiriman') {
        urlbuatakun = 'assets/images/circle_active.png';
        urlpengiriman = 'assets/images/circle_active.png';
        urlpembayaran = 'assets/images/circle_inactives_black.png';
        positions = position;
      } else {
        urlbuatakun = 'assets/images/circle_active.png';
        urlpembayaran = 'assets/images/circle_active.png';
        urlpengiriman = 'assets/images/circle_active.png';
        positions = position;
      }
    });
  }

  void buttonregister() {
    if (nama.text.isEmpty) {
      setState(() {
        validatename = true;
      });
    } else {
      setState(() {
        validatename = false;
      });
    }

    if (email.text.isEmpty) {
      setState(() {
        validateemail = true;
      });
    } else {
      setState(() {
        validateemail = false;
      });
    }

    if (phone.text.isEmpty) {
      setState(() {
        validatephone = true;
      });
    } else {
      setState(() {
        validatephone = false;
      });
    }

    if (password.text.isEmpty) {
      setState(() {
        validatepassword = true;
      });
    } else {
      setState(() {
        validatepassword = false;
      });
    }

    if (!validatename &&
        !validateemail &&
        !validatepassword &&
        !validatephone) {
      registerAccount();
    } else {}
  }

  void registerAccount() async {
    setState(() {
      isloading = true;
    });
    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .PostRegisterChekout(
                'sembako168',
                '',
                email.text.toString(),
                password.text.toString(),
                password.text.toString(),
                nama.text.toString(),
                phone.text.toString(),
                widget.idDevice,
                '');

    print(response.body);

    if (response.body['status'] == true) {
      setState(() {
        isloading = false;
      });
      modelpost = ModelPostRegister.fromJson(response.body);
      SharedPreferences myshare = await SharedPreferences.getInstance();
      await myshare.setString("id_member", modelpost.data.idMember.toString());
      await myshare.setString("auth", modelpost.data.token);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body['message']),
      ));
      changePosition('pengiriman');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body['message']),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(2),
                    margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(23),
                        top: getProportionateScreenHeight(8),
                        right: getProportionateScreenHeight(23)),
                    decoration: BoxDecoration(color: Colors.black87),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                if (widget.idMember == '') {
                                  changePosition('akun');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Akun Anda Sudah terbuat'),
                                  ));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: getProportionateScreenWidth(20)),
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: buildimagescustom(
                                          urlbuatakun,
                                          getProportionateScreenWidth(20),
                                          getProportionateScreenWidth(20)),
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: buildtextSizecenter(
                                            'Akun',
                                            Colors.black87,
                                            getProportionateScreenHeight(11))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: GestureDetector(
                                  onTap: () {
                                    changePosition('pengiriman');
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        buildimagescustom(
                                            urlpengiriman,
                                            getProportionateScreenWidth(20),
                                            getProportionateScreenWidth(20)),
                                        buildtextSizecenter(
                                            'Alamat & Pengiriman',
                                            Colors.black87,
                                            getProportionateScreenHeight(11))
                                      ],
                                    ),
                                  ))),
                          Expanded(
                              flex: 3,
                              child: GestureDetector(
                                  onTap: () {
                                    changePosition('pembayaran');
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    margin: EdgeInsets.only(
                                        right: getProportionateScreenWidth(20)),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: buildimagescustom(
                                              urlpembayaran,
                                              getProportionateScreenWidth(20),
                                              getProportionateScreenWidth(20)),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: buildtextSizecenter(
                                                'Pembayaran',
                                                Colors.black87,
                                                getProportionateScreenHeight(
                                                    11)))
                                      ],
                                    ),
                                  ))),
                        ],
                      )),
                ],
              ),
            ),
            if (positions == 'akun') ...[
              Container(
                margin: EdgeInsets.all(getProportionateScreenHeight(12)),
                child: akunlayout(),
              )
            ] else if (positions == 'pengiriman') ...[
              Container(
                  margin: EdgeInsets.all(getProportionateScreenHeight(12)),
                  child: pengirimanlayout())
            ] else ...[
              Card(
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Checkoutsumarry(
                    idaddress: idadress,
                    jadwal: jadwal,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Card pengirimanlayout() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: Column(
          children: <Widget>[
            buildtextSize('Alamat & Jadwal Pengiriman', Colors.black87,
                getProportionateScreenHeight(12)),
            SizedBox(
              height: getProportionateScreenHeight(13),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AlamatScreen.routeName,
                ).then((value) {
                  Map<String, String> mydata = value;
                  setState(() {
                    idadress = mydata['id_address'];
                    adress = mydata['address'];
                  });
                });
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(3)),
                width: double.infinity,
                height: getProportionateScreenWidth(60),
                decoration: BoxDecoration(
                  color: kTextWhite,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: kPrimaryColor, width: 1),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: buildtextSizecentersoftlines(
                      adress, kPrimaryColor, getProportionateScreenWidth(12)),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(13),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: buildtextSizeleft('Pesanan Anda ingin dikirimkan pada :',
                    Colors.black45, getProportionateScreenHeight(11))),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  JadwalScreen.routeName,
                ).then((value) {
                  setState(() {
                    jadwal = value;
                  });
                });
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(3)),
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: getProportionateScreenWidth(8),
                    bottom: getProportionateScreenWidth(8)),
                height: getProportionateScreenWidth(60),
                decoration: BoxDecoration(
                  color: kTextWhite,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: kPrimaryColor, width: 1),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: buildtextSizecentersoftlines(
                      jadwal, kPrimaryColor, getProportionateScreenWidth(12)),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
              child: Row(
                children: [
                  // Expanded(
                  //     flex: 5,
                  //     child: Container(
                  //       height: getProportionateScreenHeight(50),
                  //       margin:
                  //           EdgeInsets.only(right: getProportionateScreenHeight(5)),
                  //       decoration: BoxDecoration(
                  //           color: kTextWhite,
                  //           border: Border.all(color: kPrimaryColor),
                  //           borderRadius: BorderRadius.circular(
                  //               getProportionateScreenWidth(4))),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           buildimagescustom(
                  //               'assets/images/chev_left_orange.png',
                  //               getProportionateScreenWidth(20),
                  //               getProportionateScreenWidth(20)),
                  //           buildtextSizeleft('Pengiriman', kPrimaryColor,
                  //               getProportionateScreenWidth(12)),
                  //         ],
                  //       ),
                  //     )),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (idadress == '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Pilih Alamat Anda terlebih dahulu sebelum melanjutkan ke pembayaran'),
                          ));
                        } else {
                          changePosition('pembayaran');
                        }
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
                            buildtextSizeleft('Pembayaran', kTextWhite,
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
            )
          ],
        ),
      ),
    );
  }

  Column pembayaranlayout() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AlamatScreen.routeName,
            ).then((value) {
              Map<String, String> mydata = value;
              setState(() {
                idadress = mydata['id_address'];
                adress = mydata['address'];
              });
            });
          },
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(3)),
            width: double.infinity,
            height: getProportionateScreenWidth(60),
            decoration: BoxDecoration(
              color: kTextWhite,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: kPrimaryColor, width: 1),
            ),
            child: Align(
              alignment: Alignment.center,
              child: buildtextSizecentersoftlines(
                  adress, kPrimaryColor, getProportionateScreenWidth(12)),
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(13),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: buildtextSizeleft('Pesanan Anda ingin dikirimkan pada :',
                Colors.black45, getProportionateScreenHeight(11))),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              JadwalScreen.routeName,
            ).then((value) {
              setState(() {
                jadwal = value;
              });
            });
          },
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(3)),
            width: double.infinity,
            margin: EdgeInsets.only(
                top: getProportionateScreenWidth(8),
                bottom: getProportionateScreenWidth(8)),
            height: getProportionateScreenWidth(60),
            decoration: BoxDecoration(
              color: kTextWhite,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: kPrimaryColor, width: 1),
            ),
            child: Align(
              alignment: Alignment.center,
              child: buildtextSizecentersoftlines(
                  jadwal, kPrimaryColor, getProportionateScreenWidth(12)),
            ),
          ),
        ),
      ],
    );
  }

  Card akunlayout() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: Column(
          children: <Widget>[
            buildtextSize(
                'Buat Akun', Colors.black87, getProportionateScreenHeight(12)),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: nama,
              autofocus: false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(8),
                errorText: validatename ? 'Nama tidak boleh kosong' : null,
                hintText: 'Nama Lengkap',
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
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(8),
                errorText: validateemail ? 'Email tidak boleh kosong' : null,
                hintText: 'Email Address',
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
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              autofocus: false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(8),
                errorText: validatephone ? 'Nomor Hp tidak boleh kosong' : null,
                hintText: 'Nomor Handphone',
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
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: password,
              keyboardType: TextInputType.text,
              obscureText: !_obscureText, //This will obscure text dynamically
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(8),
                errorText:
                    validatepassword ? 'Password tidak boleh kosong' : null,

                hintText: 'Enter your password',
                hintStyle: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: Colors.black26),
                // Here is key idea
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            if (!isloading) ...[
              GestureDetector(
                onTap: () {
                  buttonregister();
                },
                child: Container(
                  width: double.infinity,
                  height: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(4))),
                  child: Align(
                    alignment: Alignment.center,
                    child: buildtextSizecentersoft('Buat Akun', kTextWhite,
                        getProportionateScreenWidth(10)),
                  ),
                ),
              ),
            ] else ...[
              Center(
                child: CircularProgressIndicator(),
              ),
            ]
          ],
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    print(_countstep);
    if (_countstep == 3) {
      if (_currentStep == 0) {
        buttonregister();
      }
    } else {
      if (idadress == '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pilih alamat pengiriman terlebih dahulu'),
        ));
      } else {
        _currentStep < _countstep ? setState(() => _currentStep += 1) : null;
      }
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
