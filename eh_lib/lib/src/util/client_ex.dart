import 'package:http/http.dart';

class ClientEx extends BaseClient {
  String userAgent = '';
  String referer = '';
  String cookie = '';

  Map<String, String> get headers {
    var headers = Map<String, String>();

    if (userAgent.isNotEmpty) headers['user-agent'] = this.userAgent;
    if (referer.isNotEmpty) headers['referer'] = this.referer;
    if (cookie.isNotEmpty) headers['cookie'] = this.cookie;

    return headers;
  }

  Future<StreamedResponse> send(BaseRequest request) {
    request.followRedirects = false;

    if (userAgent.isNotEmpty) request.headers['user-agent'] = this.userAgent;
    if (referer.isNotEmpty) request.headers['referer'] = this.referer;
    if (cookie.isNotEmpty) request.headers['cookie'] = this.cookie;

    return Client().send(request);
  }
}
