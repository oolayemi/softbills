import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'change_password_viewmodel.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
        viewModelBuilder: () => ChangePasswordViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Change Transaction PIN"),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: model.formKey,
                    child: ListView(
                      children: [
                        BuildTextField(
                          title: "Current Password",
                          hintText: "************",
                          controller: model.oldPasswordController,
                          obscure: true,
                          validator: (String? value) => value!.isEmpty
                              ? "Password field cannot be empty"
                              : !model.isPasswordValid
                              ? "The password doesn't match the condition"
                              : null,
                        ),
                        const SizedBox(height: 20),
                        BuildTextField(
                          title: "New Password",
                          hintText: "************",
                          controller: model.newPasswordController,
                          obscure: model.obscurePassword,
                          isLast: true,
                          suffixIcon: InkWell(
                            onTap: () => model.toggleObscurePassword(),
                            child: Icon(model.obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          validator: (String? value) => value!.isEmpty
                              ? "Password field cannot be empty"
                              : !model.isPasswordValid
                              ? "The password doesn't match the condition"
                              : null,
                        ),
                        const SizedBox(height: 20),
                        FlutterPwValidator(
                            controller: model.newPasswordController,
                            minLength: 8,
                            specialCharCount: 1,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            width: 400,
                            height: 130,
                            onSuccess: () {
                              model.isPasswordValid = true;
                              model.notifyListeners();
                            },
                            onFail: () {
                              model.isPasswordValid = false;
                              model.notifyListeners();
                            })
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(
                      title: "Continue",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          model.changePassword(context);
                        }
                      }),
                )
              ],
            ),
          );
        });
  }
}
