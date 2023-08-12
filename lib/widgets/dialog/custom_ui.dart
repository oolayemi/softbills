import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/enums/dialog_type.dart';
import 'dialog_loader.dart';
import 'dialog_prompt.dart';

Widget customDialogUi(
  DialogRequest dialogRequest,
  Function(DialogResponse) onDialogTap,
) {
  Map<String, dynamic>? data = (dialogRequest.customData as Map?) as Map<String, dynamic>?;
  var dialogType = data == null ? null : data['dialogType'];
  bool? toPlayStore = false;
  bool? require = false;

  if(dialogRequest.customData != null) {
    toPlayStore = data!['playstore'] as bool?;
    require = data['require'] as bool?;
  }

  switch (dialogType) {
    case DialogType.form:
    return DialogPrompt(
        request: dialogRequest,
        onDialogTap: onDialogTap,
        update: toPlayStore,
        require: require
      );
      break;
    default:
      return LoaderDialog(
        request: dialogRequest,
      );
      break;
  }
}