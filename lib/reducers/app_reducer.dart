import '../state/app_state.dart';
import '../actions/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is AddTransactionAction) {
    return AppState(
      transactions: List.from(state.transactions)..add(action.transaction),
    );
  } else if (action is DeleteTransactionAction) {
    return AppState(
      transactions: state.transactions
          .where((transaction) => transaction.id != action.id)
          .toList(),
    );
  }
  return state;
}
