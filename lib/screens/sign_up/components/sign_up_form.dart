import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/custom_surfix_icon.dart';
import 'package:bulanan/components/default_button.dart';
import 'package:bulanan/components/form_error.dart';
import 'package:bulanan/helper/keyboard.dart';
import 'package:bulanan/screens/complete_profile/complete_profile_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool remember = false;

  TextEditingController usernamev = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController refferal = new TextEditingController();
  TextEditingController password = new TextEditingController();
  BuildContext alertcontext;
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';

  String idMember = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPreference(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                buildnama(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildphone(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildidreferral(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  children: [
                    Checkbox(
                      value: remember,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          remember = value;
                        });
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          'Dengan mendaftar anda telah menyetujui',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Row(
                          children: [
                            buildtextSize('Privacy policy', kPrimaryColor,
                                getProportionateScreenWidth(13)),
                            buildtextSize('&', kTextColor,
                                getProportionateScreenWidth(13)),
                            buildtextSize('Term condition', kPrimaryColor,
                                getProportionateScreenWidth(13)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                DefaultButton(
                  text: "Continue",
                  press: () {
                    if (remember) {
                    } else {
                      if (usernamev.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Nama anda belum diisi'),
                        ));
                      } else if (password.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('password anda belum diisi'),
                        ));
                      } else if (email.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Email anda belum diisi'),
                        ));
                      } else if (phone.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('nomor telepon anda belum diisi'),
                        ));
                      } else {
                        KeyboardUtil.hideKeyboard(context);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            alertcontext = context;
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
                        registerAccount();
                      }
                    }
                  },
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  void registerAccount() async {
    // setState(() {
    //   isloading = true;
    // });

    final response =
        await Provider.of<NetworkApiService>(context, listen: false)
            .postRegister(
                'sembako168',
                '',
                idDevice,
                email.text,
                password.text,
                password.text,
                usernamev.text,
                phone.text,
                'Male',
                refferal.text,
                '1991-08-10');

    print(response.body);

    if (response.body['status'] == true) {
      Navigator.pop(alertcontext);

      SharedPreferences myshare = await SharedPreferences.getInstance();
      await myshare.setString("id_member", response.body['data']['id_member']);
      await myshare.setString("auth", response.body['data']['token']);

      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    } else {
      Navigator.pop(alertcontext);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.body['message']),
      ));
    }
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: password,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildnama() {
    return TextFormField(
      controller: usernamev,
      decoration: InputDecoration(
        labelText: "Nama Lengkap",
        hintText: "Nama Lengkap Anda",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildphone() {
    return TextFormField(
      controller: phone,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Nomor Handphone",
        hintText: "Nomor Handphone Anda",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildidreferral() {
    return TextFormField(
      controller: refferal,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Id referal",
        hintText: "Lewati jika anda tidak ada ",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
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
