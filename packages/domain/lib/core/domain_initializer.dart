import 'package:data/data.dart';

class DomainInitializer {
  static Future<void> init({
    required String url,
    required String anonKey,
  }) async {
    DataInitializer.init(url: url, anonKey: anonKey);
  }
}
