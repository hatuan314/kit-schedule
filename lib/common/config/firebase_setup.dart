import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:schedule/common/config/default_env.dart';

class FirebaseSetup {
  late CollectionReference personalCollection;
  late CollectionReference scheduleCollection;
  Future<void> setUp() async {
    await Firebase.initializeApp();
    scheduleCollection =
        FirebaseFirestore.instance.collection(DefaultEnv.scheduleTable).doc(DefaultEnv.developDoc).collection(DefaultEnv.schoolCollection);
    personalCollection =
        FirebaseFirestore.instance.collection(DefaultEnv.scheduleTable).doc(DefaultEnv.developDoc).collection(DefaultEnv.personalCollection);
  }
}
