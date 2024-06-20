import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_up/otp_verification/verification_complete.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'user_info_dob_viewmodel.dart';

class UserInfoDobView extends StatelessWidget {
  final Map<String, dynamic> details;

  const UserInfoDobView({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserInfoDobViewModel>.reactive(
        viewModelBuilder: () => UserInfoDobViewModel(),
        onModelReady: (model) => model.setUp(details),
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
            ),
            body: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What is your date of birth?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "We need your DOB to verify your account",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      model.chooseDate(context);
                    },
                    child: BuildTextField(
                      title: "Date of birth",
                      hintText: "MM/DD/YYYY",
                      enabled: false,
                      controller: model.datetimeController,
                      validator: (value) => value!.isEmpty ? "Date of birth field cannot be empty" : null,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      title: "Create account",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          model.createAccount();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          );
        });
  }
}
