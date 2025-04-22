import 'package:flutter/services.dart' show rootBundle;
import 'package:movies_jg_flutter/core/core.dart';
import 'package:movies_jg_flutter/core/data/data_source.dart';

abstract class AbstractRepository {
  Future<GenericData<Entity, EnumRepositoryError>> repository();
}

class Repository implements AbstractRepository {
  final _dataSource = AppGetIt.instance.get<AbstractDataSource>();

  @override
  Future<GenericData<Entity, EnumRepositoryError>> repository() async {
    try {
      final query = await rootBundle.loadString('lib/graphql/queries/get_movies.gql');

      final body = jsonEncode({
        "query": query,
      });

      final response = await _dataSource.dataSource(body);

      if (response.hasError) {
        return GenericData.failed(error: EnumRepositoryError.hasErrorRepository);
      }

      var decode = jsonDecode(response.data);
      Entity data = Entity.fromJson(decode);

      return GenericData.success(data: data);
    } catch (e) {
      return GenericData.failed(error: EnumRepositoryError.hasErrorRepository);
    }
  }
}
