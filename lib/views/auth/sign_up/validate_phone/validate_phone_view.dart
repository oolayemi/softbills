import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:no_name/views/auth/sign_in/sign_in_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'validate_phone_viewmodel.dart';

class ValidatePhoneView extends StatelessWidget {
  const ValidatePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ValidatePhoneViewModel>.reactive(
        viewModelBuilder: () => ValidatePhoneViewModel(),
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
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    'Welcome to softbills',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF0991CC)),
                  ),
                )
              ],
            ),
            body: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter your phone number ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    "We'll send you a code. It helps keep your account secure",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Phone Number",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          model.setPhoneNumber(number.phoneNumber!);
                        },
                        selectorConfig: const SelectorConfig(selectorType: PhoneInputSelectorType.DIALOG, trailingSpace: false),
                        ignoreBlank: false,
                        countries: const ['NG'],
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        formatInput: true,
                        hintText: "Phone number",
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF0991CC),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                        ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
                              children: [
                                TextSpan(
                                  text: ' Sign in',
                                  style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w700
                                      //   decoration: TextDecoration.underline,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const SignInView(),
                                          ));

                                      // Add any action you want to perform on tap here
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      title: "Send Code",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                            model.gotoSmsOtpView();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
            // body: Stack(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.only(
            //           bottom: MediaQuery.of(context).viewInsets.bottom),
            //       child: Form(
            //         key: model.formKey,
            //         child: ListView(
            //           children: [
            //             const Text(
            //               "Enter your Personal Information",
            //               textAlign: TextAlign.left,
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //             ),
            //             const SizedBox(height: 10),
            //             Text(
            //               "",
            //               style: TextStyle(
            //                 fontSize: 19,
            //                 color: Colors.black.withOpacity(.8),
            //               ),
            //             ),
            //             const SizedBox(height: 20),
            //             BuildTextField(
            //               title: "First Name",
            //               controller: model.firstnameController,
            //               validator: (String? value) => value!.isEmpty
            //                   ? "Firstname field cannot be empty"
            //                   : null,
            //             ),
            //             BuildTextField(
            //               title: "Last Name",
            //               controller: model.lastnameController,
            //               validator: (String? value) => value!.isEmpty
            //                   ? "Lastname field cannot be empty"
            //                   : null,
            //             ),
            //             BuildTextField(
            //               title: "Email Address",
            //               controller: model.emailController,
            //               validator: (String? value) => value!.isEmpty
            //                   ? "Email field cannot be empty"
            //                   : null,
            //             ),
            //             BuildDropDown(
            //                 list: const ['Male', 'Female'],
            //                 title: 'Gender',
            //                 value: model.gender,
            //                 onChanged: model.setGender),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const Text(
            //                   "Phone Number",
            //                   style: TextStyle(color: Colors.black),
            //                 ),
            //                 const SizedBox(
            //                   height: 6,
            //                 ),
            //                 InternationalPhoneNumberInput(
            //                   onInputChanged: (PhoneNumber number) {
            //                     model.setPhoneNumber(number.phoneNumber!);
            //                   },
            //                   selectorConfig: const SelectorConfig(
            //                       selectorType: PhoneInputSelectorType.DIALOG,
            //                       trailingSpace: false),
            //                   ignoreBlank: false,
            //                   countries: const ['NG'],
            //                   autoValidateMode: AutovalidateMode.disabled,
            //                   selectorTextStyle:
            //                       const TextStyle(color: Colors.black),
            //                   formatInput: true,
            //                   keyboardType:
            //                       const TextInputType.numberWithOptions(),
            //                   inputDecoration: InputDecoration(
            //                     filled: true,
            //                       fillColor:
            //                           const Color(0xFF605F5F).withOpacity(.1),
            //                       border: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(10),
            //                         borderSide: const BorderSide(
            //                             color: Colors.grey, width: .5),
            //                       ),
            //                       enabledBorder: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(10),
            //                         borderSide: BorderSide.none,
            //                       )),
            //                   onSaved: (PhoneNumber number) {
            //                     print('On Saved: $number');
            //                   },
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(height: 30),
            //             Column(
            //               children: [
            //                 SizedBox(
            //                   width: double.infinity,
            //                   child: RoundedButton(
            //                     title: "Proceed",
            //                     onPressed: () {
            //                       if (model.formKey.currentState!.validate()) {
            //                         if (model.gender != null) {
            //                           model.gotoSignUpTwo();
            //                         } else {
            //                           Fluttertoast.showToast(
            //                               msg: "Please select a gender to continue");
            //                         }
            //                       }
            //                     },
            //                   ),
            //                 ),
            //                 const SizedBox(height: 10),
            //                 InkWell(
            //                   onTap: () {
            //                     NavigationService navigatorService = locator<NavigationService>();
            //                     navigatorService.clearStackAndShowView(const SignInView());
            //                   },
            //                   child: RichText(
            //                     text: const TextSpan(
            //                       text: "Already an account? ",
            //                       style: TextStyle(color: Colors.grey, fontFamily: "BaiJamjuree"),
            //                       children: [
            //                         TextSpan(
            //                           text: "Sign In",
            //                           style: TextStyle(
            //                             color: Colors.black,
            //                             fontWeight: FontWeight.bold,
            //                             fontFamily: "BaiJamjuree",
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          );
        });
  }
}
