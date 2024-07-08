import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'user_info_viewmodel.dart';

class UserInfoView extends StatelessWidget {
  final Map<String, dynamic> details;

  const UserInfoView({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserInfoViewModel>.reactive(
        viewModelBuilder: () => UserInfoViewModel(),
        onViewModelReady: (model) => model.setUp(details),
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
                  BuildTextField(
                    title: "First name",
                    controller: model.firstNameController,
                    validator: (value) => value!.isEmpty ? "Firstname field cannot be empty" :null,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  BuildTextField(
                    title: "Last name",
                    controller: model.lastNameController,
                    validator: (value) => value!.isEmpty ? "Lastname field cannot be empty" :null,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  BuildDropDown(
                    list: const ['Male', 'Female'],
                    value: model.gender,
                    title: "Gender",
                    onChanged: model.setGender,
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      title: "Continue",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          if (model.gender != null) {
                            model.goToDobPage();
                          } else {
                            toast("Please select a gender to continue", color: Colors.red);
                          }
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
