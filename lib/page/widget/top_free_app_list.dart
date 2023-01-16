import 'package:flutter/material.dart';

import '../../controller/start_page_controller.dart';
import '../../model/applications/entry.dart';
import '../../widget/loading_list/loading_list.dart';
import 'app_list_tile.dart';

class TopFreeAppList extends StatelessWidget {
  const TopFreeAppList({super.key});

  @override
  Widget build(BuildContext context) {
    return AuLoadingSliverList<EntryModel>(
      sourceList: StartPageController.to.freeApps,
      itemBuilder: _buildItem,
      separatorBuilder: _buildSeparator,
    );
  }

  Widget _buildItem(BuildContext context, EntryModel item, int index) {
    return AppListTile(
      index: index,
      trackId: item.id.attributes.id,
      appIcon: item.image.isNotEmpty ? item.image.last.label : null,
      appName: item.name.label,
      categoryName: item.category.attributes.label,
    );
  }

  Widget _buildSeparator(BuildContext context, EntryModel item, int index) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 14,
      endIndent: 14,
    );
  }
}
