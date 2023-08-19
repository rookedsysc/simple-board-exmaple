import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  Dio dio = Dio();
  dio.interceptors.add(CustomInterceptor());
  return dio;
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("path : ${options.uri}\n\n");
    return super.onRequest(options, handler);
  }
}

