import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/routes/router.dart';

class ApiService{
  static const _baseUrl = "";
  static const _connectionTimeout = 10000;
  static const _receiveTimeout = 10000;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds: _connectionTimeout),
      receiveTimeout: const Duration(milliseconds: _receiveTimeout),
    ),
  );

  Dio? _instance;
  Dio? getInstance() {
    _instance ??= createDioInstance();
    return _instance;
  }

  Dio? createDioInstance() {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (Response? response, handler) {
      if (response != null) {
        return handler.next(response);
      } else {
        return;
      }
    }, onError: (DioException error, handler) async {
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          handler.next(error);
        }
      }
    }));
    return _dio;
  }

  getCurrentBaseUrl(String path){
    return "";
  }

  Future<dynamic> get(String path, {dynamic body,BuildContext? context,}) async {
    try {
      var baseUrls = getCurrentBaseUrl(path);
      Options options = Options(headers: await getHeaders(null, context: context),);
      baseUrls = baseUrls + path;
      Response response =  await _dio.get(baseUrls, options: options, queryParameters: body);
      return response;
    } on DioException catch (e) {
      handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(String path, dynamic body, {bool? isMultipart, Map<String, dynamic>? queryParams,BuildContext? context,}) async {
    try {
      var baseUrls = getCurrentBaseUrl(path);
      Options options = Options(headers: await getHeaders(isMultipart, postData: body, context: context),);

      Dio localDio = _dio;
      if((isMultipart!=null && isMultipart)){
        localDio = Dio(BaseOptions(baseUrl: baseUrls));
      }
      Response response = await localDio.post(baseUrls + path, data: body, options: options, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      print("E is $e");
      Map<String, dynamic> val = {};
      return val;
    }
  }

  Future<Map<String, dynamic>> put(String path, dynamic body, {Map<String, dynamic>? queryParams, BuildContext? context}) async {
    try {
      var baseUrls = getCurrentBaseUrl(path);
      Options options = Options(headers: await getHeaders(null, postData: body, context: context),
      );
      Dio localDio = _dio;
      Response response = await localDio.put(baseUrls + path, data: body, options: options, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      print("E is $e");
      Map<String, dynamic> val = {};
      return val;
    }
  }

  Future<Map<String, dynamic>> delete(String path, {bool? isMultipart, dynamic body,BuildContext? context}) async {
    try {
      var baseUrls = getCurrentBaseUrl(path);
      Options options = Options(headers: await getHeaders(isMultipart, postData: body, context: context),);
      Dio localDio = _dio;
      if((isMultipart!=null && isMultipart)){
        localDio = Dio(BaseOptions(baseUrl: baseUrls));
      }

      Response response = await localDio.delete(baseUrls + path, data: body, options: options);
      return response.data;
    } on DioException catch (e) {
      print("E is $e");
      Map<String, dynamic> val = {};
      return val;
    }
  }

  getHeaders(bool? isMultipart, {dynamic postData, BuildContext? context}) async {
    var header = {
      'Content-Type': isMultipart!=null && isMultipart ? 'multipart/form-data' : "application/json"
      "charset=utf-8"
    };
    // var authToken;
    // if (authToken != null) {
    //   parseJwt(authToken);
    //   header["authorization"] = "bearer $authToken";
    // } else {
    //
    // }
    return header;
  }


  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {}

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {}

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  handleError(DioException error)async{
    print("Error is $error");
    switch(error.type){
      case DioExceptionType.connectionTimeout:
        return navigationService.pushNamed(Routes.noNetwork);
      default:
        return navigationService.pushNamed(Routes.noNetwork);
    }
  }
}

