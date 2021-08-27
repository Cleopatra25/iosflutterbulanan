import 'package:flutter/widgets.dart';
import 'package:bulanan/screens/CategoryMain/categorymain.dart';
import 'package:bulanan/screens/addalamat/addalamatscreen.dart';
import 'package:bulanan/screens/alamat/alamatscreen.dart';
import 'package:bulanan/screens/cart/cart_screen.dart';
import 'package:bulanan/screens/cekmutasi/cekmutasi_screen.dart';
import 'package:bulanan/screens/checkout/checkout_screen.dart';
import 'package:bulanan/screens/complete_profile/complete_profile_screen.dart';
import 'package:bulanan/screens/coupon/coupon_screen.dart';
import 'package:bulanan/screens/detailhistory/detailhostory_sceen.dart';
import 'package:bulanan/screens/details/details_screen.dart';
import 'package:bulanan/screens/forgot_password/forgot_password_screen.dart';
import 'package:bulanan/screens/historytransaksi/history_sreen.dart';
import 'package:bulanan/screens/home/home_screen.dart';
import 'package:bulanan/screens/jadwal/jadwal_screen.dart';
import 'package:bulanan/screens/login_success/login_success_screen.dart';
import 'package:bulanan/screens/notification/notification.dart';
import 'package:bulanan/screens/otp/otp_screen.dart';
import 'package:bulanan/screens/profile/profile_screen.dart';
import 'package:bulanan/screens/search/searchscreen.dart';
import 'package:bulanan/screens/searchresult/searchresult_screen.dart';
import 'package:bulanan/screens/sign_in/sign_in_screen.dart';
import 'package:bulanan/screens/splash/splash_screen.dart';
import 'package:bulanan/screens/webscreennormal/webscreennormal.dart';
import 'package:bulanan/screens/webview/webview_screen.dart';
import 'package:bulanan/screens/welcome/welcome.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Welcome.routeName: (context) => Welcome(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CategorymainScreen.routeName: (context) => CategorymainScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  AlamatScreen.routeName: (context) => AlamatScreen(),
  AddAlamatScreen.routeName: (context) => AddAlamatScreen(),
  JadwalScreen.routeName: (context) => JadwalScreen(),
  CouponScreen.routeName: (context) => CouponScreen(),
  WebviewScreen.routeName: (context) => WebviewScreen(),
  Cekmutasi.routeName: (context) => Cekmutasi(),
  HistoryTransaksi.routeName: (context) => HistoryTransaksi(),
  Notifikasi.routeName: (context) => Notifikasi(),
  DetailHistoryScreen.routeName: (context) => DetailHistoryScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  SearchResultScreen.routeName: (context) => SearchResultScreen(),
  WebScreen.routeName: (context) => WebScreen(),
};
