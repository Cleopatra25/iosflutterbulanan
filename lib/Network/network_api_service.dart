import 'package:chopper/chopper.dart';

part 'network_api_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class NetworkApiService extends ChopperService {
  @Get(path: '/banner')
  Future<Response> getBanner(@Header('api-key') String headervalue);

  @Get(path: '/address/location_city_by_province')
  Future<Response> getCityHome(@Header('api-key') String headervalue);

  @Get(path: '/product/promo_product?id_member={id_member}')
  Future<Response> getpromo(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
    @Query('id_city') String idCity,
  );

  @Get(path: '/product/recomend_product?id_member={id_member}')
  Future<Response> getrecomended(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
    @Query('id_city') String idCity,
  );

  @Get(path: '/product/highlight?id_member={id_member}')
  Future<Response> getHighlight(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
    @Query('id_city') String idCity,
  );

  @Get(path: '/product/home_product2_categories?id_member={id_member}')
  Future<Response> getMaincategory(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
    @Query('id_city') String idCity,
    @Query('id_category_parent') String idCategoryParent,
    @Query('offset') String offset,
    @Query('limit') String limit,
  );

  @Get(path: '/cart/coupon')
  Future<Response> getCouponList(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
  );

  @Get(path: '/product/product_home_product_categories?id_member={id_member}')
  Future<Response> getMaincategoryProduct(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
    @Query('id_city') String idCity,
    @Query('id_category_parent') String idCategoryParent,
    @Query('offset') String offset,
    @Query('limit') String limit,
  );

  @Get(path: '/product/flash_sale')
  Future<Response> getFlashsale(
    @Header('api-key') String headervalue,
    @Query('id_city') String idCity,
  );

  @Get(path: '/product/home_product2')
  Future<Response> getHomeCategory2(
    @Header('api-key') String headervalue,
    @Query('id_city') String idCity,
    @Query('limit') String limit,
    @Query('offset') String offset,
  );

  @Get(path: '/cart/cart')
  Future<Response> getCart(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_device') String idDevice,
  );

  @Get(path: 'member/transaction_detail')
  Future<Response> getDetailTransaction(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('transaction_code') String transactioncode,
  );

  @Get(path: '/member/transaction_pending')
  Future<Response> getPending(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_member') String idMember,
  );
  @Get(path: '/member/transaction_all')
  Future<Response> getAll(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_member') String idMember,
  );

  @Get(path: '/member')
  Future<Response> getMember(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_member') String idMember,
  );

  @Get(path: '/member/transaction_completed')
  Future<Response> getCompleted(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_member') String idMember,
  );
  @Get(path: '/member/transaction_canceled')
  Future<Response> getCancel(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_member') String idMember,
  );
  @Get(path: '/drivers/lastseen?id_member={id_member}')
  Future<Response> getLastseen(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
  );
  @Get(path: '/product/search?id_member={id_member}')
  Future<Response> getSearch(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
    @Query('keyword') String keyword,
  );

  @Get(path: '/product/recomend_product?id_member={id_member}')
  Future<Response> getRecomemded(
    @Header('api-key') String headervalue,
    @Path('id_member') String idMember,
    @Query('id_device') String idDevice,
    @Query('id_city') String idCity,
  );

  @Get(path: '/member/transaction_ongoing')
  Future<Response> getOngoing(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_member') String idMember,
  );

  @Get(path: '/member/list_address')
  Future<Response> getAlamat(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Query('id_member') String id_member,
  );
  @Get(path: '/product/detail')
  Future<Response> getDetailProduct(
    @Header('api-key') String headervalue,
    @Query('id_product') String idproduct,
  );

  @Post(path: '/cart/add_cart')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postCart(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Field('id_product') String idProduk,
    @Field('id_device') String idDevice,
    @Field('id_city') String idCity,
    @Field('quantity') String quantity,
  );

  @Post(path: '/member/login')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postlogin(
    @Header('api-key') String headervalue,
    @Field('firebase') String firebase,
    @Field('id_device') String iddevice,
    @Field('email') String email,
    @Field('password') String password,
    @Field('cpassword') String cpassword,
  );

  @Post(path: '/member/register')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postRegister(
    @Header('api-key') String headervalue,
    @Field('firebase') String firebase,
    @Field('id_device') String iddevice,
    @Field('email') String email,
    @Field('password') String password,
    @Field('cpassword') String cpassword,
    @Field('full_name') String fullname,
    @Field('phone') String phone,
    @Field('gender') String gender,
    @Field('refferal_link') String refferallink,
    @Field('birth_date') String birthdate,
  );

  @Post(path: '/product/search')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postSearch(
    @Header('api-key') String headervalue,
    @Field('keyword') String keyword,
    @Field('id_member') String idmember,
    @Field('id_device') String iddevice,
  );

  @Post(path: '/cart/coupon')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postCoupon(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Field('coupon_code') String couponCode,
    @Field('id_member') String idMember,
  );

  @Post(path: '/payment/status_payment')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> changePembayaran(
    @Header('api-key') String headervalue,
    @Field('id_member') String idMember,
    @Field('transaction_code') String transactioncode,
    @Field('payment_gateway') String paymentGateway,
  );

  @Post(path: '/cart/checkout')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postCheckout(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Field('id_member') String idMember,
    @Field('id_address') String idAddress,
    @Field('delivery_method') String deliveryMethod,
    @Field('payment_gateway') String paymentGateway,
    @Field('emergency') String emergency,
    @Field('coupon_code') String couponCode,
    @Field('note') String note,
    @Field('delivery_price') String deliveryprice,
    @Field('grand_total') String grandtotal,
    @Field('id_city') String idCity,
    @Field('jadwal') String jadwal,
  );

  @Post(path: '/member/payment_cekmutasi')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postCekmutasi(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Field('transaction_code') String transactioncode,
    @Field('amount') String amount,
  );

  @Post(path: '/member/delete_history_canceled')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postcanceltransaksi(
    @Header('api-key') String headervalue,
    @Header('Authorization') String atuhheader,
    @Field('transaction_code') String transactioncode,
    @Field('id_member') String idMember,
  );

  @Post(path: '/cart/checkout_create_member')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> PostRegisterChekout(
    @Header('api-key') String headervalue,
    @Field('firebase') String firebase,
    @Field('email') String email,
    @Field('password') String password,
    @Field('cpassword') String cpassword,
    @Field('full_name') String full_name,
    @Field('phone') String phone,
    @Field('id_device') String id_device,
    @Field('profile_pic') String profile_pic,
  );

  @Post(path: '/member/add_address')
  @FactoryConverter(
    request: FormUrlEncodedConverter.requestFactory,
  )
  Future<Response> postAlamat(
    @Header('api-key') String headervalue,
    @Header('Authorization') String authheader,
    @Field('id_province') String id_province,
    @Field('id_city') String id_city,
    @Field('postal_code') String postal_code,
    @Field('phone') String phone,
    @Field('name_acc') String name_acc,
    @Field('address') String address,
    @Field('map') String map,
    @Field('latitude') String latitude,
    @Field('longitude') String longitude,
  );

  static NetworkApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://bulanan.app',
      services: [
        _$NetworkApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({
          'api-key': 'sembako168',
        }),
        HttpLoggingInterceptor()
      ],
    );
    return _$NetworkApiService(client);
  }
}
