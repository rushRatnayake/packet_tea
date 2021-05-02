import 'dart:io';

import 'package:dio/dio.dart';
import 'package:packet_tea/data/config/configurations.dart';
import 'package:packet_tea/data/services/secure_storage.dart';

class HttpClientService {

  static final _defaultBaseOptions = BaseOptions(
    baseUrl: Configurations.apiOrigin,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  static Future<Response<T>> getReq<T>(
      String endpoint, {
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
        bool isProtectedEndpoint = true,
      }) async {
    if (isProtectedEndpoint) options = await _wrapWithSession(options);
    return Dio(_defaultBaseOptions).get<T>(
      endpoint,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
    );
  }

  static Future<Response<T>> postReq<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        bool isProtectedEndpoint = true,
      }) async {
    if (isProtectedEndpoint) options = await _wrapWithSession(options);
    return Dio(_defaultBaseOptions).post<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  static Future<Response<T>> deleteReq<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        bool isProtectedEndpoint = true,
      }) async {
    if (isProtectedEndpoint) options = await _wrapWithSession(options);
    return Dio(_defaultBaseOptions).delete<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }


  static Future<List<Response>> concurrent<T>(List<Future<Response<T>>> requests) async {
    return Future.wait([...requests]);
  }

  static Future<Options> _wrapWithSession(Options options) async {
    final SecureStorageService secureStorage = SecureStorageService();
    final accessToken = await secureStorage.readSecureData("AccessToken");
    if (accessToken != null) {
      return (options ?? Options())
          .merge(headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'});
    }else{
      return options;
    }
  }
}

class PacketTeaAPIResponse<T> extends Object {
  bool status;
  String message;
  T value;

  PacketTeaAPIResponse(Map<String, dynamic> json) {
    this.status = json['status'] as bool ?? false;
    this.message = json['message'] as String ?? "";
    if (json['value'] != null) {
      this.value = json['value'] as T;
    }
  }

  @override
  String toString() {
    return {
      "state": status,
      "message": message,
      "result": value,
    }.toString();
  }
}