import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:movies_jg_flutter/core/core.dart';
import 'package:movies_jg_flutter/core/remote/remote.dart';

String get baseUrl {
  if (kIsWeb) {
    return 'http://localhost:4000/';
  } if (Platform.isAndroid) {
    return 'http://10.0.2.2:4000/';
  } if (Platform.isIOS) {
    return 'http://localhost:4000/';
  }
  return "";
}

abstract class AbstractDataSource {
  Future<GenericData<dynamic, EnumDataSourceError>> dataSource(Object? body);
}

class DataSource implements AbstractDataSource {
  final _remoteClient = AppGetIt.instance<AbstractRemoteClient>();

  @override
  Future<GenericData<dynamic, EnumDataSourceError>> dataSource(
      Object? body) async {
    final response = await _remoteClient.post(baseUrl, body);

    if (response.statusCode != 200 || response.data == null) {
      return GenericData.failed(error: EnumDataSourceError.hasErrorDataSource);
    }
    return GenericData.success(data: response.data!);
  }
}
