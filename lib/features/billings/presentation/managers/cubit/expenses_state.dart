part of 'expenses_cubit.dart';

@immutable
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesSuccess extends ExpensesState {
  final List<ExpensesModel> listOfExpenses;
  ExpensesSuccess({required this.listOfExpenses});
}

class ExpensesAddingSuccess extends ExpensesState {
  final int expenseId;
  ExpensesAddingSuccess({required this.expenseId});
}

class ExpensesUpdatingSuccess extends ExpensesState {
  final int rowsUpdated;
  ExpensesUpdatingSuccess({required this.rowsUpdated});
}

class ExpensesDeletingSuccess extends ExpensesState {
  final int rowsDeleted;
  ExpensesDeletingSuccess({required this.rowsDeleted});
}

class ExpensesFailure extends ExpensesState {
  final String errorMessage;
  ExpensesFailure({required this.errorMessage});
}