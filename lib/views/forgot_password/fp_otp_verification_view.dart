import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_up/create_password/create_password_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../core/utils/tools.dart';
import 'forgot_password_viewmodel.dart';

class FPOtpVerificationView extends StatelessWidget {
  final String email;

  const FPOtpVerificationView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Don't worry! it happens. Please enter the code sent to $email",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  obscureText: true,
                  validator: (value) => value!.isEmpty
                      ? "OTP field cannot be empty"
                      : value.length < 6
                          ? "Please fill in all fields"
                          : null,
                  controller: model.otpController,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
                    decoration: BoxDecoration(
                      border: Border.all(width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Didn\'t get the code? ',
                            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(
                                text: model.isResendCodeEnable ? 'Resend it' : '',
                                style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w700
                                    //   decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (model.isResendCodeEnable) {
                                      model.resendRequest(context, email);
                                    } else {
                                      flusher("Please resend code when countdown is done", context, color: Colors.red);
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                            width: 19,
                            height: 19,
                            child: Image.asset(
                              'assets/images/Vector (3).png',
                              height: 19,
                              width: 19,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Countdown(
                          seconds: 180,
                          build: (BuildContext context, double time) => Text(
                            formatTime(time.toInt()),
                            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          interval: const Duration(seconds: 1),
                          controller: model.countdownController,
                          onFinished: () {
                            model.enableResendCode(true);
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: RoundedButton(
                        title: "Submit",
                        onPressed: () {
                          if (model.formKey.currentState!.validate()) {
                            model.verifyOtp(context, email);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
