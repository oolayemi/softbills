import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_in/sign_in_viewmodel.dart';
import 'package:no_name/views/dashboard/dashboard_view.dart';
import 'package:no_name/views/forgot_password/fp_otp_verification_view.dart';
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
                    hintText: "olayemi@gmail.com",
                    controller: model.emailController,
                    obscure: false,
                    //onChanged: model.setPassword,
                    validator: (String? value) => value!.isEmpty ? "Email field cannot be empty" : null,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  BuildTextField(
                    title: "Password",
                    hintText: "************",
                    controller: model.passwordController,
                    obscure: true,
                    validator: (String? value) => value!.isEmpty ? "Password field cannot be empty" : null,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                        title: "Sign In",
                        onPressed: () {
                          NavigationService().navigateToView(const DashboardView());
                          // if (model.formKey.currentState!.validate()) {
                          //   model.signIn(context);
                          // }
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const ModalSheet();
                        },
                      );
                    },
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

class ModalSheet extends StatelessWidget {
  const ModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, top: 0, right: 5),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FPOtpVerificationView(email: "email"),
                  ), // Replace NextScreen with your desired screen
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/icon _messages.png'),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Password reset via SMS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/Frame 1000002942.png'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FPOtpVerificationView(email: "email"),
                  ), // Replace NextScreen with your desired screen
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/Vector (2).png'),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Password reset via Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/Frame 1000002942.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
