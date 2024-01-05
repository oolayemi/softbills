import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:pinput/pinput.dart';

class ValidatePaymentView extends StatelessWidget {
  const ValidatePaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScaffoldWidget(
      appBar: const CustomAppBar(title: "Validate Payment"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text(
                'N200,000',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
          ),
          Text(
            'Amount',
            style: TextStyle(color: Colors.white.withOpacity(.5)),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width / 3.5,
                child: const Text(
                  "From",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Olayemi Olaomo Olamilekan",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "1424260511",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(height: 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width / 3.5,
                child: const Text(
                  "Reference",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "000000232475916382913640162835",
                      style: TextStyle(color: Colors.white),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width / 3.5,
                child: const Text(
                  "Narration",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Salary for June",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 160),
          Pinput(
            defaultPinTheme: PinTheme(
              width: 80,
              height: 80,
              textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: const Color(0xFF4D4A58),
                border: Border.all(color: const Color(0xFFE1D7C0).withOpacity(.2)),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
