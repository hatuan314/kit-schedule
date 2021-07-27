import 'package:flutter/foundation.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_type.dart';
abstract class SnackbarEvent {}

class ShowSnackbar extends SnackbarEvent {
  String? title;
  SnackBarType? type;
  Key? key;

  ShowSnackbar({
    @required this.title,
    @required this.type,
    this.key,
  });
}
