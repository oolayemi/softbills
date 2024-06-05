import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_up/create_password/create_password_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'fp_otp_verification_viewmodel.dart';

class FPOtpVerificationView extends StatelessWidget {
  final String email;

  const FPOtpVerificationView({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FPOtpVerificationViewModel>.reactive(
      viewModelBuilder: () => FPOtpVerificationViewModel(),
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
          body: Column(
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
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
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
                        text: const TextSpan(
                          text: 'Didn\'t get the code? ',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                              text: 'Resend it',
                              style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w700
                                  //   decoration: TextDecoration.underline,
                                  ),
                              //                 recognizer: TapGestureRecognizer()
                              //                   ..onTap = () {
                              // print('Resend it clicked');
                              // // Add any action you want to perform on tap here
                              //                   },
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
                      const Text(
                        '45s',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      )
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
                        NavigationService().clearStackAndShowView(const CreatePasswordView(from: "reset"));
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
