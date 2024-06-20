import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'otp_verification_viewmodel.dart';

class SmsOtpVerificationView extends StatelessWidget {
  final String phone;
  final Map<String, dynamic> details;

  const SmsOtpVerificationView({super.key, required this.phone, required this.details});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerificationViewModel>.reactive(
      viewModelBuilder: () => OtpVerificationViewModel(),
      onViewModelReady: (model) => model.setUp(phone, details),
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
                  "We just sent an SMS",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        "Enter the security code we sent to $phone",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        NavigationService().back();
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0991CC),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  controller: model.otpController,
                  validator: (String? value) => value!.isEmpty ? "OTP field cannot be empty" : null,
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
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(
                                text: 'Resend it',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  if (!model.isResendCodeEnable) {
                                    toast("Please retry when the countdown is done", color: Colors.red);
                                  } else {
                                    // resend otp
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
                          seconds: 60,
                          build: (BuildContext context, double time) => Text(
                            "${time.toInt()}s",
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
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
                            model.verifyPhone(context);
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
