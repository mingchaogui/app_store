import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'loading_more_indicator.dart';

class AuLoadingList<T> extends StatelessWidget {
  const AuLoadingList({
    super.key,
    this.buildSliver = false,
    this.ignoredIndicatorStatuses = const <IndicatorStatus>{},
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.gridDelegate,
    this.itemExtent,
    required this.sourceList,
    this.indicatorBuilder,
    required this.itemBuilder,
    this.separatorBuilder,
    this.itemCountBuilder,
    this.getActualIndex,
  })  : assert(!buildSliver || scrollDirection == Axis.vertical),
        assert(!buildSliver || !shrinkWrap);

  final bool buildSliver;
  // 禁用指定状态下的指示器
  final Set<IndicatorStatus> ignoredIndicatorStatuses;

  final Axis scrollDirection;
  final ScrollPhysics? physics;
  // No effect if your list is sliver list
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final SliverGridDelegate? gridDelegate;
  final double? itemExtent;
  final LoadingMoreBase<T> sourceList;
  final LoadingMoreIndicatorBuilder? indicatorBuilder;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, T item, int index)?
      separatorBuilder;
  final int Function(int count)? itemCountBuilder;
  final int Function(int int)? getActualIndex;

  @override
  Widget build(BuildContext context) {
    return buildSliver
        ? LoadingMoreSliverList<T>(
            SliverListConfig<T>(
              itemBuilder: _buildChild,
              sourceList: sourceList,
              indicatorBuilder: indicatorBuilder ?? _buildIndicator,
              gridDelegate: gridDelegate,
              lastChildLayoutType: LastChildLayoutType.fullCrossAxisExtent,
              padding: padding,
              itemExtent: itemExtent,
              childCountBuilder: itemCountBuilder ?? _buildItemCount,
              getActualIndex: getActualIndex ?? _getActualIndex,
            ),
          )
        : LoadingMoreList<T>(
            ListConfig<T>(
              itemBuilder: _buildChild,
              sourceList: sourceList,
              indicatorBuilder: indicatorBuilder ?? _buildIndicator,
              gridDelegate: gridDelegate,
              scrollDirection: scrollDirection,
              physics: physics,
              shrinkWrap: shrinkWrap,
              padding: padding,
              itemExtent: itemExtent,
              lastChildLayoutType: LastChildLayoutType.fullCrossAxisExtent,
              itemCountBuilder: itemCountBuilder ?? _buildItemCount,
              getActualIndex: getActualIndex ?? _getActualIndex,
            ),
          );
  }

  Widget _buildChild(BuildContext context, T item, int index) {
    final int actualIndex = _getActualIndex(index);
    if (separatorBuilder != null && index.isOdd) {
      return separatorBuilder!(context, item, actualIndex);
    }
    return itemBuilder(context, item, actualIndex);
  }

  Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
    return AuLoadingMoreIndicator(
      status: status,
      isSliver: buildSliver,
      ignoredStatuses: ignoredIndicatorStatuses,
    );
  }

  int _buildItemCount(int count) {
    return separatorBuilder != null ? count * 2 - 1 : count;
  }

  int _getActualIndex(int index) {
    return separatorBuilder != null ? index ~/ 2 : index;
  }
}
