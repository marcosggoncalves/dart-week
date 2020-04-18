import 'dart:io';
import 'package:app_financeiro/app/repository/usuario.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CustomDio{
  var _dio;

  CustomDio(){
    _dio = Dio(_options);
  }

  CustomDio.withAuthentication() {
    _dio = Dio(_options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));
  }
            
  BaseOptions _options = BaseOptions(
    baseUrl:'http://api-finac.herokuapp.com',
    connectTimeout: 30000,
    receiveTimeout: 30000
  );

  Dio get instance => _dio;
      
  _onRequest(RequestOptions options) async{
    var token = await UsuarioRepository().getToken();
    options.headers['Authorization'] = token;

    print(options.data);
  }

  _onResponse(Response e) {
    print(e.data);
  }

  _onError(DioError e) {
    if(e.response?.statusCode == 403 || e.response?.statusCode == 401){
      UsuarioRepository().logout();
      Get.offAllNamed('/');
    }

    print(e);

    return e;
  }
}