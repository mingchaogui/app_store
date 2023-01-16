import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

class AuLoadingIndicator extends StatelessWidget {
  const AuLoadingIndicator({
    super.key,
    this.isSliver = false,
    required this.scrollDirection,
    required this.status,
    this.ignoredStatuses = const <IndicatorStatus>{},
  });

  // if your list is sliver list, you should build sliver indicator for it
  // isSliver=true, when use it in sliver list
  final bool isSliver;
  final Axis scrollDirection;
  final IndicatorStatus status;
  final Iterable<IndicatorStatus> ignoredStatuses;

  // 状态文本
  String get _statusText {
    switch (status) {
      case IndicatorStatus.none:
        return '';
      case IndicatorStatus.loadingMoreBusying:
      case IndicatorStatus.fullScreenBusying:
        return '加载中';
      case IndicatorStatus.error:
      case IndicatorStatus.fullScreenError:
        return '加载失败';
      case IndicatorStatus.noMoreLoad:
        return '到底了';
      case IndicatorStatus.empty:
        return '暂无数据';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFullScreen = <IndicatorStatus>{
      IndicatorStatus.fullScreenBusying,
      IndicatorStatus.fullScreenError,
      IndicatorStatus.empty,
    }.contains(status);

    if (ignoredStatuses.contains(status)) {
      if (isSliver && isFullScreen) {
        return const SliverToBoxAdapter();
      } else {
        return const SizedBox();
      }
    }

    final ThemeData theme = Theme.of(context);

    Widget? current;
    switch (status) {
      case IndicatorStatus.loadingMoreBusying:
        current = const CupertinoActivityIndicator();
        break;
      case IndicatorStatus.fullScreenBusying:
        current = const CupertinoActivityIndicator();
        break;
      case IndicatorStatus.error:
      case IndicatorStatus.noMoreLoad:
        String text = _statusText;
        if (scrollDirection == Axis.horizontal) {
          text = Characters(text).join('\n');
        }

        current = Text(
          text,
          style: theme.textTheme.labelMedium,
        );
        break;
      case IndicatorStatus.fullScreenError:
        current = Icon(
          Icons.error,
          size: kMinInteractiveDimension,
          color: Theme.of(context).errorColor,
        );
        break;
      case IndicatorStatus.none:
      case IndicatorStatus.empty:
    }

    if (current != null) {
      current = Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: current,
        ),
      );
    }

    if (isFullScreen) {
      if (isSliver) {
        current = SliverFillRemaining(child: current);
      }
    } else if (current != null) {
      current = SizedBox(
        width: scrollDirection == Axis.horizontal
            ? kMinInteractiveDimension
            : null,
        height:
            scrollDirection == Axis.vertical ? kMinInteractiveDimension : null,
        child: current,
      );
    }

    return current ?? const SizedBox();
  }
}
