import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../state/app_state.dart';
import '../main.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, double>(
      converter: (store) => store.state.balance,
      builder: (context, balance) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Saldo: ${rupiahFormat.format(balance)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
