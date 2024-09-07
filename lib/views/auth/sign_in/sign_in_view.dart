import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_in/sign_in_viewmodel.dart';
import 'package:no_name/views/forgot_password/forgot_password_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../widgets/utility_widgets.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        viewModelBuilder: () => SignInViewModel(),
        builder: (context, model, child) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Sign In",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                    title: "Email",
                    hintText: "test@sample.com",
                    controller: model.emailController,
                    validator: (String? value) => value!.isEmpty ? "Email field cannot be empty" : null,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
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
                    validator: (String? value) => value!.isEmpty ? "Password field cannot be empty" : null,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                        title: "Sign In",
                        onPressed: () {
                          if (model.formKey.currentState!.validate()) {
                            model.signIn(context);
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () => NavigationService().navigateToView(const ForgotPasswordView()),
                    child: const Center(
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
