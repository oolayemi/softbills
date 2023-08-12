import 'package:flutter/material.dart';
import 'package:no_name/app/locator.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/utility_widgets.dart';

class SettingsViewModel extends ReactiveViewModel {
  bool verifiedBiometricStatus = false;
  final StorageService _storageService = locator<StorageService>();

  bool? get biometricStatus => _storageService.getBool('biometric');

  void setup() async {
    if (biometricStatus == null) {
      _storageService.addBool('biometric', true);
    }
    verifiedBiometricStatus = biometricStatus!;
    notifyListeners();
  }

  void statusBiometric(BuildContext context, bool val) {
    if (val == true) {
      _storageService.addBool('biometric', true);
      verifiedBiometricStatus = true;
      flusher('Biometric Enabled', context, color: Colors.green);
    }
    else {
      _storageService.addBool('biometric', false);
      verifiedBiometricStatus = false;
      flusher('Biometric Disabled', context, color: Colors.red);
    }
    notifyListeners();
  }
  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}