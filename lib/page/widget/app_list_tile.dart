import 'package:app_store/controller/look_up_service.dart';
import 'package:app_store/model/look_up/look_up_result.dart';
import 'package:app_store/widget/rating_bar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

const double _kIconSize = 56.0;

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.index,
    required this.trackId,
    required this.appIcon,
    required this.appName,
    required this.categoryName,
  });

  final int index;
  final int trackId;
  final String? appIcon;
  final String appName;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = appIcon != null
        ? ExtendedImage.network(
            appIcon!,
            width: _kIconSize,
            height: _kIconSize,
          )
        : const SizedBox.square(
            dimension: _kIconSize,
            child: ColoredBox(color: Colors.grey),
          );
    if (index.isEven) {
      iconWidget = ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: iconWidget,
      );
    } else {
      iconWidget = ClipOval(
        child: iconWidget,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
            child: Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          iconWidget,
          const SizedBox(width: 10),
          Expanded(
            child: _buildTrailing(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          appName,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          categoryName,
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        FutureBuilder<LookUpResultModel?>(
          future: LookUpService.to.lookUp(trackId),
          builder: _buildRatingRow,
        ),
      ],
    );
  }

  Widget _buildRatingRow(
    BuildContext context,
    AsyncSnapshot<LookUpResultModel?> snapshot,
  ) {
    final LookUpResultModel? data = snapshot.data;

    return Row(
      children: <Widget>[
        if (data != null) RatingBar(value: data.averageUserRating),
        Text(
          data != null ? '(${data.userRatingCount})' : '',
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
