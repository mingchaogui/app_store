import 'package:app_store/model/applications/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/search_page_controller.dart';
import 'app_list_tile.dart';

class LookUpAppList extends StatelessWidget {
  const LookUpAppList({
    super.key,
    required this.query,
  });

  final String query;

  @override
  Widget build(BuildContext context) {
    return GetX<SearchPageController>(
      init: SearchPageController(),
      initState: (GetXState<SearchPageController> state) {
        state.controller!.runQuery(query);
      },
      didUpdateWidget:
          (GetX<dynamic> oldWidget, GetXState<SearchPageController> state) {
        state.controller!.runQuery(query);
      },
      builder: _buildWithController,
    );
  }

  Widget _buildWithController(SearchPageController controller) {
    return ListView.separated(
      itemBuilder: _buildItem,
      separatorBuilder: _buildSeparator,
      itemCount: controller.results.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final EntryModel item = SearchPageController.to.results[index];

    return AppListTile(
      index: index,
      trackId: item.id.attributes.id,
      appIcon: item.image.isNotEmpty ? item.image.last.label : null,
      appName: item.name.label,
      categoryName: item.category.attributes.label,
    );
  }

  Widget _buildSeparator(BuildContext context, int index) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 14,
      endIndent: 14,
    );
  }
}
