import 'dart:async';

import 'package:app_store/client/app_store_client.dart';
import 'package:app_store/widget/loading_list/loading_base.dart';
import 'package:get/get.dart';

import '../model/applications/applications.dart';
import '../model/applications/entry.dart';
import '../tool/sqlite_tool.dart';
import '../util/logger.dart';

class StartPageController extends GetxController {
  static StartPageController get to => Get.find();

  final TopGrossingAppLoadingBase grossingApps = TopGrossingAppLoadingBase();
  final TopFreeAppLoadingBase freeApps = TopFreeAppLoadingBase();

  @override
  void onInit() {
    super.onInit();

    refreshAll();
  }

  Future<bool> refreshAll() {
    return Future.wait(<Future<bool>>[
      grossingApps.refresh(),
      freeApps.refresh(),
    ]).then((List<bool> value) {
      return value.every((bool element) => element);
    });
  }
}

class TopGrossingAppLoadingBase extends AuLoadingBase<EntryModel> {
  @override
  bool get hasMore => isEmpty;

  @override
  Future<bool> loadDataWithId(
    Object loadId, {
    required bool isLoadMoreAction,
  }) {
    return AppStoreClient.to()
        .topGrossingApplications()
        .then((ApplicationsModel value) async {
      unawaited(_saveToDb(value.feed.entry));

      assignAll(value.feed.entry);
      return true;
    });
  }
}

class TopFreeAppLoadingBase extends AuLoadingBase<EntryModel>
    with AuLoadingBasePaginationMixin<EntryModel> {
  static const int _pageSize = 10;

  @override
  Future<AuLoadingPagedResult<EntryModel>> loadDataByPage(
    int page, {
    required Object loadId,
    required bool isLoadMoreAction,
  }) async {
    if (isLoadMoreAction) {
      return kSqliteTool.topFreeAppsTable
          .queryAll(
        limit: _pageSize + 1,
        offset: (page - 1) * _pageSize,
      )
          .then((List<EntryModel> value) {
        return AuLoadingPagedResult<EntryModel>(
          hasMore: value.length > _pageSize,
          data: value.take(_pageSize).toList(),
        );
      });
    } else {
      final ApplicationsModel model =
          await AppStoreClient.to().topFreeApplications();

      // 等待缓存写入完成，避免缓存不同步（从第2页开始数据依赖于缓存）
      await _saveToDb(model.feed.entry, saveToTopFree: true);

      final List<EntryModel> pagedData =
          model.feed.entry.take(_pageSize).toList();
      return AuLoadingPagedResult<EntryModel>(
        hasMore: pagedData.length < model.feed.entry.length,
        data: pagedData,
      );
    }
  }
}

Future<void> _saveToDb(
  Iterable<EntryModel> models, {
  bool saveToTopFree = false,
}) async {
  try {
    await kSqliteTool.appsTable.saveAll(models);

    final Iterable<int> ids = models.map((EntryModel e) {
      return e.id.attributes.id;
    });
    await kSqliteTool.topFreeAppsTable.saveAll(ids);
  } catch (error, stackTrace) {
    logU.e('Error occurred while trying to save', error, stackTrace);
  }
}
