import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:no_name/views/transactions/transaction_viewmodel.dart';
import 'package:no_name/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/transaction_history_data.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionViewModel>.reactive(
        viewModelBuilder: () => TransactionViewModel(),
        onViewModelReady: (model) => model.setUp(),
        builder: (context, model, _) {
          return CustomScaffoldWidget(
            appBar: const CustomAppBar(title: "Transactions"),
            body: model.transactions.isNotEmpty
                ? ListView.separated(
                    itemCount: model.groupedRecords.keys.length,
                    separatorBuilder: (context, index) => const Divider(height: 20),
                    itemBuilder: (context, index) {
                      String date = model.groupedRecords.keys.elementAt(index);
                      List<DataResponse> dailyTransactions = model.groupedRecords[date]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            parseDate(DateTime.parse(date)),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...dailyTransactions.map((e) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.3),
                                        blurRadius: 70.0,
                                        spreadRadius: .9,
                                        offset: const Offset(
                                          0.4,
                                          12.4,
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                          ),
                                          child: e.imageUrl != null ? Image.network(e.imageUrl!) : const SizedBox(),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ucWord(e.serviceType!),
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                            ),
                                            Text(
                                              DateFormat('hh:mm a').format(DateTime.parse(e.createdAt!)),
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                              e.transactionType == "credit"
                                                  ? "assets/svg/inward.svg"
                                                  : "assets/svg/outward.svg",
                                              color: e.transactionType == "credit"
                                                  ? BrandColors.primary
                                                  : BrandColors.secondary),
                                          Text(
                                            formatMoney(e.amount),
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w900,
                                                color: e.transactionType == "credit"
                                                    ? BrandColors.primary
                                                    : BrandColors.secondary),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            );
                          }),
                        ],
                      );
                    })
                : const Center(
                    child: Text("There are no transactions yet"),
                  ),
          );
        });
  }
}
