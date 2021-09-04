import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:schedule/common/config/firebase_setup.dart';
import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/common/constants/key_constants.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/presentation/%20language_select/%20language_select.dart';
import 'package:schedule/service/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///*BlocSupervisor.delegate =*/ SimpleBlocDelegate();
  await DatabaseCreator().initDatabase();
  Injector.setup();
  final hiveSetUp = Injector.getIt<LocalConfig>();
  await hiveSetUp.init();
  final firebaseSetup = Injector.getIt<FirebaseSetup>();
  await firebaseSetup.setUp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs,));
}
