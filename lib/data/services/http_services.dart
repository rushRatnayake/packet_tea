import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:packet_tea/data/config/configurations.dart';

class HttpClientService {

  /// Base option : Loyalty URL
  static final _defaultBaseOptions = BaseOptions(
    baseUrl: Configurations
        .apiOrigin, //change in to production url when used in production
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  /// Get Request for RewardStickApp
  static Future<Response<T>> getReq<T>(String endpoint,
      {Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
        BaseOptionType baseOptionType = BaseOptionType.defaultBaseOption}) async {
    options = await _wrapWithSession(options, baseOptionType);
    return Dio(_defaultBaseOptions).get<T>(
      endpoint,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
    );
  }

  /// Post Request for RewardStickApp
  static Future<Response<T>> postReq<T>(String endpoint,
      {dynamic data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        BaseOptionType baseOptionType = BaseOptionType.defaultBaseOption}) async {
    options = await _wrapWithSession(options, baseOptionType);
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

  static Future<List<Response>> concurrent<T>(
      List<Future<Response<T>>> requests) async {
    return Future.wait([...requests]);
  }

  /// Wrapping the requests with sessions
  static Future<Options> _wrapWithSession(
      Options options, BaseOptionType optionType) async {
    String token = await getToken(optionType);
    print(token);
    return (options ?? Options())
        .merge(headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  }

  /// Calls Create token method and send the necessary data for each base option type
  static Future<String> getToken(BaseOptionType optionType) async {
    String token = "";
  }

  /// Create JWT tokens with and without access tokens
  static Future<String> createToken(
      String privateKey, String issuer, String audience) async {
    JWT jwt;
    return "";
  }
}

enum BaseOptionType {
  defaultBaseOption,
}