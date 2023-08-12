import 'package:flutter/material.dart';
import 'package:no_name/views/all_transactions/all_transactions_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

class AllTransactionsView extends StatelessWidget {
  const AllTransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllTransactionsViewModel>.reactive(
        viewModelBuilder: () => AllTransactionsViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "See All Transaction"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // const AmountTextField(),
                  // const SizedBox(height: 30),
                  EachTransactionSection(transactionList: model.transactions,),
                ],
              ),
            ),
          );
        });
  }
}
