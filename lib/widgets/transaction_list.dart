import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../state/app_state.dart';
import '../models/transaction.dart';
import '../actions/actions.dart';
import '../main.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Transaction>>(
      converter: (store) => store.state.transactions,
      builder: (context, transactions) {
        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Dismissible(
              key: Key(transaction.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                StoreProvider.of<AppState>(context)
                    .dispatch(DeleteTransactionAction(transaction.id));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaksi dihapus')),
                );
              },
              child: ListTile(
                title: Text(transaction.description),
                subtitle: Text(transaction.category),
                trailing: Text(
                  '${transaction.type == TransactionType.income ? '+' : '-'}${rupiahFormat.format(transaction.amount)}',
                  style: TextStyle(
                    color: transaction.type == TransactionType.income
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                leading: Icon(
                  transaction.type == TransactionType.income
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: transaction.type == TransactionType.income
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
