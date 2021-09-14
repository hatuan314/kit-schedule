import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule/common/config/firebase_setup.dart';
import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/common/injector/injector.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'presentation/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  ///*BlocSupervisor.delegate =*/ SimpleBlocDelegate();
  Injector.setup();
  final hiveSetUp = Injector.getIt<LocalConfig>();
  await hiveSetUp.init();
  final firebaseSetup = Injector.getIt<FirebaseSetup>();
  await firebaseSetup.setUp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}
