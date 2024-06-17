import 'package:flutter/material.dart';
import 'package:no_name/views/all_transactions/all_transactions_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

class AllTransactionsView extends StatelessWidget {
  const AllTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllTransactionsViewModel>.reactive(
        viewModelBuilder: () => AllTransactionsViewModel(),
        builder: (context, model, child) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "See All Transaction"),
            body: model.transactions!.isNotEmpty ? SingleChildScrollView(
              child: Column(
                children: [
                  RecentTransactionSection(transactionList: model.transactions,),
                ],
              ),
            ) : const Center(child: Text("There are no transactions yet"),),
          );
        });
  }
}
