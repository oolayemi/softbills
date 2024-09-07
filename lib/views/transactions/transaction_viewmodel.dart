import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../core/models/transaction_history_data.dart';
import '../../core/services/auth_service.dart';

class TransactionViewModel extends ReactiveViewModel {
  final AuthService _authService = locator<AuthService>();

  List<DataResponse> get transactions => _authService.walletTransactions ?? [];
  Map<String, List<DataResponse>> groupedRecords = {};

  Future<void> setUp() async {
    if (transactions.isEmpty){
      await _authService.getWalletTransactions(page: 1);
    }
    groupedRecords = groupByDay(transactions);
    notifyListeners();
  }

  Map<String, List<DataResponse>> groupByDay(List<DataResponse> records) {
    final Map<String, List<DataResponse>> groupedRecords = {};

    for (var record in records) {
      final createdAt = DateTime.parse(record.createdAt!);
      final day = DateFormat('yyyy-MM-dd').format(createdAt);
      if (groupedRecords.containsKey(day)) {
        groupedRecords[day]!.add(record);
      } else {
        groupedRecords[day] = [record];
      }
    }
    return groupedRecords;
  }
}
