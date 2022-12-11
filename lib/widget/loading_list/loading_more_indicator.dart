import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

class AuLoadingMoreIndicator extends StatelessWidget {
  const AuLoadingMoreIndicator({
    super.key,
    required this.status,
    this.isSliver = false,
    this.ignoredStatuses = const <IndicatorStatus>{},
  });

  final IndicatorStatus status;
  // if your list is sliver list, you should build sliver indicator for it
  // isSliver=true, when use it in sliver list
  final bool isSliver;
  final Set<IndicatorStatus> ignoredStatuses;

  bool get isBusying {
    switch (status) {
      case IndicatorStatus.loadingMoreBusying:
      case IndicatorStatus.fullScreenBusying:
        return true;
      // ignore: no_default_cases
      default:
        return false;
    }
  }

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
    Widget current = ignoredStatuses.contains(status)
        ? const SizedBox()
        : _buildContent(context);

    const Set<IndicatorStatus> fullScreenStatus = <IndicatorStatus>{
      IndicatorStatus.fullScreenBusying,
      IndicatorStatus.fullScreenError,
      IndicatorStatus.empty,
    };
    if (isSliver && fullScreenStatus.contains(status)) {
      current = SliverFillRemaining(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: current,
        ),
      );
    }

    return current;
  }

  Widget _buildContent(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget current;

    switch (status) {
      case IndicatorStatus.loadingMoreBusying:
        current = const CupertinoActivityIndicator();
        break;
      case IndicatorStatus.fullScreenBusying:
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      case IndicatorStatus.error:
      case IndicatorStatus.noMoreLoad:
        current = Text(
          _statusText,
          style: theme.textTheme.labelMedium,
        );
        break;
      case IndicatorStatus.fullScreenError:
        return Center(
          child: Icon(
            Icons.error,
            size: kMinInteractiveDimension,
            color: Theme.of(context).errorColor,
          ),
        );
      case IndicatorStatus.empty:
        return const SizedBox();
      // ignore: no_default_cases
      default:
        return const SizedBox();
    }

    return SizedBox(
      height: kMinInteractiveDimension,
      child: Center(child: current),
    );
  }
}
