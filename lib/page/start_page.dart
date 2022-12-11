import 'package:app_store/controller/start_page_controller.dart';
import 'package:app_store/page/delegate/search_app_delegate.dart';
import 'package:app_store/widget/loading_list/loading_custom_scroll_view.dart';
import 'package:app_store/widget/loading_list/refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/top_free_app_list.dart';
import 'widget/top_grossing_app_list.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(context),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<StartPageController>(
        init: StartPageController(),
        builder: (StartPageController controller) {
          return AuLoadingCustomScrollView(
            onRefresh: controller.refreshAll,
            refresh: const AuRefreshContainer(),
            slivers: const <Widget>[
              SliverToBoxAdapter(
                child: Divider(height: 1, thickness: 1),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                sliver: SliverToBoxAdapter(
                  child: Text('Recommend'),
                ),
              ),
              SliverToBoxAdapter(
                child: TopGrossingAppList(),
              ),
              SliverToBoxAdapter(
                child: Divider(height: 1, thickness: 1),
              ),
              TopFreeAppList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => showSearch(
        context: context,
        delegate: SearchAppDelegate(),
      ),
      child: const SizedBox(
        width: double.infinity,
        height: 36,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: CupertinoColors.tertiarySystemFill,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.search_rounded,
                        size: 16,
                        color: CupertinoColors.placeholderText,
                      ),
                    ),
                    TextSpan(text: 'Search...'),
                  ],
                ),
                style: TextStyle(
                  color: CupertinoColors.placeholderText,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
