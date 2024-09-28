import '../models/transaction.dart';

class AddTransactionAction {
  final Transaction transaction;
  AddTransactionAction(this.transaction);
}

class DeleteTransactionAction {
  final String id;
  DeleteTransactionAction(this.id);
}
