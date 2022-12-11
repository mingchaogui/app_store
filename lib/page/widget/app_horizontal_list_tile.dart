import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AppHorizontalListTile extends StatelessWidget {
  const AppHorizontalListTile({
    super.key,
    required this.appIcon,
    required this.appName,
    required this.categoryName,
  });

  final String? appIcon;
  final String appName;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: appIcon != null
                ? ExtendedImage.network(
                    appIcon!,
                    width: 64,
                    height: 64,
                  )
                : const SizedBox.square(
                    dimension: 64,
                    child: ColoredBox(color: Colors.grey),
                  ),
          ),
          Text(
            appName,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            categoryName,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
