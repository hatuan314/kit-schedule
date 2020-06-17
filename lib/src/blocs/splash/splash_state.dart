part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {}

class CheckModeState extends SplashState {
  final bool isNightMode;

  CheckModeState(this.isNightMode);

  @override
  // TODO: implement props
  List<Object> get props => [this.isNightMode];
}

class CheckDataLoadingState extends SplashState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CheckDataSuccessState extends SplashState {
  CheckDataSuccessState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CheckNoDataState extends SplashState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CheckDataFailureState extends SplashState {
  final String error;

  CheckDataFailureState(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => "CheckDataFailureState - error {${error}}";
}
