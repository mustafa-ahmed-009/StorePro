import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shops_manager_offline/features/billings/data/models/billing_model.dart';
import 'package:shops_manager_offline/features/billings/data/repo/billings_repo.dart';

part 'billings_state.dart';

class BillingCubit extends Cubit<BillingsState> {
  BillingCubit() : super(BillingsInitial());
  final BillingRepo _repo = BillingRepo();
  List<BillingModel> billingList = [];

  // Add a new billing record
  Future<void> addBilling({required BillingModel billingModel}) async {
    emit(BillingsLoading());
    try {
      final result = await _repo.addBilling(billingModel);
      result.fold(
        (failure) => emit(BillingFailure(errorMessage: failure.errMessage)),
        (billingId) {
          emit(BillingAddingSuccess(billingId: billingId));
        },
      );
    } catch (e) {
      emit(BillingFailure(errorMessage: 'Failed to add billing: $e'));
    }
  }

  // Fetch all billing records
  Future<void> fetchBills() async {
    emit(BillingsLoading());
    try {
      final result = await _repo.fetchBills();
      result.fold(
        (failure) => emit(BillingFailure(errorMessage: failure.errMessage)),
        (bills) {
          billingList = bills;
          emit(BillingsSuccess(listOfBills: bills));
        },
      );
    } catch (e) {
      emit(BillingFailure(errorMessage: 'Failed to fetch bills: $e'));
    }
  }

  // Fetch billing records for a specific date
  Future<void> fetchBillsByDate({required String date}) async {
    emit(BillingsLoading());
    try {
      final result = await _repo.fetchBillsByDate(date: date);
      result.fold(
        (failure) => emit(BillingFailure(errorMessage: failure.errMessage)),
        (bills) {
          billingList = bills;
          emit(BillingsSuccess(listOfBills: bills));
        },
      );
    } catch (e) {
      emit(BillingFailure(errorMessage: 'Failed to fetch bills by date: $e'));
    }
  }

  // Fetch billing records for a specific month
  Future<void> fetchBillsByMonth({required String month}) async {
    emit(BillingsLoading());
    try {
      final result = await _repo.fetchBillsByMonth(month: month);
      result.fold(
        (failure) => emit(BillingFailure(errorMessage: failure.errMessage)),
        (bills) {
          billingList = bills;
          emit(BillingsSuccess(listOfBills: bills));
        },
      );
    } catch (e) {
      emit(BillingFailure(errorMessage: 'Failed to fetch bills by month: $e'));
    }
  }

  // Update a billing record
  Future<void> updateBilling({required BillingModel billingModel}) async {
    emit(BillingsLoading());
    try {
      final result = await _repo.updateBilling(billingModel);
      result.fold(
        (failure) => emit(BillingFailure(errorMessage: failure.errMessage)),
        (rowsUpdated) {
          emit(BillingUpdatingSuccess(rowsUpdated: rowsUpdated));
        },
      );
    } catch (e) {
      emit(BillingFailure(errorMessage: 'Failed to update billing: $e'));
    }
  }

  // Delete a billing record
  Future<void> deleteBilling({required int id}) async {
    emit(BillingsLoading());
    try {
      final result = await _repo.deleteBilling(id);
      result.fold(
        (failure) => emit(BillingFailure(errorMessage: failure.errMessage)),
        (rowsDeleted) {
          emit(BillingDeletingSuccess(rowsDeleted: rowsDeleted));
        },
      );
    } catch (e) {
      emit(BillingFailure(errorMessage: 'Failed to delete billing: $e'));
    }
  }
  


}