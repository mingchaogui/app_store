// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:app_store/widget/rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Search some apps', (WidgetTester tester) async {
    // Build our rating bar and trigger a frame.
    final int total = Random().nextInt(10);
    await tester.pumpWidget(RatingBar(
      total: total,
      value: Random().nextDouble() * total,
    ));

    // Verify that our stars has built.
    expect(find.byIcon(CupertinoIcons.star), findsWidgets);
    await tester.pump();
  });
}
