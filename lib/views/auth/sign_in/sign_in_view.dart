import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_in/sign_in_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../widgets/utility_widgets.dart';
import '../sign_up/sign_up_one/sign_up_one_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: model.formKey,
                  child: ListView(
                    children: [
                      const Text(
                        "Login",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter your sign in details",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 50),
                      BuildTextField(
                        title: "Email",
                        hintText: "olayemi@gmail.com",
                        controller: model.emailController,
                        obscure: false,
                        //onChanged: model.setPassword,
                        validator: (String? value) => value!.isEmpty ? "Email field cannot be empty" : null,
                      ),
                      BuildTextField(
                        title: "Password",
                        hintText: "************",
                        controller: model.passwordController,
                        obscure: true,
                        validator: (String? value) => value!.isEmpty ? "Password field cannot be empty" : null,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Column(
                  children: [
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
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        NavigationService navigatorService = locator<NavigationService>();
                        navigatorService.clearStackAndShowView(const SignUpOneView());
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.grey, fontFamily: "BaiJamjuree"),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "BaiJamjuree",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
