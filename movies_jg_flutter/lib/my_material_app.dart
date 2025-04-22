import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_jg_flutter/view/home/bloc/bloc_cubit.dart';
import 'package:movies_jg_flutter/view/home/view/home.dart';
import 'core/core.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocCubit>(
          create:
              (BuildContext context) =>
                  AppGetIt.instance.get<BlocCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'MoveisJG',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const Home(),
      ),
    );
  }
}