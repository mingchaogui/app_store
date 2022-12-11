import 'package:app_store/model/look_up/look_up.dart';
import 'package:app_store/tool/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../model/applications/applications.dart';

part 'app_store_client.g.dart';

@RestApi(baseUrl: 'https://itunes.apple.com/hk')
abstract class AppStoreClient {
  factory AppStoreClient(Dio dio, {String? baseUrl}) {
    return _cache.putIfAbsent(baseUrl, () {
      return _AppStoreClient(dio, baseUrl: baseUrl);
    });
  }

  factory AppStoreClient.to() {
    return AppStoreClient(kDio);
  }

  static final Map<String?, AppStoreClient> _cache =
      <String?, AppStoreClient>{};

  // 最受欢迎的Apps
  @GET('/rss/topgrossingapplications/limit={limit}/json')
  Future<ApplicationsModel> topGrossingApplications({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Path() int limit = 10,
  });

  // 下载量最多的免费App列表
  @GET('/rss/topfreeapplications/limit={limit}/json')
  Future<ApplicationsModel> topFreeApplications({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Path() int limit = 100,
  });

  // 查找App
  @GET('/lookup?id={id}')
  Future<LookUpModel> lookup({
    @DioOptions() Options? options,
    @CancelRequest() CancelToken? cancelToken,
    @SendProgress() ProgressCallback? onSendProgress,
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
    @Path() required int id,
  });
}
