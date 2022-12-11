import 'package:app_store/client/app_store_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 最受欢迎的Apps
  test(r'/rss/topgrossingapplications/limit=${limit}/json', () async {
    await AppStoreClient.to().topGrossingApplications();
  });

  // 下载量最多的免费App列表
  test(r'/rss/topFreeApplications/limit=${limit}/json', () async {
    await AppStoreClient.to().topFreeApplications();
  });

  // 查找App
  test(r'/rss/topFreeApplications/limit=${limit}/json', () async {
    await AppStoreClient.to().lookup(id: 1517783697);
  });
}
