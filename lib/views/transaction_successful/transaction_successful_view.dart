import 'package:flutter/material.dart';
import 'package:no_name/widgets/utility_widgets.dart';

class TransactionSuccessfulView extends StatelessWidget {
  final Widget bottomWidgets;

  const TransactionSuccessfulView({Key? key, this.bottomWidgets = const SizedBox()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/transaction_successful.png"),
                  const SizedBox(height: 15),
                  const Text("Transaction Successful", style: TextStyle(fontSize: 22),)
                ],
              ),
            ),
          ),
          Expanded(flex: 2, child: bottomWidgets),
          SizedBox(
            width: double.infinity,
            child: RoundedButton(
              title: "Go Home",
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
