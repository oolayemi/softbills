import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/airtime_beneficiaries.dart';
import '../../core/models/data_billers.dart';
import 'airtime_viewmodel.dart';

class AirtimeView extends StatelessWidget {
  const AirtimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AirtimeViewModel>.reactive(
      viewModelBuilder: () => AirtimeViewModel(),
      onViewModelReady: (model) => model.setup(context),
      builder: (context, model, child) {
        Widget buildAmount(int value, int selectedValue) {
          return InkWell(
            onTap: () => model.changeSelectAmount(selectedValue, value),
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: model.selectedAmount == selectedValue ? const Color(0xFFF58634) : const Color(0xFFA4A9AE).withOpacity(.2),
              ),
              child: Center(
                child: Text(
                  "N$value",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          );
        }

        return CustomScaffoldWidget(
          appBar: const CustomAppBar(title: "Airtime"),
          body: Form(
            key: model.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choose Amount",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildAmount(100, 1),
                          buildAmount(200, 2),
                          buildAmount(500, 3),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildAmount(1000, 4),
                          buildAmount(2000, 5),
                          buildAmount(5000, 6),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AmountTextField(
                    title: "Amount",
                    controller: model.amountController,
                    validator: (String? val) => val!.isEmpty ? "Amount field cannot be empty" : null,
                    onChanged: (val) {
                      model.changeSelectAmount(0, null);
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: BuildAirtimeBillerDropDown(
                      list: model.billers,
                      title: "Network",
                      value: model.selectedBiller,
                      onChanged: (DataBillers? value) {
                        model.selectedBiller = value;
                        model.notifyListeners();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  BuildTextField(
                    title: "Phone Number",
                    textInputType: TextInputType.number,
                    controller: model.phoneController,
                    hintText: "Enter phone number",
                    validator: (String? val) => val!.isEmpty ? "Phone field cannot be empty" : null,
                    suffixTitle: InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        final PhoneContact contact =
                        await FlutterContactPicker.pickPhoneContact();
                        String? phone = contact.phoneNumber?.number;
                        if (phone != null) {
                          String repHyphen = phone.replaceAll('-', '');
                          String replaceCloseBracket = repHyphen.replaceAll(')', '');
                          String replaceOpenBracket = replaceCloseBracket.replaceAll('(', '');
                          String newPhone = replaceOpenBracket.replaceAll(' ', '');
                          model.phoneController.text = '0${newPhone.substring(newPhone.length - 10)}';
                          // model.phoneController.text = newPhone;
                          model.notifyListeners();
                        }
                      },
                      child: const Text(
                        "Choose contact",
                        style: TextStyle(color: Color(0xFF095F85), fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      title: "Next",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          pinPad(
                              ctx: context,
                              function: (String pin) {
                                model.purchaseAirtime(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         VerificationComplete(
                                //           title: "Successful",
                                //           description: "Your airtime is on its way",
                                //           buttonText: "View Receipt",
                                //           onTap: () {
                                //             NavigationService().popRepeated(2);
                                //           },
                                //         ),
                                //   ),
                                // );
                              });
                        }
                        // if (model.formKey.currentState!.validate()) {
                        //   if (model.selectedBiller != null) {
                        //     validateTransactionDetails({
                        //       "Phone Number": model.phoneController.text,
                        //       "Network": model.selectedBiller?.name,
                        //     }, model.amountController.text, context, func: () async {
                        //       await model.purchaseAirtime(context);
                        //     });
                        //   } else {
                        //     flusher("Pls select a provider", context, color: Colors.red);
                        //   }
                        // }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _eachBeneficiary(AirtimeBeneficiary airtimeBeneficiary, AirtimeViewModel model) {
    checkImage() {
      if (airtimeBeneficiary.operator == 'mtn') {
        return 'assets/images/billers/mtn.webp';
      } else if (airtimeBeneficiary.operator == 'glo') {
        return 'assets/images/billers/glo.webp';
      } else if (airtimeBeneficiary.operator == 'airtel') {
        return 'assets/images/billers/airtel.webp';
      } else {
        return 'assets/images/billers/9mobile.webp';
      }
    }

    return Row(
      children: [
        InkWell(
          onTap: () => model.setBeneficiary(airtimeBeneficiary),
          child: Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(checkImage()),
              ),
              const SizedBox(height: 10),
              Text(
                airtimeBeneficiary.phoneNumber!,
                style: const TextStyle(fontSize: 9),
              )
            ],
          ),
        ),
        const SizedBox(width: 15)
      ],
    );
  }
}
