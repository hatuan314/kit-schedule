part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {}

class SelectDatePickerOnPressEvent extends TodoEvent {
  final DateTime selectDay;

  SelectDatePickerOnPressEvent({this.selectDay});
  @override
  // TODO: implement props
  List<Object> get props => [this.selectDay];
}

class SelectTimePickerOnPressEvent extends TodoEvent {
  final TimeOfDay timer;

  SelectTimePickerOnPressEvent({this.timer});
  @override
  // TODO: implement props
  List<Object> get props => [this.timer];
}

class CreatePersonalScheduleOnPressEvent extends TodoEvent {
  final String name;
  final String note;

  CreatePersonalScheduleOnPressEvent(this.name, this.note);
  @override
  // TODO: implement props
  List<Object> get props => [this.name, this.note];
}

class UpdatePersonalScheduleOnPressEvent extends TodoEvent {
  final String name;
  final String note;
  final String id;

  UpdatePersonalScheduleOnPressEvent(this.id, this.name, this.note);

  @override
  // TODO: implement props
  List<Object> get props => [this.id, this.name, this.note];
}

class DetelePersonalScheduleOnPressEvent extends TodoEvent {
  final String id;

  DetelePersonalScheduleOnPressEvent(this.id);
  @override
  // TODO: implement props
  List<Object> get props => [this.id];
}
