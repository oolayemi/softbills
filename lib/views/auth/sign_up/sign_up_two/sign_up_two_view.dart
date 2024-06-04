import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'sign_up_two_viewmodel.dart';

class SignUpTwoView extends StatelessWidget {
  final Map<String, dynamic> details;

  const SignUpTwoView({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpTwoViewModel>.reactive(
        viewModelBuilder: () => SignUpTwoViewModel(),
        onModelReady: (model) => model.setUp(details),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "",
              actions: [
                Row(
                  children: [
                    Text("2/3"),
                    SizedBox(width: 10),
                    TabButton(
                        selectedPage: 2, pageNumber: 1, width: 25, height: 8),
                    SizedBox(width: 5),
                    TabButton(
                        selectedPage: 2, pageNumber: 2, width: 25, height: 8),
                    SizedBox(width: 5),
                    TabButton(
                        selectedPage: 2, pageNumber: 3, width: 25, height: 8),
                    SizedBox(width: 5),
                  ],
                )
              ],
            ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: model.formKey,
                    child: ListView(
                      children: [
                        const Text(
                          "Set up your account Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        BuildTextField(
                          title: "Password",
                          hintText: "************",
                          controller: model.passwordController,
                          obscure: model.obscurePassword,
                          isLast: true,
                          suffixIcon: InkWell(
                            onTap: () => model.toggleObscurePassword(),
                            child: Icon(model.obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          onChanged: model.setPassword,
                          validator: (String? value) => value!.isEmpty
                              ? "Password field cannot be empty"
                              : !model.isPasswordValid
                                  ? "The password doesn't match the condition"
                                  : null,
                        ),
                        const SizedBox(height: 20),
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
                          model.gotoSignUpThree();
                        }
                      }),
                )
              ],
            ),
          );
        });
  }
}
