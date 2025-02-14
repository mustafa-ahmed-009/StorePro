import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_model.dart';
import 'package:shops_manager_offline/features/billings/data/models/bill_product_model.dart';
import 'package:shops_manager_offline/features/billings/data/repo/bills_repo.dart';
import 'package:shops_manager_offline/features/products/data/models/product_model.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit() : super(BillInitial());
  final BillsRepo _repo = BillsRepo();
  List<ProductModel> billProductsList = [];
  List<BillModel> billsList = [];
  bool canIAddTheBill = true;
  String? previousBarcode;
  int? currentBillId;
  double? overAllTotal;
  // Add a new product

  Future<void> addBill({required BillModel billModel}) async {
    emit(BillLoading());
    try {
      final result = await _repo.addBill(billModel);
      result.fold(
          (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
          (billId) {
        currentBillId = billId;
        emit(BillAddingSuccess(currentBilLId: billId));
      });
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to add product: $e'));
    }
  }

  Future<void> fetchBills({required String currentDate}) async {
    emit(BillLoading());
    try {
      final result = await _repo.fetchBillsByDate(currentDate: currentDate);
      result.fold(
          (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
          (bills) {
        billsList = bills;
        emit(BillSuccess(listOfBills: bills));
      });
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to fetch bills: $e'));
    }
  }

  Future<void> detelBillAndBillProducts({required int billId , required billDate}) async {
    emit(BillLoading());
    try {
      final result = await _repo.deleteBillAndBillProduct(billId: billId);
      result.fold(
          (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
          (_) {
        fetchBills(currentDate: billDate);
      });
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to fetch bills: $e'));
    }
  }

  Future<void> fetchRecentFiveBills() async {
    emit(BillLoading());
    try {
      final result = await _repo.getRecentFiveBills();
      result.fold(
          (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
          (bills) {
        billsList = bills;
        emit(BillSuccess(listOfBills: bills));
      });
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to fetch bills: $e'));
    }
  }

  Future<void> fetchMontlyBills({required String month}) async {
    emit(BillLoading());
    try {
      final result = await _repo.fetchMonthlyBills(month: month);
      result.fold(
          (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
          (bills) {
        billsList = bills;
        emit(BillSuccess(listOfBills: bills));
      });
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to fetch bills: $e'));
    }
  }

  Future<void> fetchBillProducts({required int billId}) async {
    emit(BillLoading());
    try {
      final result = await _repo.fetchBillPrdocuts(billId: billId);
      result.fold(
          (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
          (products) {
        emit(BillProductsByIdSuccess(listOfBills: products));
      });
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to add product: $e'));
    }
  }

  Future<void> addProductModel(
      {required BillProductModel billProductModel}) async {
    emit(BillLoading());
    try {
      final result = await _repo.addBillProduct(billProductModel);
      result.fold(
        (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
        (_) => {}, // Refresh the list after adding
      );
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to add product: $e'));
    }
  }

  Future<void> fetchProductByBarcode({required String barCode}) async {
    emit(BillLoading());
    if (previousBarcode == barCode) {
      emit(BillFailure(
          errorMessage:
              'تم اضافة هذا العنصر بالفعل الي الفاتورة يرجي زيادة عدده فقط '));
      emit(BillProductFetchingSuccess(listOfProducts: billProductsList));

      return;
    }
    try {
      previousBarcode = barCode;
      final result = await _repo.fetchProductByBarcode(barcode: barCode);
      result.fold(
          (failure) => emit(BillFailure(errorMessage: failure.errMessage)),
          (productModel) {
        billProductsList.add(productModel);
        emit(BillProductFetchingSuccess(listOfProducts: billProductsList));
      } // Refresh the list after adding
          );
    } catch (e) {
      emit(BillFailure(errorMessage: 'Failed to add product: $e'));
    }
  }

  void checkIfIcanAddTheBill() {
    for (var product in billProductsList) {
      if (product.wareHouseQuantity == 0) {
        canIAddTheBill = false;
        return;
      }
    }
  }

//hlepers Functions
  double calculateBillAddingTotal() {
    return billProductsList.fold(0, (sum, product) {
      return sum + (product.billQuantity * product.customerPrice);
    });
  }

  double calculateBillTotal() {
    double total = 0;
    for (var bill in billsList) {
      total += bill.total;
    }
    return total;
  }

  void updateBillQuantity(int index, int newBillQuantity) {
    if (index >= 0 && index < billProductsList.length) {
      billProductsList[index].billQuantity = newBillQuantity;
      emit(BillProductFetchingSuccess(
          listOfProducts: List.from(billProductsList)));
    }
  }

  void emitState(BillState state) {
    emit(state);
  }
}
