import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_in/set_login_pin.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'otp_verification_viewmodel.dart';

class OtpVerificationView extends StatelessWidget {
  final String phone;
  const OtpVerificationView({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerificationViewModel>.reactive(
      viewModelBuilder: () => OtpVerificationViewModel(),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ListView(
                  children: [
                    const Text(
                      "Enter Code",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "We will send you a verification code to your Phone number: +234${phone.substring(1, 11)}",
                      style: const TextStyle(
                        fontSize: 19
                      ),
                    ),
                    const SizedBox(height: 30),
                    Pinput(
                      defaultPinTheme: PinTheme(
                        width: 80,
                        height: 80,
                        textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: const Color(0xFFE1D7C0).withOpacity(.2)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: RoundedButton(
                        title: "Submit",
                        onPressed: () {
                          NavigationService().clearStackAndShowView(const SetLoginPinView());
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {},
                      child: RichText(
                        text: const TextSpan(
                          text: "Didn't get the code? ",
                          style: TextStyle(color: Colors.grey, fontFamily: "BaiJamjuree"),
                          children: [
                            TextSpan(
                              text: "Resend",
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
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
