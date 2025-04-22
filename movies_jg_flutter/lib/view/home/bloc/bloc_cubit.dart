

import 'package:movies_jg_flutter/core/core.dart';
import 'package:movies_jg_flutter/core/use_case/use_case.dart';

part 'bloc_state.dart';

class BlocCubit extends Cubit<BlocState> {
  final _useCase = AppGetIt.instance.get<AbstractUseCase>();
  Entity? entity;

  BlocCubit() : super(BlocInitial());

  Future<void> movies() async {
    final result = await _useCase.useCase();
    if (result.hasError || result.data == null) {
      emit(BlocError());
    } else {
      emit(BlocSuccess(entity: result.data!));
    }
  }
}