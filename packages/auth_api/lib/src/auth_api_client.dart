// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auth_api/src/api_interceptor.dart';
import 'package:dio/dio.dart';

//Exception thrown when user registration fails
class RegistrationRequestFailure implements Exception {
  const RegistrationRequestFailure(this.statusCode, {this.message});
  final int statusCode;
  final String? message;

  @override
  String toString() {
    log('$statusCode:::$message');
    return message ?? '';
  }
}

//Exception thrown when user unknown error occur
class RegistrationError implements Exception {}

//Exception thrown when user login fails
class HttpRequestFailure implements Exception {
  const HttpRequestFailure(this.statusCode, {this.message});
  final int statusCode;
  final String? message;

  @override
  String toString() {
    return message ?? '';
  }
}

//Exception thrown when user unknown error occur
class HttpError implements Exception {}

class AuthApiClient {
  AuthApiClient({Dio? dio})
      : _dio = (dio ??
            Dio(
              BaseOptions(
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
              ),
            ))
          ..interceptors.add(ApiInterceptor())
          ..options.followRedirects = true
          ..options.baseUrl =
              'https://cdashboard-api-ooemp.ondigitalocean.app/';

  final Dio _dio;

  Future<Map<String, dynamic>> login({String? email, String? password}) async {
    try {
      Response response = await _dio.post(
        'auth/login',
        data: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 400 || response.statusCode == 401) {
        throw HttpRequestFailure(response.statusCode!,
            message: response.data['message']);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      }
      throw HttpRequestFailure(response.statusCode!);
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest ||
            e.response!.statusCode == HttpStatus.unauthorized) {
          throw HttpRequestFailure(e.response!.statusCode!,
              message: e.response!.data['message']);
        } else {
          throw HttpError();
        }
      }
      throw HttpError();
    }
  }

  Future<Map<String, dynamic>> changePassword(
      {String? currentPassword, String? newPassword}) async {
    try {
      Response response = await _dio.patch(
        'auth/users/update-password',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: jsonEncode(
            {'currentPassword': currentPassword, 'password': newPassword}),
      );
      print(response.data);
      if (response.statusCode == 400 || response.statusCode == 401) {
        throw HttpRequestFailure(response.statusCode!,
            message: response.data['message']);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      }
      throw HttpRequestFailure(response.statusCode!);
    } on DioError catch (e) {
      print(e.response);
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest ||
            e.response!.statusCode == HttpStatus.unauthorized) {
          throw HttpRequestFailure(e.response!.statusCode!,
              message: e.response!.data['message']);
        } else {
          throw HttpError();
        }
      }
      throw HttpError();
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      Response response = await _dio.get(
        'auth/profile/get-profile',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      if (response.statusCode == 400 || response.statusCode == 401) {
        throw HttpRequestFailure(response.statusCode!,
            message: response.data['message']);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      }
      throw HttpRequestFailure(response.statusCode!);
    } on DioError catch (e) {
      print(e.response);
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest ||
            e.response!.statusCode == HttpStatus.unauthorized) {
          throw HttpRequestFailure(e.response!.statusCode!,
              message: e.response!.data['message']);
        } else {
          throw HttpError();
        }
      }
      throw HttpError();
    }
  }
}
