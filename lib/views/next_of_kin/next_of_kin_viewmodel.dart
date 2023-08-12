import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:no_name/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/nok_response.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';

class NextOfKinViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  NokData? get nokData => _authService.nokResponse;

  final formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController phone = TextEditingController();


  Future saveNokDetails(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Saving details...");

    Map<String, dynamic> payload = {
      'firstname': firstName.text,
      'lastname': lastName.text,
      'email': email.text,
      'address': address.text,
      'relationship': relationship.text,
      'phone': phone.text
    };

    try {
      final response = await dio().post('/user/nok/add', data: payload);

      int? statusCode = response.statusCode;
      String? success = jsonDecode(response.toString())['status'];

      Map<String, dynamic> json = jsonDecode(response.toString());

      if (statusCode == 200) {
        if (success == 'success') {
          await _authService.getNextOfKin();
          notifyListeners();
          _dialogService.completeDialog(DialogResponse());
          _navigationService.back();
        } else {
          _dialogService.completeDialog(DialogResponse());
          flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
        }
      } else {
        _dialogService.completeDialog(DialogResponse());
        flusher(json['message'] ?? 'Error Fetching data', context, color: Colors.red);
      }
    } on DioError catch (e) {
      _dialogService.completeDialog(DialogResponse());
      print(e.response);
      flusher(DioExceptions.fromDioError(e).toString(), context, color: Colors.red);
    }
  }
  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}