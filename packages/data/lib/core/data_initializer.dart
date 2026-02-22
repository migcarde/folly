import 'package:logging_service/clients/log_http_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataInitializer {
  static Future<void> init({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      httpClient: LogHttpClient(),
    );
  }
}
