import 'package:flutter/material.dart';
import 'package:bulanan/constants.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/size_config.dart';
// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  SharedPreferences share;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "We help people conect with store \naround United State of America",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  void initState() {
    getPreference();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPreference();
    setState(() {});
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        savePreferens();
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  void savePreferens() async {
    SharedPreferences myshare = await SharedPreferences.getInstance();
    await myshare.setString("loged", "true");
  }

  void getPreference() async {
    String isi;
    String idDevice;
    String idMember;
    SharedPreferences myshare = await SharedPreferences.getInstance();
    isi = myshare.getString('loged');
    idDevice = myshare.getString('id_device');

    if (isi.toString() == "true") {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }
}
