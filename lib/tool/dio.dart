import 'package:app_store/util/adapt_to_json_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

final Dio kDio = Dio()
  ..interceptors.addAll(<Interceptor>[
    PrettyDioLogger(
      requestHeader: true,
      responseHeader: true,
      logPrint: print,
      canShowLog: kDebugMode,
    ),
    AdaptToJsonInterceptor(),
  ])
  ..httpClientAdapter = Http2Adapter(
    ConnectionManager(),
  );
