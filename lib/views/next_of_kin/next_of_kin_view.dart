import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'next_of_kin_viewmodel.dart';

class NextOfKinView extends StatelessWidget {
  const NextOfKinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NextOfKinViewModel>.reactive(
        viewModelBuilder: () => NextOfKinViewModel(),
        onModelReady: (model) {
          model.firstName.text = model.nokData?.firstName ?? '';
          model.lastName.text = model.nokData?.lastName ?? '';
          model.email.text = model.nokData?.email ?? '';
          model.relationship.text = model.nokData?.relationship ?? '';
          model.address.text = model.nokData?.address ?? '';
          model.phone.text = model.nokData?.phone ?? '';
        },
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Next of Kin Details"),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: model.formKey,
                    child: ListView(
                      children: [
                        BuildTextField(
                          title: "First Name",
                          controller: model.firstName,
                          validator: (value) => value!.isEmpty ? "Firstname field cannot be empty" : null,
                        ),
                        BuildTextField(
                          title: "Last Name",
                          controller: model.lastName,
                          validator: (value) => value!.isEmpty ? "Lastname field cannot be empty" : null,
                        ),
                        BuildTextField(
                          title: "Email Address",
                          controller: model.email,
                          validator: (value) => value!.isEmpty ? "Email field cannot be empty" : null,
                        ),
                        BuildTextField(
                          title: "Relationship",
                          controller: model.relationship,
                          validator: (value) => value!.isEmpty ? "Relationship field cannot be empty" : null,
                        ),
                        BuildTextField(
                          title: "Address",
                          controller: model.address,
                          validator: (value) => value!.isEmpty ? "Address field cannot be empty" : null,
                        ),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width / 3.5,
                        //       child: BuildDropDown(
                        //         list: const ["MTN", "Airtel", "9mobile", 'GLO'],
                        //         title: "Country",
                        //         value: "Airtel",
                        //         iconUrl: "assets/images/mtn.png",
                        //         onChanged: (String? value) {},
                        //       ),
                        //     ),
                        //     const SizedBox(width: 10),
                        //     Expanded(
                        //       child: BuildTextField(
                        //         title: "Phone Number",
                        //         textInputType: TextInputType.number,
                        //         hintText: "9032395066",
                        //         suffixIcon: InkWell(
                        //           onTap: () {
                        //             FocusScope.of(context).unfocus();
                        //           },
                        //           child: const Icon(
                        //             Icons.perm_contact_cal_outlined,
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Phone Number",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                //model.setPhoneNumber(number.phoneNumber!);
                              },
                              selectorConfig: const SelectorConfig(selectorType: PhoneInputSelectorType.DIALOG, trailingSpace: false),
                              ignoreBlank: false,
                              textFieldController: model.phone,
                              countries: const ['NG'],
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: const TextStyle(color: Colors.white),
                              formatInput: true,
                              validator: (value) => value!.isEmpty ? "Phone number field cannot be empty" : null,
                              keyboardType: const TextInputType.numberWithOptions(),
                              inputDecoration: InputDecoration(
                                fillColor: const Color(0xFF605F5F).withOpacity(.32),
                                filled: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                              ),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 50)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: RoundedButton(
                    title: "Save Changes",
                    onPressed: () {
                      if (model.formKey.currentState!.validate()) {
                        model.saveNokDetails(context);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
