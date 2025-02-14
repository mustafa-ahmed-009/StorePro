part of 'billings_cubit.dart';

@immutable
sealed class BillingsState {}

final class BillingsInitial extends BillingsState {}
final class BillingsLoading extends BillingsState {

}
final class BillingsSuccess extends BillingsState {
  final List<BillingModel> listOfBills;
  BillingsSuccess({required this.listOfBills});
}
class BillingAddingSuccess extends BillingsState {
  final int billingId;
  BillingAddingSuccess({required this.billingId});
}

class BillingUpdatingSuccess extends BillingsState {
  final int rowsUpdated;
  BillingUpdatingSuccess({required this.rowsUpdated});
}

class BillingDeletingSuccess extends BillingsState {
  final int rowsDeleted;
  BillingDeletingSuccess({required this.rowsDeleted});
}

class BillingFailure extends BillingsState {
  final String errorMessage;
  BillingFailure({required this.errorMessage});
}