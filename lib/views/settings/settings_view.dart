import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:no_name/views/change_password/change_password.dart';
import 'package:no_name/views/change_transaction_pin/change_transaction_pin.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        onModelReady: (model) => model.setup(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "Settings"
            ),
            body: Column(
              children: [
                _eachSection("Biometrics", () {}, suffix: CupertinoSwitch(
                    value: model.verifiedBiometricStatus,
                    onChanged: (value) {
                      model.statusBiometric(context, value);
                    })),
                _eachSection("Change Password", () {
                  NavigationService().navigateToView(const ChangePasswordView());
                }),
                _eachSection("Change Transaction PIN", () {
                  NavigationService().navigateToView(const ChangeTransactionPinView());
                }),
              ],
            ),
          );
        });
  }

  _eachSection(String title, dynamic onTap, {Widget suffix = const SizedBox()}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), suffix],
        ),
      ),
    );
  }

}
