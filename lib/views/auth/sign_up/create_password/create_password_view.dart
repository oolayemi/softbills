import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'create_password_viewmodel.dart';

class CreatePasswordView extends StatelessWidget {
  final String from;
  final Map<String, dynamic>? details;

  const CreatePasswordView({super.key, this.from = "new", this.details});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePasswordViewModel>.reactive(
        viewModelBuilder: () => CreatePasswordViewModel(),
        onViewModelReady: (model) => model.setUp(from, details),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset('assets/images/Frame 1000002902.png'),
                ),
              ),
            ),
            body: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create your password",
                    // textAlign: textAlign,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BuildTextField(
                    title: "Choose a password",
                    hintText: "password",
                    obscure: model.obscurePassword,
                    isLast: true,
                    suffixIcon: InkWell(
                      onTap: () => model.toggleObscurePassword(),
                      child: Icon(model.obscurePassword ? Icons.visibility : Icons.visibility_off),
                    ),
                    validator: (String? value) => value!.isEmpty
                        ? "Password field cannot be empty"
                        : !model.isPasswordValid
                            ? "The password doesn't match the condition"
                            : null,
                    controller: model.passwordController,
                  ),
                  FlutterPwValidator(
                      controller: model.passwordController,
                      minLength: 8,
                      specialCharCount: 1,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      width: 400,
                      height: 150,
                      onSuccess: () {
                        model.isPasswordValid = true;
                        model.notifyListeners();
                      },
                      onFail: () {
                        model.isPasswordValid = false;
                        model.notifyListeners();
                      }),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      title: "Done",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          model.gotoVerificationCompleteView();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          );
        });
  }
}
