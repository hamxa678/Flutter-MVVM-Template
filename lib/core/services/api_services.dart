import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/core/config/config.dart';
import 'package:flutter_mvvm_template/core/models/responses/base_responses/request_response.dart';
import 'package:flutter_mvvm_template/core/services/local_storage_service.dart';
import 'package:flutter_mvvm_template/locator.dart';


class ApiServices {
  final _config = locator<Config>();
  Future<Dio> launchDio() async {
    String? accessToken = locator<LocalStorageService>().accessToken;
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // dio.interceptors.add(
    //     DioCacheManager(CacheConfig(baseUrl: EndPoint.baseUrl)).interceptor);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    dio.options.headers["Authorization"] = 'Bearer $accessToken';

    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      if (s != null) {
        return s < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  get({required String endPoint, params}) async {
    Dio dio = await launchDio();
    final response = await dio
        .get('${_config.baseUrl}/$endPoint', queryParameters: params)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }

  post({required String endPoint, data}) async {
    Dio dio = await launchDio();
    final response = await dio
        .post('${_config.baseUrl}/$endPoint', data: data)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }

  put({required String endPoint, data}) async {
    Dio dio = await launchDio();
    final response = await dio
        .put('${_config.baseUrl}/$endPoint', data: data)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }

  delete({required String endPoint, params}) async {
    Dio dio = await launchDio();
    final response = await dio
        .delete('${_config.baseUrl}/$endPoint', queryParameters: params)
        .catchError((e) {
      debugPrint('Unexpected Error');
    });
    if (response.statusCode == 200) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false, error: 'Server Error');
    } else {
      return RequestResponse(false, error: 'Network Error');
    }
  }
}
