import 'package:app_store/model/applications/entry.dart';
import 'package:app_store/tool/sqlite_tool.dart';
import 'package:get/get.dart';

import '../util/logger.dart';

class SearchPageController extends GetxController {
  static SearchPageController get to => Get.find();

  final RxList<EntryModel> results = RxList<EntryModel>();

  Future<List<EntryModel>> runQuery(String query) async {
    return kSqliteTool.appsTable
        .queryLikeName(name: query, limit: 100)
        .then((List<EntryModel> value) {
      return results.value = value;
    }).catchError((dynamic error, StackTrace stackTrace) {
      logU.e('Error occurred while trying to query', error, stackTrace);
      return const <EntryModel>[];
    });
  }
}
