import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/airtime_beneficiaries.dart';
import '../../core/models/data_billers.dart';
import 'airtime_viewmodel.dart';

class AirtimeView extends StatelessWidget {
  const AirtimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AirtimeViewModel>.reactive(
      viewModelBuilder: () => AirtimeViewModel(),
      onModelReady: (model) => model.setup(context),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(title: "Airtime"),
          body: Stack(
            children: [
              Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: model.airtimeBeneficiaries == null ||
                              model.airtimeBeneficiaries!.isEmpty
                          ? const SizedBox()
                          : Row(
                              children: model.airtimeBeneficiaries!
                                  .map((e) => _eachBeneficiary(e, model))
                                  .toList(),
                            ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130,
                          child: BuildBillerDropDown(
                            list: model.billers,
                            title: "Provider",
                            value: model.selectedBiller,
                            onChanged: (DataBillers? value) {
                              model.selectedBiller = value;
                              model.notifyListeners();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: BuildTextField(
                            title: "Phone Number",
                            textInputType: TextInputType.number,
                            controller: model.phoneController,
                            hintText: "Enter phone number",
                            validator: (String? val) => val!.isEmpty
                                ? "Phone field cannot be empty"
                                : null,
                            suffixIcon: InkWell(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                final PhoneContact contact =
                                    await FlutterContactPicker
                                        .pickPhoneContact();
                                String? phone = contact.phoneNumber?.number;
                                if (phone != null) {
                                  String repHyphen = phone.replaceAll('-', '');
                                  String newPhone =
                                      repHyphen.replaceAll(' ', '');
                                  model.phoneController.text =
                                      '0${newPhone.substring(newPhone.length - 10)}';
                                  model.notifyListeners();
                                }
                              },
                              child: const Icon(
                                Icons.perm_contact_cal_outlined,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    AmountTextField(
                      title: "Amount",
                      controller: model.amountController,
                      suffixTitle: Text(
                        formatMoney(model.wallet?.balance ?? "123.32"),
                      ),
                      validator: (String? val) =>
                          val!.isEmpty ? "Amount field cannot be empty" : null,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(model.buildText ?? ""),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: RoundedButton(
                  title: "Buy Now",
                  onPressed: () {
                    if (model.formKey.currentState!.validate()) {
                      validateTransactionDetails({
                        "Phone Number": model.phoneController.text,
                        "Network": model.selectedBiller?.name ?? "MTN",
                      }, model.amountController.text, context, func: () async {
                        await model.purchaseAirtime(context);
                      });
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _eachBeneficiary(
      AirtimeBeneficiary airtimeBeneficiary, AirtimeViewModel model) {
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
