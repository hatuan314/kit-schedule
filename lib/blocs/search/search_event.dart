part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {}

class SearchButtonOnPress extends SearchEvent {
  final DateTime selectDay;

  SearchButtonOnPress(this.selectDay);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
