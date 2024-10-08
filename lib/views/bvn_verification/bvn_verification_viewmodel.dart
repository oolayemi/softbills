import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/core/models/profile_response.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:no_name/views/next_of_kin/next_of_kin_view.dart';
import 'package:no_name/views/personal_data/personal_data_view.dart';
import 'package:no_name/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';
import '../auth/sign_up/otp_verification/verification_complete.dart';

class BVNVerificationViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();

  var formKey = GlobalKey<FormState>();

  ProfileData? get profile => _authService.profileResponse;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bvnController = TextEditingController();

  void setUp() {
    phoneNumberController.text = "0${profile!.phone!.substring(profile!.phone!.length - 10, profile!.phone!.length)}";
    notifyListeners();
  }

  Future verifyBvn(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Validating details...");

    Map<String, dynamic> payload = {'bvn': bvnController.text, 'phone': phoneNumberController.text};

    try {
      final response = await dio().post('/user/bvn/update', data: payload);

      Map responseData = response.data!;
      print(json);
      await _authService.getProfile();
      _dialogService.completeDialog(DialogResponse());


      _navigationService.back();
      _navigationService.navigateToView(VerificationComplete(
        title: "Successful",
        description: responseData['message'],
        buttonText: "Continue",
        onTap: () => _navigationService.back()
      ));

      notifyListeners();
    } on DioException catch (e) {
      print(e.response);
      _dialogService.completeDialog(DialogResponse());
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }
}
