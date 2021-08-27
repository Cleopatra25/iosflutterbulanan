import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulanan/Network/network_api_service.dart';
import 'package:bulanan/components/custom_surfix_icon.dart';
import 'package:bulanan/components/form_error.dart';
import 'package:bulanan/helper/keyboard.dart';
import 'package:bulanan/screens/forgot_password/forgot_password_screen.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/screens/login_success/login_success_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  TextEditingController usernamev = new TextEditingController();
  TextEditingController passwordv = new TextEditingController();
  String idDevice = '';
  String idCity = '';
  String nameCity = '';
  String authHeader = '';

  String idMember = '';

  BuildContext alertcontext;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPreference(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Row(
                  children: [
                    Visibility(
                      visible: false,
                      child: Checkbox(
                        value: remember,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {
                          setState(() {
                            remember = value;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: Text("Remember me"),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                    text: "Continue",
                    press: () {
                      if (usernamev.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('email anda belum diisi'),
                        ));
                      } else if (passwordv.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('password anda belum diisi'),
                        ));
                      } else {
                        // if all are valid then go to success screen
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
                    }),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordv,
      obscureText: true,
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: usernamev,
      decoration: InputDecoration(
        labelText: "Email / Nomor handphone",
        hintText: "Email/ Handphone",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void registerAccount() async {
    // setState(() {
    //   isloading = true;
    // });

    final response =
        await Provider.of<NetworkApiService>(context, listen: false).postlogin(
            'sembako168',
            '',
            idDevice,
            usernamev.text,
            passwordv.text,
            passwordv.text);

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
