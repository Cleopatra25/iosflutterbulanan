import 'package:flutter/material.dart';
import 'package:bulanan/size_config.dart';

const kPrimaryColor = Color(0xFFFF7046);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kbackground = Color(0xFFFFFDFD);
const kTextColor = Color(0xFF757575);
const kTextWhite = Color(0xFFFFFFFF);
const yellowcolor = Color(0xFFD4C647);

const accentColor = Color(0xFF3ED80F);
const accentColortransparent = Color(0x0AFF7146);

const redcolor = Color(0xFFD8370F);
const kAnimationDuration = Duration(milliseconds: 200);

const MaterialColor kPrimaryColors = const MaterialColor(
  0xFFFF7046,
  const <int, Color>{
    50: const Color(0xFFFF7046),
    100: const Color(0xFFFF7046),
    200: const Color(0xFFFF7046),
    300: const Color(0xFFFF7046),
    400: const Color(0xFFFF7046),
    500: const Color(0xFFFF7046),
    600: const Color(0xFFFF7046),
    700: const Color(0xFFFF7046),
    800: const Color(0xFFFF7046),
    900: const Color(0xFFFF7046),
  },
);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

Text buildtextnormal(String text, Color colorss, bool coret) {
  if (coret) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: colorss,
            fontSize: getProportionateScreenHeight(10),
            decoration: TextDecoration.lineThrough,
            decorationColor: redcolor));
  } else {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: colorss,
          fontSize: getProportionateScreenHeight(10),
        ));
  }
}

Text buildtextleft(String text, Color colorss) {
  return Text(text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: colorss,
          fontSize: getProportionateScreenHeight(10),
          decoration: TextDecoration.lineThrough,
          decorationColor: redcolor));
}

Text buildtextleftnormal(String text, Color colorss) {
  return Text(text,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: colorss,
        fontSize: getProportionateScreenHeight(12),
      ));
}

Text buildtextbold(String text, Color colorss) {
  return Text(text,
      style: TextStyle(
          color: colorss,
          fontSize: getProportionateScreenHeight(12),
          fontWeight: FontWeight.bold));
}

Text buildtextSize(String text, Color colorss, double size) {
  return Text(text,
      style: TextStyle(
          color: colorss, fontSize: size, fontWeight: FontWeight.bold));
}

Text buildtextSizeelipsize(String text, Color colorss, double size) {
  return Text(text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: colorss, fontSize: size, fontWeight: FontWeight.bold));
}

Text buildtextSizeleft(String text, Color colorss, double size) {
  return Text(text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: colorss, fontSize: size, fontWeight: FontWeight.bold));
}

Text buildtextSizecenter(String text, Color colorss, double size) {
  return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: colorss, fontSize: size, fontWeight: FontWeight.bold));
}

Text buildtextSizecentersoft(String text, Color colorss, double size) {
  return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: colorss, fontSize: size, fontWeight: FontWeight.normal));
}

Text buildtextSizeleftsoft(String text, Color colorss, double size) {
  return Text(text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: colorss, fontSize: size, fontWeight: FontWeight.bold));
}

Text buildtextSizecentersoftlines(String text, Color colorss, double size) {
  return Text(text,
      textAlign: TextAlign.center,
      maxLines: 2,
      style: TextStyle(
          color: colorss, fontSize: size, fontWeight: FontWeight.normal));
}

Image buildimages(String urls) {
  return Image.asset(
    urls,
    width: getProportionateScreenWidth(20),
    height: getProportionateScreenHeight(20),
  );
}

Image buildimagescustom(String urls, double height, double width) {
  return Image.asset(
    urls,
    width: height,
    height: width,
  );
}

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
