import 'package:flutter/cupertino.dart' hide RefreshIndicatorMode;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart'
    hide CupertinoActivityIndicator;

const double _kActivityIndicatorRadius = 14.0;

class AuRefreshContainer extends StatelessWidget {
  const AuRefreshContainer({super.key});

  /// The offset to keep when it is refreshing
  static const double refreshOffset = 60.0;

  /// The offset to be dragged far enough that an up event will run the onRefresh callback.
  static const double reachToRefreshOffset = 100;

  @override
  Widget build(BuildContext context) {
    final PullToRefreshNotificationState? ss =
        context.findAncestorStateOfType<PullToRefreshNotificationState>();
    return StreamBuilder<PullToRefreshScrollNotificationInfo>(
      builder: (
        BuildContext context,
        AsyncSnapshot<PullToRefreshScrollNotificationInfo> snapshot,
      ) {
        return buildWithNotificationInfo(context, snapshot.data);
      },
      stream: ss?.onNoticed,
    );
  }

  Widget buildWithNotificationInfo(
    BuildContext context,
    PullToRefreshScrollNotificationInfo? info,
  ) {
    final double? dragOffset = info?.dragOffset;
    if (info == null || dragOffset == null || dragOffset <= 0) {
      return const SizedBox();
    }

    return SizedBox(
      height: dragOffset,
      child: _buildIndicator(context, info),
    );
  }

  Widget _buildIndicator(
    BuildContext context,
    PullToRefreshScrollNotificationInfo info,
  ) {
    final double percentageComplete =
        (info.dragOffset! / reachToRefreshOffset).clamp(0.0, 1.0);

    switch (info.mode) {
      case RefreshIndicatorMode.drag:
      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.canceled:
        // While we're dragging, we draw individual ticks of the spinner while simultaneously
        // easing the opacity in. Note that the opacity curve values here were derived using
        // Xcode through inspecting a native app running on iOS 13.5.
        const Curve opacityCurve = Interval(0.0, 0.35, curve: Curves.easeInOut);
        return Opacity(
          opacity: opacityCurve.transform(percentageComplete),
          child: CupertinoActivityIndicator.partiallyRevealed(
            radius: _kActivityIndicatorRadius,
            progress: percentageComplete,
          ),
        );
      case RefreshIndicatorMode.snap:
      case RefreshIndicatorMode.refresh:
        // Once we're armed or performing the refresh, we just show the normal spinner.
        return const CupertinoActivityIndicator(
          radius: _kActivityIndicatorRadius,
        );
      case RefreshIndicatorMode.done:
        // When the user lets go, the standard transition is to shrink the spinner.
        return const SizedBox();
      case RefreshIndicatorMode.error:
        return GestureDetector(
          // refresh notification
          onTap: info.pullToRefreshNotificationState.show,
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.error_rounded,
            color: Theme.of(context).errorColor,
          ),
        );
      // ignore: no_default_cases
      default:
        // Anything else doesn't show anything.
        return const SizedBox();
    }
  }
}
