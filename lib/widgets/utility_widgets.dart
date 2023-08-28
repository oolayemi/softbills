import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto/crypto.dart';

import 'package:intl/intl.dart';
import 'package:no_name/core/services/utility_storage_service.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:pinput/pinput.dart';

import '../core/models/data_billers.dart';
import '../core/models/transaction_history_data.dart';
import '../core/models/wallet_response.dart';
import '../core/utils/size_config.dart';
import '../styles/brand_color.dart';
import 'bottom_pad.dart';
import 'transaction_history.dart';

flusher(String? message, BuildContext context,
    {int sec = 3, Color? color, String? title}) {
  return Flushbar(
    backgroundColor: color ?? BrandColors.primary,
    duration: Duration(seconds: sec),
    title: title,
    message: message,
    icon: const Icon(Icons.info_outline, size: 28.0, color: Colors.white),
    leftBarIndicatorColor: Colors.black,
  ).show(context);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch as Map<int, Color>);
}

Widget customTextField(
    {String? label,
    String? hintText,
    String? prefixImage,
    String? suffixImage,
    int? minLines,
    int? maxLines,
    TextEditingController? controller,
    bool? obscure,
    TextInputAction? action,
    TextInputType? inputType,
    Function? onChanged,
    Function? suffixFunc,
    String? errorText,
    bool? enabled,
    String? helperText,
    TextStyle? helperStyle,
    int? maxLength,
    List<String>? hints,
    required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      label == null
          ? const SizedBox()
          : Container(
              margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, .5)),
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: SizeConfig.textSize(context, 1.8)),
              ),
            ),
      Row(
        children: [
          Expanded(
            child: TextField(
              autofillHints: hints,
              enableInteractiveSelection: true,
              enabled: enabled ?? true,
              controller: controller,
              maxLines: maxLines ?? 1,
              minLines: minLines,
              obscureText: obscure ?? false,
              style: TextStyle(
                fontSize: SizeConfig.textSize(context, 2),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: inputType ?? TextInputType.text,
              onChanged: onChanged as void Function(String)?,
              maxLength: maxLength,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                hintText: hintText ?? '',
                hintStyle: TextStyle(fontSize: SizeConfig.textSize(context, 2)),
                helperText: helperText,
                helperStyle: helperStyle,
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide:
                      BorderSide(color: BrandColors.outlineText, width: 0.0),
                ),
                border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderRadius:
                        BorderRadius.circular(SizeConfig.yMargin(context, 1))),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius:
                        BorderRadius.circular(SizeConfig.yMargin(context, 1))),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BrandColors.secondary),
                    borderRadius:
                        BorderRadius.circular(SizeConfig.yMargin(context, 1))),
                errorText: errorText,
                contentPadding: EdgeInsets.symmetric(
                    vertical: SizeConfig.yMargin(context, 2),
                    horizontal: SizeConfig.xMargin(context, 4)),
                prefixIcon: prefixImage == null
                    ? null
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.xMargin(context, 4)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(prefixImage),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          suffixImage == null
              ? const SizedBox()
              : Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.xMargin(context, 1)),
                  child: InkWell(
                    enableFeedback: true,
                    // excludeFromSemantics: true,
                    borderRadius:
                        BorderRadius.circular(SizeConfig.yMargin(context, 1)),

                    onTap: suffixFunc as void Function()?,
                    child: Container(
                      height: SizeConfig.yMargin(context, 6),
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.yMargin(context, 0.5),
                          horizontal: SizeConfig.xMargin(context, 3.8)),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: BrandColors.outlineText,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.yMargin(context, 1),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            suffixImage,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    ],
  );
}

Widget customDropdown<T>(
    {String? label,
    T? value,
    List<DropdownMenuItem<T>>? items,
    Function? onChanged,
    required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      label == null
          ? const SizedBox()
          : Container(
              margin: EdgeInsets.only(bottom: SizeConfig.yMargin(context, .5)),
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: SizeConfig.textSize(context, 2)),
              ),
            ),
      Container(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.yMargin(context, 2.2),
            horizontal: SizeConfig.xMargin(context, 4)),
        decoration: BoxDecoration(
            color: const Color(0xFFB9B9B9).withOpacity(0.12),
            borderRadius:
                BorderRadius.circular(SizeConfig.yMargin(context, 1))),
        child: DropdownButton(
            // focusColor: Color(0xFFB9B9B9).withOpacity(0.12),
            dropdownColor: Colors.white,
            elevation: 0,
            underline: const SizedBox(),
            isDense: true,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: BrandColors.secondary,
            ),
            value: value,
            items: items,
            onChanged: onChanged!()),
      ),
    ],
  );
}

Widget serviceMode(
    {required BuildContext context,
    required String title,
    required bool isSelected,
    Function? onClick,
    required String icon}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 2)),
    child: InkWell(
      borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 1.4)),
      onTap: onClick as void Function()?,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.yMargin(context, 1),
            horizontal: SizeConfig.xMargin(context, 2)),
        width: SizeConfig.xMargin(context, 40),
        height: SizeConfig.yMargin(context, 10),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected ? BrandColors.mainBlack : Colors.grey[500]!),
            borderRadius:
                BorderRadius.circular(SizeConfig.yMargin(context, 1.4)),
            color: isSelected ? BrandColors.mainBlack : Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
                    child: SvgPicture.asset(
                      icon,
                      color:
                          isSelected ? BrandColors.secondary : Colors.grey[500],
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // s
          ],
        ),
      ),
    ),
  );
}

void pinPad({required BuildContext ctx, Function? function}) {
  showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(SizeConfig.yMargin(ctx, 1.5)),
        topLeft: Radius.circular(SizeConfig.yMargin(ctx, 1.5)),
      )),
      backgroundColor: Colors.white,
      context: ctx,
      builder: (context) {
        return BottomPad(
          function: (String pin) => function!(pin),
        );
      });
}

Widget walletDetailItem(
    BuildContext context, String item, String? value, bool showBorder) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 2)),
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: showBorder
                    ? const Color(0xFF8A8A8A).withOpacity(0.26)
                    : Colors.transparent))),
    child: Row(
      children: [
        Text(item,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: SizeConfig.textSize(context, 2))),
        Flexible(
          child: SelectableText(
            '$value',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: SizeConfig.textSize(context, 2)),
          ),
        ),
      ],
    ),
  );
}

class AmountTextField extends StatelessWidget {
  final String? title;
  final Widget? suffixTitle;
  final bool enabled;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const AmountTextField(
      {Key? key,
      this.title,
      this.suffixTitle,
      this.validator,
      this.controller,
      this.enabled = true,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  suffixTitle ?? const SizedBox()
                ],
              ),
        SizedBox(height: title == null ? 0 : 5),
        TextFormField(
          validator: validator,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color(0xFF605F5F).withOpacity(.1)
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class BuildTextField extends StatelessWidget {
  final bool enabled;
  final String title;
  final double bottomSpacing;
  final String? initialValue;
  final bool isLast;
  final bool obscure;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final String? Function(String?)? validator;

  const BuildTextField(
      {Key? key,
      required this.title,
      this.initialValue,
      this.onChanged,
      this.enabled = true,
      this.controller,
      this.isLast = false,
      this.obscure = false,
      this.inputFormatters,
      this.bottomSpacing = 20,
      this.textInputType = TextInputType.text,
      this.suffixIcon,
      this.hintText,
      this.maxLength,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          enabled: enabled,
          controller: controller,
          initialValue: initialValue,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          validator: validator,
          obscureText: obscure,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            counterText: '',
            hintText: hintText,
            suffixIcon: suffixIcon,
            //contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            fillColor: const Color(0xFF605F5F).withOpacity(.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: .5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            )
          ),
          onChanged: onChanged,
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        ),
        SizedBox(
          height: bottomSpacing,
        )
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool withBackButton;
  final List<Widget>? actions;

  const CustomAppBar(
      {Key? key, this.title, this.withBackButton = false, this.actions})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: BrandColors.primary,
      leading: withBackButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 32,
              ),
            )
          : null,
      actions: actions,
      title: title != null ? Text(title!) : const SizedBox(),
    );
  }
}

class CustomScaffoldWidget extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final double padding;

  const CustomScaffoldWidget(
      {Key? key, this.appBar, required this.body, this.padding = 15.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.mainBackground,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: body,
        ),
      ),
    );
  }
}

class EachTransactionSection extends StatelessWidget {
  final List<DataResponse>? transactionList;

  const EachTransactionSection({Key? key, this.transactionList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget eachTransaction(context, DataResponse dataResponse,
        {bool isLast = false}) {
      return Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TransactionHistory(dataResponse: dataResponse)),
              );
            },
            leading: const CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage("assets/images/background/unsplash.png"),
            ),
            horizontalTitleGap: 8,
            title: Text(
              dataResponse.type!,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            subtitle: Text(
              DateFormat('hh:mm a')
                  .format(DateTime.parse(dataResponse.createdAt!)),
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            trailing: Text(
              formatMoney(dataResponse.amount),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          isLast
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    height: 2,
                    color: const Color(0xFF605F5F).withOpacity(0.66),
                    thickness: 2,
                  ),
                ),
          const SizedBox(height: 10)
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF605F5F).withOpacity(.60).withOpacity(.3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: transactionList!.map((dataResponse) {
              return eachTransaction(context, dataResponse,
                  isLast: transactionList!.last == dataResponse);
            }).toList(),
          ),
        )
      ],
    );
  }
}

class ExchangeTextField extends StatelessWidget {
  const ExchangeTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF605F5F).withOpacity(.32),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            padding:
                const EdgeInsets.only(right: 6, left: 6, top: 6, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF605F5F).withOpacity(.32),
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: 'kitchen',
                    isExpanded: true,
                    dropdownColor: Colors.black87,
                    hint: const Text(
                      "Select",
                      style: TextStyle(color: Colors.white),
                    ),
                    underline: const SizedBox(),
                    items: <String>[
                      'kitchen',
                      'kitchen1',
                      'kitchen2',
                      'kitchen3'
                    ]
                        .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/images/mtn.png',
                                      height: 20, width: 20),
                                ),
                                const SizedBox(width: 4),
                                Text(e),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (data) {},
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ))
        ],
      ),
    );
  }
}

class BuildDropDown extends StatelessWidget {
  final String title;
  final String? value;
  final String? iconUrl;
  final List<dynamic> list;
  final double bottomSpacing;
  final Function(String?)? onChanged;

  const BuildDropDown({
    Key? key,
    this.value,
    required this.list,
    this.onChanged,
    required this.title,
    this.iconUrl,
    this.bottomSpacing = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.only(right: 6, left: 6, top: 6, bottom: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF605F5F).withOpacity(.1),
          ),
          child: Row(
            children: [
              iconUrl != null
                  ? Container(
                      //margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF403C3C),
                      ),
                      child: Image.asset(iconUrl!, height: 20, width: 20),
                    )
                  : const SizedBox(),
              Expanded(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  hint: Text(
                    "Select $title",
                    style: const TextStyle(color: Colors.black),
                  ),
                  underline: const SizedBox(),
                  items: list
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: bottomSpacing,
        )
      ],
    );
  }
}

class BuildBillerDropDown extends StatelessWidget {
  final String title;
  final DataBillers? value;
  final List<DataBillers> list;
  final double bottomSpacing;
  final Function(DataBillers?)? onChanged;

  const BuildBillerDropDown({
    Key? key,
    this.value,
    required this.list,
    this.onChanged,
    required this.title,
    this.bottomSpacing = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.only(right: 6, left: 6, top: 6, bottom: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF605F5F).withOpacity(.1)
          ),
          child: Row(
            children: [
              list.isNotEmpty
                  ? Expanded(
                      child: DropdownButton<DataBillers>(
                        value: value ?? DataBillers(),
                        isExpanded: true,
                        dropdownColor: Colors.black87,
                        hint: Text(
                          "Select $title",
                          style: const TextStyle(color: Colors.white),
                        ),
                        underline: const SizedBox(),
                        items: list
                            .map<DropdownMenuItem<DataBillers>>(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(e.image!,
                                          height: 20, width: 20),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(e.name!),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: onChanged,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Loading..."),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: bottomSpacing,
        )
      ],
    );
  }
}

class EachLink extends StatelessWidget {
  final IconData icon;
  final String title;
  final dynamic onTap;

  const EachLink(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF3D3D3D),
            child: Center(
              child: Icon(
                icon,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
          )
        ],
      ),
    );
  }
}

class EachRoundLink extends StatelessWidget {
  final IconData icon;
  final String title;
  final dynamic onTap;

  const EachRoundLink(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.height * .20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                icon,
                size: 25,
                color: BrandColors.secondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class SelectPaymentOption extends StatelessWidget {
  final dynamic model;
  final Function()? onSelect;

  const SelectPaymentOption({Key? key, this.model, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Wallet>? walletTypes = model.walletTypes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Payment method",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: walletTypes!.map((Wallet e) {
              return InkWell(
                onTap: () {
                  model.selectedWallet = e;
                  model.getExchange();
                  model.notifyListeners();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width:
                      (MediaQuery.of(context).size.width / walletTypes.length) -
                          20,
                  decoration: BoxDecoration(
                    color: model.selectedWallet!.walletType! == e.walletType
                        ? const Color(0xFF2D118F)
                        : null,
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Radio<Wallet>(
                          value: e,
                          activeColor: BrandColors.secondary,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          groupValue: model.selectedWallet,
                          onChanged: (value) {
                            model.selectedWallet = value;
                            model.getExchange();
                            model.notifyListeners();
                          }),
                      Text(
                        ucWord(e.walletType!),
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const RoundedButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: BrandColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.symmetric(vertical: 20)),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final int selectedPage;
  final int pageNumber;
  final double? width;
  final double? height;

  const TabButton(
      {Key? key,
      required this.selectedPage,
      required this.pageNumber,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 1000,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      padding: const EdgeInsets.all(12),
      height: height ?? 8,
      width: width ?? MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        color: selectedPage >= pageNumber
            ? Colors.white
            : const Color(0xFFE1D7C0).withOpacity(.2),
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}

void validateTransactionDetails(
  Map<String, dynamic> data,
  String amount,
  BuildContext context, {
  Function()? func,
}) {
  final List<Widget> dataEntries = [];
  Size size = MediaQuery.of(context).size;

  data.forEach((key, value) {
    dataEntries.add(Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width / 3.5,
              child: Text(
                key,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Divider(height: 2),
        ),
      ],
    ));
  });

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        color: BrandColors.mainBackground,
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 60),
          child: CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Validate Payment"),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    formatMoney(amount),
                    style: const TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
                Text(
                  'Amount',
                  style: TextStyle(color: Colors.white.withOpacity(.5)),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: dataEntries),
                ),
                const SizedBox(height: 130),
                Pinput(
                  defaultPinTheme: PinTheme(
                    width: 80,
                    height: 80,
                    textStyle: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4D4A58),
                      border: Border.all(
                          color: const Color(0xFFE1D7C0).withOpacity(.2)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  obscureText: true,
                  onCompleted: (String pin) {
                    if (StorageService().getString('transactionPin') ==
                        sha1.convert(utf8.encode(pin)).toString()) {
                      func!.call();
                    } else {
                      flusher("PIN is not correct", context, color: Colors.red);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
