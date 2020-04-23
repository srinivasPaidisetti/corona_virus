import 'package:connectivity/connectivity.dart';
import 'package:coronavirus/network/models/complete_data.dart';
import 'package:coronavirus/network/network_manager.dart';
import 'package:coronavirus/ui/screens/home/home_screen.dart';
import 'package:coronavirus/utils/common_utils.dart';
import 'package:coronavirus/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppModel extends BaseModel {
  CompleteData _completeData;

  CompleteData get completeData => _completeData;

  set completeData(CompleteData completeData) {
    _completeData = completeData;
    notifyListeners();
  }

  bool _isFreshInstall = false;

  bool get isFreshInstall => _isFreshInstall;

  set isFreshInstall(bool isFreshInstall) {
    _isFreshInstall = isFreshInstall;
    notifyListeners();
  }

  Future<void> init(BuildContext context) async {
    Connectivity().checkConnectivity().then((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        completeData = await networkManager.fetchCompleteData();
        navigateTo(
            context,
            HomeScreen(
              completeData: completeData,
            ));
      } else {
        await Future.delayed(Duration(seconds: 1));
        Fluttertoast.showToast(
            msg: "Please check your internet connection & re open the open");
      }
    });
  }
}
