import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'fund_ussd_viewmodel.dart';

class FundUssdView extends StatelessWidget {
  const FundUssdView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FundUssdViewModel>.reactive(
        viewModelBuilder: () => FundUssdViewModel(),
        builder: (context, model, _) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Fund (USSD)"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Use the details below to send money to your Softbills Account",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  const SizedBox(height: 30),
                  eachContainer("Amount", "N1000"),
                  const SizedBox(height: 25),
                  eachContainer("Zenith Bank", "*966*1000*0123456789#", image: "assets/svg/banks/zenith_logo.png"),
                  const SizedBox(height: 25),
                  eachContainer("GtBank", "*737*50*1000*416#", image: "assets/svg/banks/gtb_logo.png"),
                  const SizedBox(height: 25),
                  eachContainer("Access Bank", "*901*1000*0123456789#", image: "assets/svg/banks/access_logo.png"),
                  const SizedBox(height: 25),
                  eachContainer("Wema Bank", "*945*0123456789*1000#", image: "assets/svg/banks/wema_logo.png"),
                ],
              ),
            ),
          );
        });
  }

  Widget eachContainer(String name, String value, {String? image, bool shouldCopy = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            image == null ? const SizedBox() : Row(
              children: [
                Image.asset(image, height: 20, width: 20),
                const SizedBox(width: 10)
              ],
            ),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
            color: const Color(0xFFA4A9AE).withOpacity(.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 18)),
              shouldCopy == true ? InkWell(
                onTap: (){},
                  child: const Icon(Icons.copy_all)) : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
