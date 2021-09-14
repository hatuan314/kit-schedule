part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {}

class GetUserNameEvent extends TodoEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SelectDatePickerOnPressEvent extends TodoEvent {
  final DateTime? selectDay;

  SelectDatePickerOnPressEvent({this.selectDay});

  @override
  // TODO: implement props
  List<Object?> get props => [this.selectDay];
}

class SelectTimePickerOnPressEvent extends TodoEvent {
  final TimeOfDay? timer;

  SelectTimePickerOnPressEvent({this.timer});

  @override
  // TODO: implement props
  List<Object?> get props => [this.timer];
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
  final String id;
  final String name;
  final String note;
  final String createAt;

  UpdatePersonalScheduleOnPressEvent(
      this.id, this.name, this.note, this.createAt);

  @override
  // TODO: implement props
  List<Object?> get props => [this.name, this.note, this.createAt, this.id];
}

class DetelePersonalScheduleOnPressEvent extends TodoEvent {
  final PersonalScheduleEntities personal;

  DetelePersonalScheduleOnPressEvent(this.personal);

  @override
  // TODO: implement props
  List<Object?> get props => [this.personal];
}
