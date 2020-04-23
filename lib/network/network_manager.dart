import 'package:coronavirus/network/api_constants.dart';
import 'package:coronavirus/network/models/complete_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'network_helper.dart';

_NetworkManager networkManager = _NetworkManager._();

class _NetworkManager with NetworkHelper {
  _NetworkManager._();

  Future<CompleteData> fetchCompleteData(
      {ValueSetter<DioError> errorResponse}) async {
    final doc =
        await get(CompleteData(), NetworkApi.summary, errorListener: (error) {
      errorResponse(error);
    });
    return doc;
  }
}
