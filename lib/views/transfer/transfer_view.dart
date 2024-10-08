import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name/core/models/bank_data.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'transfer_viewmodel.dart';

class TransferView extends StatelessWidget {
  const TransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransferViewModel>.reactive(
      viewModelBuilder: () => TransferViewModel(),
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
                color: model.selectedAmount == selectedValue
                    ? const Color(0xFFF58634)
                    : const Color(0xFFA4A9AE).withOpacity(.2),
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
          appBar: const CustomAppBar(title: "Transfer"),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Choose Amount",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildAmount(500, 1),
                          buildAmount(1000, 2),
                          buildAmount(2000, 3),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildAmount(5000, 4),
                          buildAmount(10000, 5),
                          buildAmount(20000, 6),
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
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Beneficiaries",
                      style: TextStyle(color: Color(0xFF095F85), fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BuildBankListDropDown(
                    list: model.banks,
                    title: "Bank Name",
                    value: model.selectedBank,
                    onChanged: (Bank? value) {
                      model.selectedBank = value;
                      model.verified = false;
                      model.accountName = null;
                      model.notifyListeners();
                    },
                  ),
                  // const SizedBox(height: 20),
                  BuildTextField(
                      title: "Account Number",
                      textInputType: TextInputType.number,
                      controller: model.accountNumberController,
                      hintText: "Enter account number",
                      bottomSpacing: 0,
                      validator: (String? val) => val!.isEmpty ? "Account number field cannot be empty" : null,
                      onChanged: (value) {
                        model.verified = false;
                        model.accountName = null;
                        model.notifyListeners();
                      }),
                  model.accountName != null
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFDDFFD7), borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/svg/fancy_check.svg"),
                                  const SizedBox(width: 10),
                                  Text(model.accountName!),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  BuildTextField(
                    title: "Purpose",
                    controller: model.narrationController,
                    hintText: "Enter description here",
                    bottomSpacing: 0,
                    validator: (String? val) => val!.isEmpty ? "Purpose field cannot be empty" : null,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      title: model.verified ? "Proceed" : "Validate",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()) {
                          if (model.selectedBank != null) {
                            !model.verified
                                ? model.validateName(context)
                                : pinPad(
                                    ctx: context,
                                    function: (String pin) {
                                      model.makeTransfer(context);
                                    });
                          } else {
                            toast("Please select a bank to continue");
                          }
                        }
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

// Widget _eachBeneficiary(AirtimeBeneficiary airtimeBeneficiary, TransferViewModel model) {
//   checkImage() {
//     if (airtimeBeneficiary.operator == 'mtn') {
//       return 'assets/images/billers/mtn.webp';
//     } else if (airtimeBeneficiary.operator == 'glo') {
//       return 'assets/images/billers/glo.webp';
//     } else if (airtimeBeneficiary.operator == 'airtel') {
//       return 'assets/images/billers/airtel.webp';
//     } else {
//       return 'assets/images/billers/9mobile.webp';
//     }
//   }
//
//   return Row(
//     children: [
//       InkWell(
//         onTap: () => model.setBeneficiary(airtimeBeneficiary),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundImage: AssetImage(checkImage()),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               airtimeBeneficiary.phoneNumber!,
//               style: const TextStyle(fontSize: 9),
//             )
//           ],
//         ),
//       ),
//       const SizedBox(width: 15)
//     ],
//   );
// }
}
