import 'package:app_store/controller/start_page_controller.dart';
import 'package:app_store/model/applications/entry.dart';
import 'package:app_store/page/widget/app_horizontal_list_tile.dart';
import 'package:app_store/widget/loading_list/loading_list.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

class TopGrossingAppList extends StatelessWidget {
  const TopGrossingAppList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 144,
      child: AuLoadingList<EntryModel>(
        padding: const EdgeInsets.all(14),
        ignoredIndicatorStatuses: IndicatorStatus.values.toSet(),
        scrollDirection: Axis.horizontal,
        sourceList: StartPageController.to.grossingApps,
        itemBuilder: _buildItem,
        separatorBuilder: _buildSeparator,
      ),
    );
  }

  Widget _buildItem(BuildContext context, EntryModel item, int index) {
    return AppHorizontalListTile(
      appIcon: item.image.isNotEmpty ? item.image.last.label : null,
      appName: item.name.label,
      categoryName: item.category.attributes.label,
    );
  }

  Widget _buildSeparator(BuildContext context, EntryModel item, int index) {
    return const SizedBox(width: 14);
  }
}
