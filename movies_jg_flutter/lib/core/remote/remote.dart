import 'package:movies_jg_flutter/core/core.dart';

abstract class AbstractRemoteClient {
  Future<GenericResponse<dynamic, EnumRemoteError>> post(
      String url, Object? body);
}

class RemoteClient implements AbstractRemoteClient {
  
  final _headers = {
   "Content-Type": "application/json"
  };

  @override
  Future<GenericResponse<dynamic, EnumRemoteError>> post(
      String url, Object? body) async {
     var client = Client();
    try {
      final response = await client.post(Uri.parse(url),headers: _headers, body: body);

      if (response.statusCode != 200) {
        return GenericResponse(
            statusCode: response.statusCode,
            error: EnumRemoteError.badRequest);
      }
      return GenericResponse(statusCode: 200, data: response.body);
    } catch (_) {
      return GenericResponse(
          statusCode: 400, error: EnumRemoteError.badRequest);
    }
  }
}