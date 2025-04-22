import 'package:get_it/get_it.dart';
import 'package:movies_jg_flutter/core/data/data_source.dart';
import 'package:movies_jg_flutter/core/data/repository.dart';
import 'package:movies_jg_flutter/core/use_case/use_case.dart';
import 'package:movies_jg_flutter/view/home/bloc/bloc_cubit.dart';
import 'core/remote/remote.dart';

class AppGetIt {
  static GetIt instance = GetIt.instance;

  Future<void> setupProviders() async {
    instance.registerLazySingleton<AbstractRemoteClient>(() => RemoteClient());
        instance.registerLazySingleton<AbstractDataSource>(() => DataSource());
            instance.registerLazySingleton<AbstractRepository>(() => Repository());
                instance.registerLazySingleton<AbstractUseCase>(() => UseCase());
                    instance.registerLazySingleton<BlocCubit>(() => BlocCubit());




    
  }
}