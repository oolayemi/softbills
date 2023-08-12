import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_name/core/enums/wallet_types.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/views/cabletv/cable_tv_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/models/cable_tv_data.dart';
import '../../core/utils/size_config.dart';

class CableTvView extends StatelessWidget {
  const CableTvView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CableTvViewModel>.reactive(
        viewModelBuilder: () => CableTvViewModel(),
        onModelReady: (model) => model.setup(context),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(
              title: "Cable TV",
            ),
            body: Stack(
              children: [
                Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      BuildTextField(
                        title: "SmartCard IUC Number",
                        hintText: "Enter SmartCard IUC Number",
                        bottomSpacing: 0,
                        controller: model.iucNumberController,
                        textInputType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (String? val) => val!.isEmpty ? "IUC number field cannot be empty" : null,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: model.customerName != null
                              ? Text(model.customerName!)
                              : const SizedBox(height: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _selectCablePlan(context, model),
                      const SizedBox(height: 30),
                      _selectCablePackagePlan(context, model),
                      const SizedBox(height: 30),
                      AmountTextField(
                        title: "Amount",
                        controller: model.amountController,
                        enabled: false,
                        suffixTitle: Text(
                          formatMoney(
                            model.selectedWallet!.balance!,
                            walletType: model.selectedWallet!.walletType!,
                          ),
                        ),
                        onChanged: (string) {
                          model.getExchange();
                        },
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(model.buildText ?? ""),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SelectPaymentOption(model: model)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  child: RoundedButton(
                    title: model.verified ? "Buy now" : "Validate",
                    onPressed: () {
                      if (model.formKey.currentState!.validate()) {
                        if (model.package != null) {
                          !model.verified ? model.validateProvider(context) : validateTransactionDetails({
                            "IUC Number": model.iucNumberController.text,
                            "Provider": model.biller!.name,
                            "Package": model.package!.name,
                            'Payment Method': model.selectedWallet!.walletType
                          }, model.amountController.text, context, func: () async {
                            await model.purchasePackage(context);
                          });
                        } else {
                          flusher("Please select a package to continue", context, color: Colors.red);
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _selectCablePlan(context, CableTvViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select CableTV Provider",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (model.cableBillers!.isNotEmpty) {
              FocusScope.of(context).unfocus();
              billerSelection(
                  ctx: context, billers: model.cableBillers, selectPlan: (CableBillers biller) => model.setBiller(biller, context));
            }
          },
          child: Container(
              height: 60,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFF605F5F).withOpacity(.32), borderRadius: BorderRadius.circular(10), border: Border.all()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: model.cableBillers!.isNotEmpty
                        ? Row(
                            children: [
                              model.biller == null
                                  ? const SizedBox()
                                  : CachedNetworkImage(
                                      imageUrl: model.biller!.image!,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          LinearProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                      width: SizeConfig.xMargin(context, 10),
                                    ),
                              Container(
                                margin: EdgeInsets.only(left: SizeConfig.xMargin(context, 2)),
                                child: Text(model.biller == null ? 'Select Biller' : model.biller!.name!),
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
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[500],
                  )
                ],
              )),
        )
      ],
    );
  }

  Widget _selectCablePackagePlan(context, CableTvViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Package",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (model.cableBillers!.isNotEmpty) {
              FocusScope.of(context).unfocus();
              packageSelection(
                ctx: context,
                packages: model.cablePackages[model.biller!.name],
                selectPlan: (CableTvPackage item) => model.setPackage(item),
              );
            }
          },
          child: Container(
            height: 60,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: const Color(0xFF605F5F).withOpacity(.32), borderRadius: BorderRadius.circular(10), border: Border.all()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: model.biller == null || model.cablePackages[model.biller!.name] == null
                      ? Container(
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
                        )
                      : Text(model.package == null ? 'Select Package' : model.package!.name!),
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

  void billerSelection({required BuildContext ctx, List<CableBillers>? billers, Function? selectPlan}) {
    showModalBottomSheet(
        enableDrag: false,
        context: ctx,
        isDismissible: true,
        backgroundColor: BrandColors.mainBackground,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(SizeConfig.yMargin(ctx, 3)),
          topLeft: Radius.circular(SizeConfig.yMargin(ctx, 3)),
        )),
        builder: (context) => Container(
              padding: EdgeInsets.only(top: SizeConfig.yMargin(context, 2)),
              height: SizeConfig.yMargin(context, 40),
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
                  Column(
                    children: [
                      for (CableBillers item in billers!)
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
                                CachedNetworkImage(
                                  imageUrl: item.image!,
                                  width: SizeConfig.xMargin(context, 10),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: SizeConfig.xMargin(context, 2)),
                                  child: Text('${item.name}',
                                      style:
                                          Theme.of(context).textTheme.headline3!.copyWith(fontSize: SizeConfig.textSize(context, 2))),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ));
  }

  void packageSelection({required BuildContext ctx, List<CableTvPackage>? packages, Function? selectPlan}) {
    showModalBottomSheet(
        enableDrag: false,
        context: ctx,
        isDismissible: true,
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
                        const Text('Select Package'),
                        IconButton(onPressed: () => Navigator.of(ctx).pop(), icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (CableTvPackage item in packages!)
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
                                child: Text('${item.name} - ${formatMoney(item.amount)}',
                                    style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: SizeConfig.textSize(context, 2))),
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
}
