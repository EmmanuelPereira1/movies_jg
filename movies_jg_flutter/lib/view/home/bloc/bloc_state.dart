part of 'bloc_cubit.dart';


@immutable
sealed class BlocState {
  const BlocState();

  List<Object?> get props => [];
}

class BlocInitial extends BlocState {}

class BlocLoading extends BlocState {}

class BlocError extends BlocState {}

class BlocSuccess extends BlocState {
  final Entity? entity;

  const BlocSuccess({this.entity});

  BlocSuccess copyWith({final Entity? entity}) {
    return BlocSuccess(entity: entity ?? this.entity);
  }

  @override
  List<Object?> get props => [entity];
}