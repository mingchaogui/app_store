import 'dart:convert';

import 'package:dio/dio.dart';

import 'logger.dart';

class AdaptToJsonInterceptor extends Interceptor {
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    final String? contentType =
        response.headers.value(Headers.contentTypeHeader);
    if (contentType != Headers.jsonContentType) {
      assert(() {
        logU.w(
            'The type of returned content is not json compatible: "$contentType"');
        return true;
      }());

      response.headers.set(Headers.contentTypeHeader, Headers.jsonContentType);
      response.data = json.decode(response.data);
    }

    super.onResponse(response, handler);
  }
}
