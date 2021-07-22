import 'package:equatable/equatable.dart';

abstract class LoadingState extends Equatable {}
class LoadingInitState extends LoadingState {
  @override
  List<Object> get props => [];

}