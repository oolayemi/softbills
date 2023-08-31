import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/widgets/utility_widgets.dart';

import '../core/models/transaction_history_data.dart';

class TransactionHistory extends StatelessWidget {
  final DataResponse? dataResponse;

  const TransactionHistory({Key? key, this.dataResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScaffoldWidget(
      appBar: const CustomAppBar(title: "Back"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Text(
            dataResponse?.transactionType == 'credit' ? "Credit" : "Debit",
            style: const TextStyle(fontSize: 15),
          )),
          Text(
            formatMoney(dataResponse?.amount ?? "123.32"),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const Text(
            'Amount',
            style: TextStyle(),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width / 3.5,
                child: const Text(
                  "Date",
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd MMMM, yyyy').format(DateTime.parse(
                          dataResponse?.createdAt ?? "2023-08-12")),
                      style: const TextStyle(),
                    ),
                    Text(
                      DateFormat('kk:mm a').format(DateTime.parse(
                          dataResponse?.createdAt ?? "2023-08-12")),
                      style: const TextStyle(),
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
                  "Service",
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dataResponse?.type ?? "credit",
                      style: const TextStyle(),
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
                  "Prev Balance",
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatMoney(dataResponse?.prevBalance ?? "123.22"),
                      style: const TextStyle(),
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
                  "New Balance",
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatMoney(dataResponse?.newBalance ?? "213.22"),
                      style: const TextStyle(),
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
                  "Reference",
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dataResponse?.reference ?? "89dftys89",
                      style: const TextStyle(),
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
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dataResponse?.narration ?? "dlkjfsd8f9sd89b iud89sbdyds",
                      textAlign: TextAlign.end,
                      style: const TextStyle(),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
