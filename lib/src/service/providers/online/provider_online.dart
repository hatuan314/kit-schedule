import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:schedule/data/data_sources/web_service.dart';
import 'package:schedule/src/models/account_model.dart';
import 'package:schedule/src/service/services.dart';

class ProviderOnline {
  final WebService _service = WebService();

  Future<String> fetchScheduleSchoolDataProvider(
      AccountModel accountModel) async {
    final dio = _service.setupDio();
    final authBody = {
      "studentAccount": "${accountModel.account}",
      "studentPassword": "${accountModel.hashPassword()}"
    };

    final response = await dio.post('', data: authBody);
    if (response.data['status'] == true) {
      String dataJson = json.encode(response.data['dataJson']);
      dio.close();
      return dataJson;
    } else {
      dio.close();
      return '';
    }
  }
}
