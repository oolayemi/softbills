import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/models/electricity_data.dart';
import '../../core/utils/size_config.dart';
import '../../core/utils/tools.dart';
import '../auth/sign_up/otp_verification/verification_complete.dart';
import 'electricity_viewmodel.dart';

class ElectricityView extends StatelessWidget {
  const ElectricityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ElectricityViewModel>.reactive(
      onViewModelReady: (model) => model.setup(context),
      viewModelBuilder: () => ElectricityViewModel(),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(
            title: "Electricity",
          ),
          body: Stack(
            children: [
              Form(
                key: model.formKey,
                child: Column(
                  children: [
                    _selectDataPlan(context, model),
                    const SizedBox(height: 20),
                    BuildTextField(
                      title: "Meter Number",
                      hintText: "Meter Number",
                      controller: model.meterNoController,
                      bottomSpacing: 0,
                      validator: (value) => value!.isEmpty ? "Meter number field cannot be empty" : null,
                      onChanged: (String value) => model.resetName(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: model.accountName != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Customer's name: "),
                                  Text(model.accountName!),
                                ],
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AmountTextField(
                      title: "Amount",
                      controller: model.amountController,
                      suffixTitle: Text(
                        formatMoney(model.wallet!.balance!),
                      ),
                      validator: (String? val) => val!.isEmpty ? "Amount field cannot be empty" : null,
                    ),
                    const SizedBox(height: 20),
                    // _selectType(context, model),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: RoundedButton(
                  title: model.verified ? "Buy Now" : "Validate Details",
                  onPressed: () {
                    if (model.formKey.currentState!.validate()) {
                      if (model.selectedBiller != null) {
                        !model.verified
                            ? model.validateMeter(context)
                            : pinPad(
                                ctx: context,
                                function: (String pin) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VerificationComplete(
                                        title: "Successful",
                                        description: "Your transfer is on its way",
                                        onTap: () {
                                          NavigationService().popRepeated(2);
                                        },
                                      ),
                                    ),
                                  );
                                });
                      } else {
                        toast("Please select a provider to continue");
                      }
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

  Widget _selectDataPlan(context, ElectricityViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Provider",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () {
            if (model.electricityBillers!.isNotEmpty) {
              billerSelection(
                ctx: context,
                billers: model.electricityBillers!,
                selectPlan: (ElectricityBillers item) => model.setElectricityBiller(item),
                model: model,
              );
            }
          },
          child: Container(
            height: 55,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: .7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: model.electricityBillers!.isNotEmpty
                      ? Row(
                          children: [
                            model.selectedBiller == null
                                ? const SizedBox()
                                : SizedBox(
                                    width: SizeConfig.xMargin(context, 10),
                                    child: CachedNetworkImage(
                                      imageUrl: model.selectedBiller!.image!,
                                      filterQuality: FilterQuality.low,
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) => const Icon(Icons.info_outline),
                                    ),
                                  ),
                            Container(
                              margin: EdgeInsets.only(left: SizeConfig.xMargin(context, 2)),
                              child: Text(
                                  model.selectedBiller == null ? 'Select Biller' : ucWord(model.selectedBiller!.narration!)),
                            ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2)),
                          child: Row(
                            children: [
                              AspectRatio(
                                aspectRatio: 1.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color?>(Colors.grey[500]),
                                  strokeWidth: 2,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
                                child: const Text('Loading'),
                              )
                            ],
                          ),
                        ),
                ),
                model.selectedBiller == null
                    ? Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[500],
                      )
                    : const SizedBox()
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _selectType(context, ElectricityViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Type",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: RadioListTile<String>(
                title: const Text("Prepaid"),
                value: "prepaid",
                groupValue: model.selectedType,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                onChanged: (value) {
                  model.selectedType = value!;
                  model.notifyListeners();
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: RadioListTile(
                title: const Text('Postpaid'),
                value: "postpaid",
                groupValue: model.selectedType,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                onChanged: (value) {
                  model.selectedType = value!;
                  model.notifyListeners();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void billerSelection({required BuildContext ctx, List<ElectricityBillers>? billers, Function? selectPlan, model}) {
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
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select Provider'),
                  IconButton(onPressed: () => Navigator.of(ctx).pop(), icon: const Icon(Icons.close))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (ElectricityBillers item in billers!)
                      InkWell(
                        onTap: () {
                          selectPlan!(item);
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          width: SizeConfig.xMargin(context, 100),
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.yMargin(context, 2), horizontal: SizeConfig.xMargin(context, 4)),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: SizeConfig.xMargin(context, 10),
                                child: CachedNetworkImage(
                                  imageUrl: item.image!,
                                  filterQuality: FilterQuality.low,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) => const Icon(Icons.info_outline),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: SizeConfig.xMargin(context, 2)),
                                  child: Text('${ucWord(item.shortName!)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: SizeConfig.textSize(context, 2))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
