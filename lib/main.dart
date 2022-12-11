import 'package:app_store/controller/look_up_service.dart';
import 'package:app_store/page/start_page.dart';
import 'package:app_store/tool/sqlite_tool.dart';
import 'package:app_store/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await kSqliteTool.openDb().catchError((dynamic error, StackTrace stackTrace) {
    logU.e('Open database failed', error, stackTrace);
  });
  runApp(const AppStoreApp());
}

class AppStoreApp extends StatelessWidget {
  const AppStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
      initialBinding: _AppStoreBindings(),
    );
  }
}

class _AppStoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LookUpService());
  }
}
