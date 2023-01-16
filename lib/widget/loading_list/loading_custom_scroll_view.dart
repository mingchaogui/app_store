import 'package:app_store/widget/loading_list/refresh_indicator.dart';
import 'package:flutter/material.dart' hide RefreshCallback;

import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class AuLoadingCustomScrollView extends StatelessWidget {
  const AuLoadingCustomScrollView({
    super.key,
    this.onRefresh,
    this.maxDragOffset,
    this.pullBackCurve = Curves.linear,
    this.pullBackDuration = const Duration(milliseconds: 300),
    this.refreshOffset = AuRefreshContainer.refreshOffset,
    this.reachToRefreshOffset = AuRefreshContainer.reachToRefreshOffset,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.shrinkWrap = false,
    this.refresh,
    required this.slivers,
  });

  final RefreshCallback? onRefresh;

  /// The max drag offset
  final double? maxDragOffset;

  /// The curve to use for the pullback animation
  final Curve pullBackCurve;

  /// The duration to use for the pullback animation
  final Duration pullBackDuration;

  /// The offset to keep when it is refreshing
  final double? refreshOffset;

  /// The offset to be dragged far enough that an up event will run the onRefresh callback.
  final double? reachToRefreshOffset;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Widget? refresh;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    Widget current = LoadingMoreCustomScrollView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      physics: physics,
      shrinkWrap: shrinkWrap,
      slivers: <Widget>[
        if (refresh != null) SliverToBoxAdapter(child: refresh),
        ...slivers,
      ],
    );

    if (onRefresh != null) {
      current = PullToRefreshNotification(
        onRefresh: onRefresh!,
        maxDragOffset: maxDragOffset,
        pullBackCurve: pullBackCurve,
        pullBackDuration: pullBackDuration,
        refreshOffset: refreshOffset,
        reachToRefreshOffset: reachToRefreshOffset ?? refreshOffset,
        child: current,
      );
    }

    return current;
  }
}
