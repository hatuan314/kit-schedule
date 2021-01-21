import 'package:flutter/material.dart';
import 'package:schedule/domain/repositories/personal_schedule_repository.dart';

class TodoUseCase {
  final PersonalScheduleRepository repository;

  TodoUseCase({@required this.repository});
}