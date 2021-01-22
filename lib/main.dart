import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:schedule/data/data_sources/database.dart';
import 'package:schedule/injection.dart';
import 'package:schedule/presentation/bloc/simple_bloc_delegate.dart';
import 'presentation/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  await DatabaseCreator().initDatabase();
  configureDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}
