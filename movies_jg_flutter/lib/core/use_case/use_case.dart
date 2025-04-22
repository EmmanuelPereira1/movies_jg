import 'package:movies_jg_flutter/core/core.dart';
import 'package:movies_jg_flutter/core/data/repository.dart';

abstract class AbstractUseCase {
  Future<GenericData<Entity, EnumUseCaseError>> useCase();
}

class UseCase implements AbstractUseCase{
  final _repository = AppGetIt.instance<AbstractRepository>();
  @override
  Future<GenericData<Entity, EnumUseCaseError>> useCase() async {
    final response = await _repository.repository();

    if(response.hasError || response.data == null) {
      return GenericData.failed(error: EnumUseCaseError.hasErrorUseCase);
    } else {
      return GenericData.success(data: response.data!);
    }
  }
}