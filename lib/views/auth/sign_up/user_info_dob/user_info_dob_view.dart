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
            body: Column(
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
                const BuildTextField(
                  title: "Date of birth",
                  hintText: "MM/DD/YYYY",
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
                      NavigationService().navigateToView(
                        VerificationComplete(
                          title: "All done!",
                          description: "Your account has been created. You're now ready to explore and enjoy all the features and benefits we have to offer.",
                          buttonText: "Start exploring App",
                          imageUrl: "assets/images/Design 1.png",
                          onTap: (){},
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          );
        });
  }
}
