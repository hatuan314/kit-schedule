import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:schedule/service/database/database.dart';

import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///*BlocSupervisor.delegate =*/ SimpleBlocDelegate();
  await DatabaseCreator().initDatabase();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}
