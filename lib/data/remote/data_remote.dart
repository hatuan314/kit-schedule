import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:schedule/common/config/firebase_setup.dart';

import 'package:schedule/service/web_service.dart';

class DataRemote {
  final FirebaseSetup firebaseSetup;
  final WebService _service = WebService();

  DataRemote({required this.firebaseSetup});

  Future<Map<String, dynamic>?> fetchScheduleSchoolDataDio(
      String account, String password) async {
    final dio = _service.setupDio();
    final authBody = {
      "studentAccount": "$account",
      "studentPassword": "$password"
    };

    final response = await dio.post('', data: authBody);

    if (response.data['status'] == true) {
//      debugPrint('fetchScheduleSchoolDataProvider ${response.data['dataJson'] is String}');
//       String dataJson = json.encode(response.data['dataJson']);
      dio.close();
      return response.data['dataJson'];
    } else {
      dio.close();
      return null;
    }
  }

  Future<Map> fetchScheduleSchoolDataFirebase(String msv) async {
    final response = await firebaseSetup.scheduleCollection.doc(msv).get();
    if (response.data() == null) {
      return {};
    } else {
      Map data = response.data() as Map;
      return data;
    }
  }
  Future<Map> fetchPersonalSchoolDataFirebase(String msv) async {
    log('>>>>>>>>>>>>');
    final response = await firebaseSetup.personalCollection.doc(msv).get();
    if (response.data() == null) {
      return {};
    } else {
      Map data = response.data() as Map;
      log('$data');
      return data;
    }
  }

  Future<String> syncScheduleSchoolDataFirebase(String msv, Map data) async {
    try {
      await firebaseSetup.scheduleCollection.doc(msv).set(data);
      return 'ok';
    } on FirebaseException {
      return '';
    }
  }

  Future<String> syncPersonalSchoolDataFirebase(
      String msv, Map<String, dynamic> data) async {
    try {
      final result = await firebaseSetup.personalCollection.doc(msv).get();
      if (result.data() == null) {
        await firebaseSetup.personalCollection.doc(msv).set(data);
      } else {
        await firebaseSetup.personalCollection.doc(msv).update(data);
      }
      return 'ok';
    } catch (e) {
      return '';
    }
  }
}
