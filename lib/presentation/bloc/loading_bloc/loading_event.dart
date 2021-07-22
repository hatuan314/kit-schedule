import 'package:equatable/equatable.dart';

abstract class LoadingEvent extends Equatable {
}
class StartLoadingEvent extends LoadingEvent {
  @override
  List<Object> get props => [];
}
class FinishLoadingEvent extends LoadingEvent{
  @override
  List<Object> get props => [];
}