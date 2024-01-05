import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:no_name/core/models/data_beneficiaries.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/data_billers.dart';
import '../../core/utils/size_config.dart';
import '../../core/utils/tools.dart';
import 'sme_data_viewmodel.dart';

class SmeDataView extends StatelessWidget {
  const SmeDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SmeDataViewModel>.reactive(
      onModelReady: (model) => model.setup(context),
      viewModelBuilder: () => SmeDataViewModel(),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(title: "SME Data"),
          body: Stack(
            children: [
              Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: model.dataBeneficiaries == null ||
                              model.dataBeneficiaries!.isEmpty
                          ? const SizedBox()
                          : Row(
                              children: model.dataBeneficiaries!
                                  .map((e) => _eachBeneficiary(e, model))
                                  .toList(),
                            ),
                    ),
                    const SizedBox(height: 30),
                    BuildTextField(
                      title: "Phone Number",
                      textInputType: TextInputType.number,
                      controller: model.phoneController,
                      hintText: "9032395066",
                      validator: (String? val) =>
                          val!.isEmpty ? "Phone field cannot be empty" : null,
                      suffixIcon: InkWell(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          final PhoneContact contact =
                              await FlutterContactPicker.pickPhoneContact();
                          String? phone = contact.phoneNumber?.number;
                          if (phone != null) {
                            String repHyphen = phone.replaceAll('-', '');
                            String newPhone = repHyphen.replaceAll(' ', '');
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
                    const SizedBox(height: 10),
                    _selectDataPlan(context, model),
                    const SizedBox(height: 30),
                    AmountTextField(
                      title: "Amount",
                      controller: model.amountController,
                      suffixTitle: Text(
                        formatMoney(
                          model.wallet!.balance,
                        ),
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
                        // "Network": model.selectedBiller!.name,
                        "Data Plan": "${model.package!.description}",
                      }, model.amountController.text, context, func: () async {
                        await model.purchaseData(context);
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
      DataBeneficiary dataBeneficiary, SmeDataViewModel model) {
    checkImage() {
      if (dataBeneficiary.operator == 'mtn') {
        return 'assets/images/billers/mtn.webp';
      } else if (dataBeneficiary.operator == 'glo') {
        return 'assets/images/billers/glo.webp';
      } else if (dataBeneficiary.operator == 'airtel') {
        return 'assets/images/billers/airtel.webp';
      } else {
        return 'assets/images/billers/9mobile.webp';
      }
    }

    return Row(
      children: [
        InkWell(
          onTap: () => model.setBeneficiary(dataBeneficiary),
          child: Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(checkImage()),
              ),
              const SizedBox(height: 10),
              Text(
                dataBeneficiary.phoneNumber!,
                style: const TextStyle(fontSize: 9),
              )
            ],
          ),
        ),
        const SizedBox(width: 15)
      ],
    );
  }

  Widget _selectDataPlan(context, SmeDataViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Plans",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (model.package != null) {
              planSelection(
                ctx: context,
                plans: model.smeBillers,
                selectPlan: (SMEDataBillers plan) =>
                    model.setPackage(plan, context),
              );
            }
          },
          child: Container(
            height: 60,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF605F5F).withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: model.package != null
                      ? Text(
                          model.package == null
                              ? 'Select MTN SME Data Plan'
                              : model.package!.description!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontSize: SizeConfig.textSize(context, 1.8)),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.yMargin(context, 2)),
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 1.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color?>(
                                      Colors.grey[500]),
                                  strokeWidth: 2,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.xMargin(context, 4)),
                                child: const Text('Loading'),
                              )
                            ],
                          ),
                        ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[500],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

void planSelection(
    {required BuildContext ctx,
    List<SMEDataBillers>? plans,
    Function? selectPlan}) {
  showModalBottomSheet(
      enableDrag: false,
      context: ctx,
      isDismissible: false,
      backgroundColor: BrandColors.mainBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(SizeConfig.yMargin(ctx, 3)),
        topLeft: Radius.circular(SizeConfig.yMargin(ctx, 3)),
      )),
      builder: (context) => Container(
            padding: EdgeInsets.only(top: SizeConfig.yMargin(context, 2)),
            height: SizeConfig.yMargin(context, 70),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.xMargin(context, 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select MTN SME Data Plan'),
                      IconButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (SMEDataBillers item in plans!)
                          InkWell(
                            onTap: () {
                              selectPlan!(item);
                              print('Select:::: ${item.toJson()}');
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              width: SizeConfig.xMargin(context, 100),
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.yMargin(context, 2),
                                  horizontal: SizeConfig.xMargin(context, 4)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: Text('${item.description}',
                                  // '${item.description} @ ${item.code}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontSize:
                                              SizeConfig.textSize(context, 2))),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
}
