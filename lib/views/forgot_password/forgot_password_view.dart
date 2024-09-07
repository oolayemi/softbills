import 'package:flutter/material.dart';
import 'package:no_name/views/forgot_password/forgot_password_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (context, model, _) {
          return CustomScaffoldWidget(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Image.asset('assets/images/Frame 1000002854.png'),
                ),
              ),
            ),
            body: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    "Don't worry! it happens. Please enter your email address or phone number to reset your password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BuildTextField(
                    title: "Email address / Phone number",
                    hintText: "Enter phone number or email",
                    controller: model.emailController,
                    validator: (String? value) => value!.isEmpty ? "Email/phone field cannot be empty" : null,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                        title: "Reset password",
                        onPressed: () {
                          if (model.formKey.currentState!.validate()) {
                            model.requestPasswordReset(context);
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
