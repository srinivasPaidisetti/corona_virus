import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_constants.dart';
import 'models/base_server_response.dart';

mixin NetworkHelper {
  Dio _dio;

  Future<Dio> getDio() async {
//    if (_dio != null ) {
//      _dio.options.headers['Authorization'] = 'Bearer ${user.authToken}';
//      return _dio;
//    } else {
    final dio = Dio();
    final baseOptions = BaseOptions();
    Map<String, String> headers = Map<String, String>();
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = 'application/json';
//      headers['Authorization'] = 'Bearer ${user?.authToken ?? ''}';
    baseOptions.headers = headers;
    baseOptions.baseUrl = NetworkApi.BASE_URL;
    dio.options = baseOptions;
    dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio = dio;

    return dio;
  }

  Future<T> post<T extends BaseServerResponse>(T responseModel, String url,
      Map<String, dynamic> body,
      {ValueSetter<DioError> errorListener}) async {
    try {
      final dio = await getDio();
      final Response<String> response = await dio.post(url, data: body);
      return responseModel.fromString(response?.data);
    } on DioError catch (e) {
      errorListener(e);
    }
    return null;
  }

  Future<List<T>> postWithArrayResponse<T extends BaseServerResponse>(
      T responseModel, String url, Map<String, dynamic> body) async {
    try {
      final dio = await getDio();
      final response = await dio.post(url, data: body);
      return response.data?.map((x) => responseModel.fromJson(x));
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<T>> getWithArrayResponse<T extends BaseServerResponse>(
      T responseModel, String path, Map<String, String> params) async {
    try {
      final dio = await getDio();
      final response = await dio.get(path, queryParameters: params);
      return response.data?.map((x) => responseModel.fromJson(x));
    } catch (e) {}
    return null;
  }

  Future<T> get<T extends BaseServerResponse>(T responseModel, String path,
      {Map<String, dynamic> params,
        ValueSetter<DioError> errorListener}) async {
    try {
      final dio = await getDio();
      final response = await dio.get(path, queryParameters: params);
      return responseModel.fromJson(response?.data);
    } on DioError catch (e) {
      errorListener(e);
    }
    return null;
  }

  Future<List<T>> getWithArrayJsonResponse<T extends BaseServerResponse>(
      T responseModel, String path, Map<String, dynamic> params,
      {ValueSetter<DioError> errorListener}) async {
    try {
      final dio = await getDio();
      final response = await dio.get(path, queryParameters: params);
      final jsonArray = json.decode(response.data);
      final List<T> list = [];
      for (var x in jsonArray) {
        final model = responseModel.fromJson(x);
        list.add(model);
      }
      return list;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<T> delete<T extends BaseServerResponse>(T responseModel, String url,
      Map<String, dynamic> body) async {
    try {
      final dio = await getDio();
      final response = await dio.delete(url, queryParameters: body);
      return responseModel.fromJson(response?.data);
    } on DioError catch (e) {}
    return null;
  }
}
