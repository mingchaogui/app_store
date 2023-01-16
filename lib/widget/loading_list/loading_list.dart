import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'loading_indicator.dart';

class AuLoadingList<T> extends StatelessWidget {
  const AuLoadingList({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.gridDelegate,
    this.itemExtent,
    this.autoRefresh = true,
    this.autoLoadMore = true,
    required this.sourceList,
    this.indicatorBuilder,
    required this.itemBuilder,
    this.separatorBuilder,
    this.itemCountBuilder,
    this.getActualIndex,
    this.ignoredIndicatorStatuses = const <IndicatorStatus>{},
  });

  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final SliverGridDelegate? gridDelegate;
  final double? itemExtent;
  final bool autoRefresh;
  final bool autoLoadMore;
  final LoadingMoreBase<T> sourceList;
  final LoadingMoreIndicatorBuilder? indicatorBuilder;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, T item, int index)?
      separatorBuilder;
  final int Function(int count)? itemCountBuilder;
  final int Function(int int)? getActualIndex;

  // 禁用指定状态下的指示器
  final Iterable<IndicatorStatus> ignoredIndicatorStatuses;

  @override
  Widget build(BuildContext context) {
    return LoadingMoreList<T>(
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
        autoLoadMore: autoLoadMore,
        lastChildLayoutType: LastChildLayoutType.fullCrossAxisExtent,
        autoRefresh: autoRefresh,
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
    return AuLoadingIndicator(
      scrollDirection: scrollDirection,
      status: status,
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

class AuLoadingSliverList<T> extends StatelessWidget {
  const AuLoadingSliverList({
    super.key,
    this.padding = EdgeInsets.zero,
    this.gridDelegate,
    this.itemExtent,
    this.autoRefresh = true,
    this.autoLoadMore = true,
    required this.sourceList,
    this.indicatorBuilder,
    required this.itemBuilder,
    this.separatorBuilder,
    this.itemCountBuilder,
    this.getActualIndex,
    this.showNoMore,
    this.lock,
    this.ignoredIndicatorStatuses = const <IndicatorStatus>{},
  });

  final EdgeInsetsGeometry padding;
  final SliverGridDelegate? gridDelegate;
  final double? itemExtent;
  final bool autoRefresh;
  final bool autoLoadMore;
  final LoadingMoreBase<T> sourceList;
  final LoadingMoreIndicatorBuilder? indicatorBuilder;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, T item, int index)?
      separatorBuilder;
  final int Function(int count)? itemCountBuilder;
  final int Function(int int)? getActualIndex;
  final bool? showNoMore;
  final bool? lock;

  // 禁用指定状态下的指示器
  final Set<IndicatorStatus> ignoredIndicatorStatuses;

  @override
  Widget build(BuildContext context) {
    return LoadingMoreSliverList<T>(
      SliverListConfig<T>(
        itemBuilder: _buildChild,
        sourceList: sourceList,
        indicatorBuilder: indicatorBuilder ?? _buildIndicator,
        gridDelegate: gridDelegate,
        autoLoadMore: autoLoadMore,
        lastChildLayoutType: LastChildLayoutType.fullCrossAxisExtent,
        padding: padding,
        itemExtent: itemExtent,
        autoRefresh: autoRefresh,
        childCountBuilder: itemCountBuilder ?? _buildItemCount,
        getActualIndex: getActualIndex ?? _getActualIndex,
        showNoMore: showNoMore,
        lock: lock,
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
    return AuLoadingIndicator(
      isSliver: true,
      scrollDirection: Axis.vertical,
      status: status,
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
