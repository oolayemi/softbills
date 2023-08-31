import 'package:flutter/material.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/enums/wallet_types.dart';
import '../../core/utils/size_config.dart';
import '../../core/utils/tools.dart';
import 'betting_viewmodel.dart';

class BettingView extends StatelessWidget {
  const BettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BettingViewModel>.reactive(
      viewModelBuilder: () => BettingViewModel(),
      onModelReady: (model) => model.setup(context),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(
            title: "Betting",
          ),
          body: Stack(
            children: [
              Form(
                key: model.formKey,
                child: Column(
                  children: [
                    BuildTextField(
                      title: "Bet Number",
                      hintText: "Bet Number",
                      controller: model.betNumber,
                      bottomSpacing: 0,
                      validator: (String? val) => val!.isEmpty
                          ? "Bet number field cannot be empty"
                          : null,
                    ),
                    model.verified
                        ? Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.yMargin(context, 1)),
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.yMargin(context, 1)),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: BrandColors.colorGreen.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.yMargin(context, .5))),
                            child: Center(
                              child: Text(
                                  'Customer Name: ${model.customerName!}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: BrandColors.colorGreen,
                                          fontSize: SizeConfig.textSize(
                                              context, 1.8))),
                            ),
                          )
                        : const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    _selectDataPlan(context, model),
                    const SizedBox(height: 30),
                    AmountTextField(
                      title: "Amount",
                      controller: model.amountController,
                      suffixTitle: Text(
                        formatMoney(model.wallet?.balance ?? "213.21"),
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
                  title: model.verified ? "Buy Now" : "Validate",
                  onPressed: () {
                    if (model.formKey.currentState!.validate()) {
                      !model.verified
                          ? model.validateBetting(context)
                          : validateTransactionDetails({
                              "Bet Number": model.betNumber.text,
                              "Provider": model.betName,
                            }, model.amountController.text, context,
                              func: () async {
                              await model.purchaseBetting(context);
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

  Widget _selectDataPlan(context, BettingViewModel model) {
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
            FocusScope.of(context).unfocus();
            if (model.check != null) {
              betDropDown(
                  ctx: context,
                  check: model.check,
                  selectPlan: (item) => model.setBettingName(item));
            }
          },
          child: Container(
            height: 60,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: const Color(0xFF605F5F).withOpacity(.1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: model.check == null
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color?>(
                                        Colors.grey[500]),
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.xMargin(context, 4)),
                              child: const Text('Loading'),
                            )
                          ],
                        )
                      : Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.xMargin(context, 2)),
                          child: Text(model.betName == null
                              ? 'Select Bet'
                              : model.betName!),
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

void betDropDown({required BuildContext ctx, check, Function? selectPlan}) {
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
                      const Text('Select Betting'),
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
                        for (String item in check)
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
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.xMargin(context, 2)),
                                    child: Text(item,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                                fontSize: SizeConfig.textSize(
                                                    context, 2))),
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
          ));
}
