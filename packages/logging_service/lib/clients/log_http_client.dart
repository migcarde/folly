import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:logging_service/extensions/string_extensions.dart';

class LogHttpClient extends BaseClient {
  final Client _inner = Client();
  final _log = Logger('HttpClient');

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    try {
      final streamedResponse = await _inner.send(request);

      if (streamedResponse.statusCode >= 400) {
        _log.info('HTTP request failed'.logTitle);
        _log.warning(
          '${request.method} ${request.url} ${streamedResponse.statusCode} ${streamedResponse.reasonPhrase}',
        );
      } else {
        if (kDebugMode) {
          final response = await Response.fromStream(streamedResponse);

          _log.info('HTTP request success'.logTitle);
          _log.fine(
            '${request.method} ${streamedResponse.statusCode} ${streamedResponse.reasonPhrase} ${request.url}',
          );

          final responseBody = response.body.length > 500
              ? '${response.body.substring(0, 500)}... [truncated]'
              : response.body;
          _log.fine('Response body: ${responseBody.removeLineBreaks}');

          return StreamedResponse(
            Stream.value(response.bodyBytes),
            response.statusCode,
            contentLength: response.contentLength,
            request: request,
            headers: response.headers,
            isRedirect: response.isRedirect,
            persistentConnection: response.persistentConnection,
            reasonPhrase: response.reasonPhrase,
          );
        }
      }
      return streamedResponse;
    } on Exception catch (e) {
      _log.info('HTTP request error'.logTitle);
      _log.severe('Request error: ${request.method} ${request.url}');
      _log.severe(e);
      rethrow;
    }
  }
}
