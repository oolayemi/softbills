import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';

class ChangeTransactionPinViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController oldPin = TextEditingController();
  TextEditingController newPin = TextEditingController();
  TextEditingController confirmNewPin = TextEditingController();

  Future changePin(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Changing transaction pin...");

    Map<String, dynamic> payload = {
      'current_pin': oldPin.text,
      'new_pin': newPin.text,
      'new_pin_confirmation': confirmNewPin.text,
    };

    try {
      final response =
          await dio().post('/user/transaction-pin/change', data: payload);

      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());

      if (success == 'success') {
        await _authService.getProfile();
        notifyListeners();
        _dialogService.completeDialog(DialogResponse());
        _navigationService.back();
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context,
            color: Colors.red);
      }
    } on DioException catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context,
          color: Colors.red);
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];
}
