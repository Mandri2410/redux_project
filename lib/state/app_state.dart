import '../models/transaction.dart';

class AppState {
  final List<Transaction> transactions;

  AppState({required this.transactions});

  AppState.initialState() : transactions = [];

  double get balance => transactions.fold(
        0,
        (sum, transaction) => transaction.type == TransactionType.income
            ? sum + transaction.amount
            : sum - transaction.amount,
      );
}
