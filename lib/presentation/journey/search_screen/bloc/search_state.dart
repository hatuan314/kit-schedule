import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';

abstract class SearchState extends Equatable {

}
class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}
class SearchInitState extends SearchState {
  final List<String> searchHistory;

  SearchInitState({@required this.searchHistory});
  @override
  List<Object> get props => [searchHistory];
}
class SearchSuccessState extends SearchState {
  final List<PersonalScheduleEntity> listSchedule;

  SearchSuccessState({@required this.listSchedule});
  @override
  List<Object> get props => [];

}