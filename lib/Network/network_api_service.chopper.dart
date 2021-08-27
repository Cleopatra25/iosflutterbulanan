// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NetworkApiService extends NetworkApiService {
  _$NetworkApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NetworkApiService;

  @override
  Future<Response<dynamic>> getBanner(String headervalue) {
    final $url = '/api/banner';
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCityHome(String headervalue) {
    final $url = '/api/address/location_city_by_province';
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getpromo(
      String headervalue, String idMember, String idDevice, String idCity) {
    final $url = '/api/product/promo_product?id_member=$idMember';
    final $params = <String, dynamic>{'id_device': idDevice, 'id_city': idCity};
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getrecomended(
      String headervalue, String idMember, String idDevice, String idCity) {
    final $url = '/api/product/recomend_product?id_member=$idMember';
    final $params = <String, dynamic>{'id_device': idDevice, 'id_city': idCity};
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getHighlight(
      String headervalue, String idMember, String idDevice, String idCity) {
    final $url = '/api/product/highlight?id_member=$idMember';
    final $params = <String, dynamic>{'id_device': idDevice, 'id_city': idCity};
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMaincategory(
      String headervalue,
      String idMember,
      String idDevice,
      String idCity,
      String idCategoryParent,
      String offset,
      String limit) {
    final $url = '/api/product/home_product2_categories?id_member=$idMember';
    final $params = <String, dynamic>{
      'id_device': idDevice,
      'id_city': idCity,
      'id_category_parent': idCategoryParent,
      'offset': offset,
      'limit': limit
    };
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCouponList(
      String headervalue, String atuhheader) {
    final $url = '/api/cart/coupon';
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMaincategoryProduct(
      String headervalue,
      String idMember,
      String idDevice,
      String idCity,
      String idCategoryParent,
      String offset,
      String limit) {
    final $url =
        '/api/product/product_home_product_categories?id_member=$idMember';
    final $params = <String, dynamic>{
      'id_device': idDevice,
      'id_city': idCity,
      'id_category_parent': idCategoryParent,
      'offset': offset,
      'limit': limit
    };
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFlashsale(String headervalue, String idCity) {
    final $url = '/api/product/flash_sale';
    final $params = <String, dynamic>{'id_city': idCity};
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getHomeCategory2(
      String headervalue, String idCity, String limit, String offset) {
    final $url = '/api/product/home_product2';
    final $params = <String, dynamic>{
      'id_city': idCity,
      'limit': limit,
      'offset': offset
    };
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCart(
      String headervalue, String atuhheader, String idDevice) {
    final $url = '/api/cart/cart';
    final $params = <String, dynamic>{'id_device': idDevice};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDetailTransaction(
      String headervalue, String atuhheader, String transactioncode) {
    final $url = '/api/member/transaction_detail';
    final $params = <String, dynamic>{'transaction_code': transactioncode};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPending(
      String headervalue, String atuhheader, String idMember) {
    final $url = '/api/member/transaction_pending';
    final $params = <String, dynamic>{'id_member': idMember};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAll(
      String headervalue, String atuhheader, String idMember) {
    final $url = '/api/member/transaction_all';
    final $params = <String, dynamic>{'id_member': idMember};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMember(
      String headervalue, String atuhheader, String idMember) {
    final $url = '/api/member';
    final $params = <String, dynamic>{'id_member': idMember};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCompleted(
      String headervalue, String atuhheader, String idMember) {
    final $url = '/api/member/transaction_completed';
    final $params = <String, dynamic>{'id_member': idMember};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCancel(
      String headervalue, String atuhheader, String idMember) {
    final $url = '/api/member/transaction_canceled';
    final $params = <String, dynamic>{'id_member': idMember};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLastseen(
      String headervalue, String idMember, String idDevice) {
    final $url = '/api/drivers/lastseen?id_member=$idMember';
    final $params = <String, dynamic>{'id_device': idDevice};
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSearch(
      String headervalue, String idMember, String idDevice, String keyword) {
    final $url = '/api/product/search?id_member=$idMember';
    final $params = <String, dynamic>{
      'id_device': idDevice,
      'keyword': keyword
    };
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRecomemded(
      String headervalue, String idMember, String idDevice, String idCity) {
    final $url = '/api/product/recomend_product?id_member=$idMember';
    final $params = <String, dynamic>{'id_device': idDevice, 'id_city': idCity};
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOngoing(
      String headervalue, String atuhheader, String idMember) {
    final $url = '/api/member/transaction_ongoing';
    final $params = <String, dynamic>{'id_member': idMember};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAlamat(
      String headervalue, String atuhheader, String id_member) {
    final $url = '/api/member/list_address';
    final $params = <String, dynamic>{'id_member': id_member};
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDetailProduct(
      String headervalue, String idproduct) {
    final $url = '/api/product/detail';
    final $params = <String, dynamic>{'id_product': idproduct};
    final $headers = {'api-key': headervalue};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCart(String headervalue, String atuhheader,
      String idProduk, String idDevice, String idCity, String quantity) {
    final $url = '/api/cart/add_cart';
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $body = <String, dynamic>{
      'id_product': idProduk,
      'id_device': idDevice,
      'id_city': idCity,
      'quantity': quantity
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postlogin(String headervalue, String firebase,
      String iddevice, String email, String password, String cpassword) {
    final $url = '/api/member/login';
    final $headers = {'api-key': headervalue};
    final $body = <String, dynamic>{
      'firebase': firebase,
      'id_device': iddevice,
      'email': email,
      'password': password,
      'cpassword': cpassword
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postRegister(
      String headervalue,
      String firebase,
      String iddevice,
      String email,
      String password,
      String cpassword,
      String fullname,
      String phone,
      String gender,
      String refferallink,
      String birthdate) {
    final $url = '/api/member/register';
    final $headers = {'api-key': headervalue};
    final $body = <String, dynamic>{
      'firebase': firebase,
      'id_device': iddevice,
      'email': email,
      'password': password,
      'cpassword': cpassword,
      'full_name': fullname,
      'phone': phone,
      'gender': gender,
      'refferal_link': refferallink,
      'birth_date': birthdate
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postSearch(
      String headervalue, String keyword, String idmember, String iddevice) {
    final $url = '/api/product/search';
    final $headers = {'api-key': headervalue};
    final $body = <String, dynamic>{
      'keyword': keyword,
      'id_member': idmember,
      'id_device': iddevice
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postCoupon(String headervalue, String atuhheader,
      String couponCode, String idMember) {
    final $url = '/api/cart/coupon';
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $body = <String, dynamic>{
      'coupon_code': couponCode,
      'id_member': idMember
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> changePembayaran(String headervalue,
      String idMember, String transactioncode, String paymentGateway) {
    final $url = '/api/payment/status_payment';
    final $headers = {'api-key': headervalue};
    final $body = <String, dynamic>{
      'id_member': idMember,
      'transaction_code': transactioncode,
      'payment_gateway': paymentGateway
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postCheckout(
      String headervalue,
      String atuhheader,
      String idMember,
      String idAddress,
      String deliveryMethod,
      String paymentGateway,
      String emergency,
      String couponCode,
      String note,
      String deliveryprice,
      String grandtotal,
      String idCity,
      String jadwal) {
    final $url = '/api/cart/checkout';
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $body = <String, dynamic>{
      'id_member': idMember,
      'id_address': idAddress,
      'delivery_method': deliveryMethod,
      'payment_gateway': paymentGateway,
      'emergency': emergency,
      'coupon_code': couponCode,
      'note': note,
      'delivery_price': deliveryprice,
      'grand_total': grandtotal,
      'id_city': idCity,
      'jadwal': jadwal
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postCekmutasi(String headervalue, String atuhheader,
      String transactioncode, String amount) {
    final $url = '/api/member/payment_cekmutasi';
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $body = <String, dynamic>{
      'transaction_code': transactioncode,
      'amount': amount
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postcanceltransaksi(String headervalue,
      String atuhheader, String transactioncode, String idMember) {
    final $url = '/api/member/delete_history_canceled';
    final $headers = {'api-key': headervalue, 'Authorization': atuhheader};
    final $body = <String, dynamic>{
      'transaction_code': transactioncode,
      'id_member': idMember
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> PostRegisterChekout(
      String headervalue,
      String firebase,
      String email,
      String password,
      String cpassword,
      String full_name,
      String phone,
      String id_device,
      String profile_pic) {
    final $url = '/api/cart/checkout_create_member';
    final $headers = {'api-key': headervalue};
    final $body = <String, dynamic>{
      'firebase': firebase,
      'email': email,
      'password': password,
      'cpassword': cpassword,
      'full_name': full_name,
      'phone': phone,
      'id_device': id_device,
      'profile_pic': profile_pic
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }

  @override
  Future<Response<dynamic>> postAlamat(
      String headervalue,
      String authheader,
      String id_province,
      String id_city,
      String postal_code,
      String phone,
      String name_acc,
      String address,
      String map,
      String latitude,
      String longitude) {
    final $url = '/api/member/add_address';
    final $headers = {'api-key': headervalue, 'Authorization': authheader};
    final $body = <String, dynamic>{
      'id_province': id_province,
      'id_city': id_city,
      'postal_code': postal_code,
      'phone': phone,
      'name_acc': name_acc,
      'address': address,
      'map': map,
      'latitude': latitude,
      'longitude': longitude
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request,
        requestConverter: FormUrlEncodedConverter.requestFactory);
  }
}
