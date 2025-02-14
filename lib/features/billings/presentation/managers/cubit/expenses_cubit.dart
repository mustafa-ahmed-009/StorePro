import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shops_manager_offline/features/billings/data/models/expenses.model.dart';
import 'package:shops_manager_offline/features/billings/data/repo/expnese_repo.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());
  final ExpensesRepo _repo = ExpensesRepo();
  List<ExpensesModel> expensesList = [];

  // Add a new expense record
  Future<void> addExpense({required ExpensesModel expenseModel}) async {
    emit(ExpensesLoading());
    try {
      final result = await _repo.addExpense(expenseModel);
      result.fold(
        (failure) => emit(ExpensesFailure(errorMessage: failure.errMessage)),
        (expenseId) {
          emit(ExpensesAddingSuccess(expenseId: expenseId));
        },
      );
    } catch (e) {
      emit(ExpensesFailure(errorMessage: 'Failed to add expense: $e'));
    }
  }

  // Fetch all expense records
  Future<void> fetchExpenses() async {
    emit(ExpensesLoading());
    try {
      final result = await _repo.fetchExpenses();
      result.fold(
        (failure) => emit(ExpensesFailure(errorMessage: failure.errMessage)),
        (expenses) {
          expensesList = expenses;
          emit(ExpensesSuccess(listOfExpenses: expenses));
        },
      );
    } catch (e) {
      emit(ExpensesFailure(errorMessage: 'Failed to fetch expenses: $e'));
    }
  }

  // Fetch expense records for a specific date
  Future<void> fetchExpensesByDate({required String date}) async {
    emit(ExpensesLoading());
    try {
      final result = await _repo.fetchExpensesByDate(date: date);
      result.fold(
        (failure) => emit(ExpensesFailure(errorMessage: failure.errMessage)),
        (expenses) {
          expensesList = expenses;
          emit(ExpensesSuccess(listOfExpenses: expenses));
        },
      );
    } catch (e) {
      emit(ExpensesFailure(errorMessage: 'Failed to fetch expenses by date: $e'));
    }
  }

  // Fetch expense records for a specific month
  Future<void> fetchExpensesByMonth({required String month}) async {
    emit(ExpensesLoading());
    try {
      final result = await _repo.fetchExpensesByMonth(month: month);
      result.fold(
        (failure) => emit(ExpensesFailure(errorMessage: failure.errMessage)),
        (expenses) {
          expensesList = expenses;
          emit(ExpensesSuccess(listOfExpenses: expenses));
        },
      );
    } catch (e) {
      emit(ExpensesFailure(errorMessage: 'Failed to fetch expenses by month: $e'));
    }
  }

  // Update an expense record
  Future<void> updateExpense({required ExpensesModel expenseModel}) async {
    emit(ExpensesLoading());
    try {
      final result = await _repo.updateExpense(expenseModel);
      result.fold(
        (failure) => emit(ExpensesFailure(errorMessage: failure.errMessage)),
        (rowsUpdated) {
          emit(ExpensesUpdatingSuccess(rowsUpdated: rowsUpdated));
        },
      );
    } catch (e) {
      emit(ExpensesFailure(errorMessage: 'Failed to update expense: $e'));
    }
  }

  // Delete an expense record
  Future<void> deleteExpense({required int id}) async {
    emit(ExpensesLoading());
    try {
      final result = await _repo.deleteExpense(id);
      result.fold(
        (failure) => emit(ExpensesFailure(errorMessage: failure.errMessage)),
        (rowsDeleted) {
          emit(ExpensesDeletingSuccess(rowsDeleted: rowsDeleted));
        },
      );
    } catch (e) {
      emit(ExpensesFailure(errorMessage: 'Failed to delete expense: $e'));
    }
  }
}