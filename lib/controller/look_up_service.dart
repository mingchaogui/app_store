import 'dart:async';

import 'package:app_store/client/app_store_client.dart';
import 'package:app_store/model/look_up/look_up.dart';
import 'package:app_store/model/look_up/look_up_result.dart';
import 'package:get/get.dart';
import 'package:quiver/collection.dart';

const int _cacheSize = 200;

class LookUpService extends GetxService {
  static LookUpService get to => Get.find();

  // 执行中的查找
  final Map<int, Completer<LookUpResultModel?>> completers =
      <int, Completer<LookUpResultModel>>{};
  // 查找结果缓存
  final LruMap<int, LookUpResultModel?> resultCache =
      LruMap<int, LookUpResultModel>(maximumSize: _cacheSize);

  Future<LookUpResultModel?> lookUp(int trackId) {
    if (resultCache.containsKey(trackId)) {
      return Future<LookUpResultModel?>.value(resultCache[trackId]);
    }

    Completer<LookUpResultModel?>? completer = completers[trackId];

    if (completer == null) {
      completer = completers[trackId] = Completer<LookUpResultModel>();

      AppStoreClient.to().lookup(id: trackId).then((LookUpModel value) {
        final LookUpResultModel? result = value.results.firstWhereOrNull(
            (LookUpResultModel element) => element.trackId == trackId);

        resultCache[trackId] = result;
        completer!.complete(result);
      }).catchError((dynamic error, StackTrace stackTrace) {
        completer!.completeError(error, stackTrace);
      }).whenComplete(() {
        completers.remove(trackId);
      });
    }

    return completer.future;
  }
}
