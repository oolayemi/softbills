import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../core/constants/loading_dialog.dart';
import '../../core/exceptions/error_handling.dart';
import '../../core/models/profile_response.dart';
import '../../core/services/auth_service.dart';
import '../../core/utils/tools.dart';
import '../../widgets/utility_widgets.dart';

class ProfileViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final formKey = GlobalKey<FormState>();

  ProfileData? get profileData => _authService.profileResponse;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  File? image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    notifyListeners();
  }

  void setUp() {
    firstNameController.text = profileData?.firstname ?? '';
    lastNameController.text = profileData?.lastname ?? '';
    phoneNumberController.text = profileData?.phone ?? '';
  }

  Future<void> updateProfile(context) async {
    LoaderDialog.showLoadingDialog(context, message: "Updating profile...");

    try {
      FormData formData = FormData.fromMap({
        'firstname': firstNameController.text,
        'lastname': lastNameController.text,
        'phone': phoneNumberController.text,
        'image': image != null ? await MultipartFile.fromFile(image!.path) : null
      });

      final response = await dio().post('/user/profile/update', data: formData);
      Map responseData = response.data!;

      await _authService.getDetails();
      _dialogService.completeDialog(DialogResponse());
      _navigationService.back();
      flusher(responseData['message'], context, color: Colors.green);
      notifyListeners();
    } on DioException catch (e) {
      print(e.response);
      _dialogService.completeDialog(DialogResponse());
      flusher('Request error: ${DioExceptions.fromDioError(e).toString()}', context,
          color: Colors.red);
    }
  }
}