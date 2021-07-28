
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitState extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class RegisterLoadingState extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegisterNoDataState extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class RegisterSuccessState extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class RegisterFailureState extends RegisterState {
  final String error;

  RegisterFailureState(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => "RegisterFailureState {error: $error}";
}

class RegisterShowPasswordState extends RegisterState {
  final bool isShow;

  RegisterShowPasswordState(this.isShow);
  @override
  // TODO: implement props
  List<Object> get props => [this.isShow];
}
