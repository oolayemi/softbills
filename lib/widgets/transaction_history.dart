import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:no_name/core/utils/tools.dart';
import 'package:no_name/widgets/utility_widgets.dart';

import '../core/models/transaction_history_data.dart';

class TransactionHistory extends StatelessWidget {
  final DataResponse dataResponse;
  const TransactionHistory({Key? key, required this.dataResponse}) : super(key: key);

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
            dataResponse.transactionType == 'credit' ? "Credit" : "Debit",
            style: TextStyle(color: Colors.white.withOpacity(.5), fontSize: 15),
          )),
          Text(
            formatMoney(dataResponse.amount!, walletType: dataResponse.walletSource ?? 'naira'),
            style: const TextStyle(color: Colors.white, fontSize: 28),
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
                  "Date",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd MMMM, yyyy').format(DateTime.parse(dataResponse.createdAt!)),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
    DateFormat('kk:mm a').format(DateTime.parse(dataResponse.createdAt!)),
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
                  "Service",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dataResponse.type!,
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
                  "Prev Balance",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatMoney(dataResponse.prevBalance, walletType: dataResponse.walletSource ?? 'naira'),
                      style: const TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatMoney(dataResponse.newBalance, walletType: dataResponse.walletSource ?? 'naira'),
                      style: const TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dataResponse.reference!,
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dataResponse.narration!,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white),
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
