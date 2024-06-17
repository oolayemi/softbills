import 'package:flutter/material.dart';
import 'package:no_name/views/auth/sign_up/user_info_dob/user_info_dob_view.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'user_info_viewmodel.dart';

class UserInfoView extends StatelessWidget {
  final Map<String, dynamic> details;

  const UserInfoView({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserInfoViewModel>.reactive(
        viewModelBuilder: () => UserInfoViewModel(),
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
                  "Lastly, tell us more about yourself",
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
                  "Please enter your legal name. This information will be used to verify your account",
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
                const BuildTextField(title: "First name"),
                const SizedBox(
                  height: 13,
                ),
                const BuildTextField(title: "Last name"),
                const SizedBox(
                  height: 13,
                ),
                BuildDropDown(
                  list: const ['Male', 'Female'],
                  title: "Gender",
                  onChanged: (value) {},
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: double.infinity,
                  child: RoundedButton(
                    title: "Continue",
                    onPressed: (){
                      NavigationService().navigateToView(const UserInfoDobView(details: {}));
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
