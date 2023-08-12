import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name/views/swap/swap_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../styles/brand_color.dart';

class SwapView extends StatelessWidget {
  const SwapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SwapViewModel>.reactive(
        viewModelBuilder: () => SwapViewModel(),
        onModelReady: (model) => model.setUp(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Currency Exchange"),
            body: Column(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: const Color(0xFF13034D),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("From"),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFF12101A),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: DropdownButton<String>(
                                      value: model.swapFromValue,
                                      isExpanded: true,
                                      dropdownColor: Colors.black87,
                                      hint: const Text(
                                        "Select",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      underline: const SizedBox(),
                                      items: <String>['NAIRA', 'DOLLAR']
                                          .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                                              value: e,
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                      // borderRadius: BorderRadius.circular(10),
                                                      child: Image.asset('assets/images/flags/${e.toLowerCase()}.png', height: 20, width: 20)),
                                                  const SizedBox(width: 4),
                                                  Text(e)
                                                ],
                                              )))
                                          .toList(),
                                        onChanged: (data) {
                                          model.swapFromValue = data!;
                                          model.notifyListeners();
                                          model.getExchange();
                                        },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 15),
                              SvgPicture.asset("assets/icons/arrow.svg", width: 50),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("To"),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white),
                                      color: const Color(0xFF13034D),
                                    ),
                                    child: DropdownButton<String>(
                                      value: model.swapToValue,
                                      isExpanded: true,
                                      dropdownColor: Colors.black87,
                                      hint: const Text(
                                        "Select",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      underline: const SizedBox(),
                                      items: <String>['NAIRA']
                                          .map<DropdownMenuItem<String>>(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.asset('assets/images/flags/${e.toLowerCase()}.png', height: 20, width: 20),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(e),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: null,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: BrandColors.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(model.buildText ?? ""),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: model.formKey,
                  child: AmountTextField(
                    title: "Enter Amount",
                    controller: model.amountController,
                    onChanged: (_) => model.getExchange(),
                    validator: (value) => value!.isEmpty ? "Amount field cannot be empty" : null,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(model.exchangeText ?? ""),
                  ],
                ),
                const SizedBox(height: 10),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Expanded(
                        child: RoundedButton(
                      title: "Confirm",
                      onPressed: () {
                        if (model.formKey.currentState!.validate()){
                          model.exchangeCurrency(context);
                        }
                      },
                    )),
                  ],
                )
              ],
            ),
          );
        });
  }
}
