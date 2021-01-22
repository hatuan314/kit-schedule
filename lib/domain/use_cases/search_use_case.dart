import 'package:flutter/material.dart';
import 'package:schedule/domain/repositories/personal_schedule_repository.dart';

class SearchUseCase {
  final PersonalScheduleRepository personalScheduleRepository;

  SearchUseCase({@required this.personalScheduleRepository});
}