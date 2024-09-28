import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../state/app_state.dart';
import '../models/transaction.dart';
import '../actions/actions.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({Key? key}) : super(key: key);

  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  double _amount = 0;
  TransactionType _type = TransactionType.expense;
  String _category = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Transaksi'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              validator: (value) =>
                  value!.isEmpty ? 'Mohon masukkan deskripsi' : null,
              onSaved: (value) => _description = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'Mohon masukkan jumlah' : null,
              onSaved: (value) => _amount = double.parse(value!),
            ),
            DropdownButtonFormField<TransactionType>(
              value: _type,
              items: TransactionType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type == TransactionType.income
                            ? 'Pemasukan'
                            : 'Pengeluaran'),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _type = value!),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Kategori'),
              validator: (value) =>
                  value!.isEmpty ? 'Mohon masukkan kategori' : null,
              onSaved: (value) => _category = value!,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () => _submitForm(context),
          child: const Text('Tambah'),
        ),
      ],
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final transaction = Transaction(
        id: DateTime.now().toString(),
        description: _description,
        amount: _amount,
        type: _type,
        category: _category,
      );
      StoreProvider.of<AppState>(context)
          .dispatch(AddTransactionAction(transaction));
      Navigator.pop(context);
    }
  }
}
