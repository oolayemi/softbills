import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/airtime_data_model.dart';
import '../../core/models/data_billers.dart';
import '../../core/utils/size_config.dart';
import 'data_viewmodel.dart';

class DataView extends StatelessWidget {
  const DataView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DataViewModel>.reactive(
      viewModelBuilder: () => DataViewModel(),
      onViewModelReady: (model) => model.setup(context),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(title: "Data"),
          body: Form(
            key: model.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildBillerDropDown(
                  list: model.billers,
                  title: "Provider",
                  value: model.selectedBiller,
                  bottomSpacing: 0,
                  onChanged: (DataBillers? value) {
                    FocusScope.of(context).unfocus();
                    model.setDataBiller(value!);
                  },
                ),
                const SizedBox(height: 20),
                _selectDataPlan(context, model),
                const SizedBox(height: 20),
                AmountTextField(
                  title: "Amount",
                  controller: model.amountController,
                  enabled: false,
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
                      try {
                        final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                        String? phone = contact.phoneNumber?.number;
                        if (phone != null) {
                          String repHyphen = phone.replaceAll('-', '');
                          String replaceCloseBracket = repHyphen.replaceAll(')', '');
                          String replaceOpenBracket = replaceCloseBracket.replaceAll('(', '');
                          String newPhone = replaceOpenBracket.replaceAll(' ', '');
                          model.phoneController.text = '0${newPhone.substring(newPhone.length - 10)}';
                          model.notifyListeners();
                        }
                      } on Exception catch(exception) {
                        print(exception);
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
                              model.purchaseData(context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => VerificationComplete(
                              //       title: "Successful",
                              //       description: "Your airtime is on its way",
                              //       onTap: () {
                              //         NavigationService().popRepeated(2);
                              //       },
                              //     ),
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
        );
      },
    );
  }

  void planSelection({required BuildContext ctx, List<Plans>? plans, Function? selectPlan}) {
    showModalBottomSheet(
        enableDrag: false,
        context: ctx,
        isDismissible: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(SizeConfig.yMargin(ctx, 3)),
          topLeft: Radius.circular(SizeConfig.yMargin(ctx, 3)),
        )),
        builder: (context) => Container(
              padding: EdgeInsets.only(top: SizeConfig.yMargin(context, 2)),
              height: SizeConfig.yMargin(context, 70),
              color: BrandColors.mainBackground,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Select Data Plan'),
                        IconButton(onPressed: () => Navigator.of(ctx).pop(), icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (Plans item in plans!)
                            InkWell(
                              onTap: () {
                                selectPlan!(item);
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                width: SizeConfig.xMargin(context, 100),
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.yMargin(context, 2),
                                    horizontal: SizeConfig.xMargin(context, 4)),
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
                                child: Text('${item.description}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: SizeConfig.textSize(context, 2))),
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

  Widget _selectDataPlan(context, DataViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Plans",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: model.plans != null
              ? () => planSelection(ctx: context, plans: model.plans, selectPlan: (Plans plan) => model.setPlan(plan))
              : null,
          child: Container(
            height: 60,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: .5)),
            // decoration: BoxDecoration(
            //     color: const Color(0xFF605F5F).withOpacity(.1), borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    model.plans != null
                        ? model.selectedPlan != null
                            ? '${model.selectedPlan!.description}'
                            : "Select Plan"
                        : "Loading...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
        )
      ],
    );
  }
}
