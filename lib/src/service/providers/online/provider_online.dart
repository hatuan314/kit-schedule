import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:schedule/src/service/services.dart';
import 'package:schedule/src/service/web_service.dart';

class ProviderOnline {
  final WebService _service = WebService();

  Future<String> fetchScheduleSchoolDataProvider(
      String account, String password) async {
    final dio = _service.setupDio();
    final authBody = {
      "studentAccount": "$account",
      "studentPassword": "$password"
    };

    final response = await dio.post('', data: authBody);
    if (response.data['status'] == true) {
//      debugPrint('fetchScheduleSchoolDataProvider ${response.data['dataJson'] is String}');
      String dataJson = json.encode(response.data['dataJson']);
      dio.close();
      return dataJson;
    } else {
      dio.close();
      return '';
    }
  }
}
