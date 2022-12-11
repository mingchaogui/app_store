import 'dart:async';
import 'dart:developer';

import 'package:loading_more_list/loading_more_list.dart';

abstract class AuLoadingBase<T> extends LoadingMoreBase<T> {
  bool _hasMore = true;
  @override
  bool get hasMore => _hasMore;

  Object? _lastLoadId;
  Completer<bool> _completer = Completer<bool>();
  Completer<bool> get completer => _completer;

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    if (_lastLoadId != null) {
      try {
        await cancelLoading(_lastLoadId!);
      } catch (error, stackTrace) {
        assert(() {
          log(
            'Error occurred while trying to cancel loading by loadId: $_lastLoadId',
            error: error,
            stackTrace: stackTrace,
          );
          return true;
        }());
      }
    }

    final Object loadId = _lastLoadId = Object();
    if (_completer.isCompleted) {
      _completer = Completer<bool>();
    }

    try {
      final bool success = await loadDataWithId(
        loadId,
        isLoadMoreAction: isloadMoreAction,
      );

      _completer.complete(success);
    } catch (error, stackTrace) {
      assert(() {
        log('Load $T failed', error: error, stackTrace: stackTrace);
        return true;
      }());

      if (loadId == _lastLoadId) {
        _completer.complete(false);
      }
    }

    return _completer.future;
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) {
    // 重置hasMore
    _hasMore = true;
    // 打断loading
    isLoading = false;
    return super.refresh(notifyStateChanged);
  }

  Future<bool> loadDataWithId(
    Object loadId, {
    required bool isLoadMoreAction,
  });

  // 并发多个loadData时，后来的会取消前到的loading。
  // 可以在这里做一些中断请求之类的工作。
  Future<void> cancelLoading(Object loadId) async {
    // Do nothing by default.
  }
}

mixin AuLoadingBasePaginationMixin<T> on AuLoadingBase<T> {
  // 首页的页码，一般从1开始
  int get firstPage => 1;

  int _page = 0;
  int get page => _page;

  @override
  Future<bool> loadDataWithId(
    Object loadId, {
    required bool isLoadMoreAction,
  }) async {
    final int page = isLoadMoreAction ? _page + 1 : firstPage;

    return loadDataByPage(
      page,
      loadId: loadId,
      isLoadMoreAction: isLoadMoreAction,
    ).then((AuLoadingPagedResult<T> result) {
      if (!isLoadMoreAction) {
        clear();
      }
      addAll(result.data);
      _page = page;
      _hasMore = result.hasMore;

      return true;
    });
  }

  Future<AuLoadingPagedResult<T>> loadDataByPage(
    int page, {
    required Object loadId,
    required bool isLoadMoreAction,
  });

  bool testMore({
    required bool isLoadMoreAction,
    int? total,
    int lenChange = 0,
    int lenExpect = 0,
  }) {
    if (total != null) {
      return (isLoadMoreAction ? length : 0) + lenChange < total;
    }
    return lenChange >= lenExpect;
  }
}

class AuLoadingPagedResult<T> {
  const AuLoadingPagedResult({
    this.hasMore = true,
    // ignore: always_specify_types
    this.data = const [],
  });

  final bool hasMore;
  final List<T> data;
}
