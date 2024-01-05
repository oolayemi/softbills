import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:no_name/views/auth/sign_in/sign_in_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import 'sign_up_one_viewmodel.dart';

class SignUpOneView extends StatelessWidget {
  const SignUpOneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpOneViewModel>.reactive(
        viewModelBuilder: () => SignUpOneViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              actions: [
                Row(
                  children: [
                    Text("1/3"),
                    SizedBox(width: 10),
                    TabButton(
                        selectedPage: 1, pageNumber: 1, width: 25, height: 8),
                    SizedBox(width: 5),
                    TabButton(
                        selectedPage: 1, pageNumber: 2, width: 25, height: 8),
                    SizedBox(width: 5),
                    TabButton(
                        selectedPage: 1, pageNumber: 3, width: 25, height: 8),
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
                          "Enter your Personal Information",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black.withOpacity(.8),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BuildTextField(
                          title: "First Name",
                          controller: model.firstnameController,
                          validator: (String? value) => value!.isEmpty
                              ? "Firstname field cannot be empty"
                              : null,
                        ),
                        BuildTextField(
                          title: "Last Name",
                          controller: model.lastnameController,
                          validator: (String? value) => value!.isEmpty
                              ? "Lastname field cannot be empty"
                              : null,
                        ),
                        BuildTextField(
                          title: "Email Address",
                          controller: model.emailController,
                          validator: (String? value) => value!.isEmpty
                              ? "Email field cannot be empty"
                              : null,
                        ),
                        BuildDropDown(
                            list: const ['Male', 'Female'],
                            title: 'Gender',
                            value: model.gender,
                            onChanged: model.setGender),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Phone Number",
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                model.setPhoneNumber(number.phoneNumber!);
                              },
                              selectorConfig: const SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG,
                                  trailingSpace: false),
                              ignoreBlank: false,
                              countries: const ['NG'],
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              formatInput: true,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputDecoration: InputDecoration(
                                filled: true,
                                  fillColor:
                                      const Color(0xFF605F5F).withOpacity(.1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: .5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                              },
                            ),
                          ],
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
                          title: "Proceed",
                          onPressed: () {
                            if (model.formKey.currentState!.validate()) {
                              if (model.gender != null) {
                                model.gotoSignUpTwo();
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please select a gender to continue");
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          NavigationService navigatorService = locator<NavigationService>();
                          navigatorService.clearStackAndShowView(const SignInView());
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Already an account? ",
                            style: TextStyle(color: Colors.grey, fontFamily: "BaiJamjuree"),
                            children: [
                              TextSpan(
                                text: "Sign In",
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
        });
  }
}
