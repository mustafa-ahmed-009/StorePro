part of 'bill_cubit.dart';
@immutable
sealed class BillState {}

final class BillInitial extends BillState {}

final class BillLoading extends BillState {}
final class BillAddingStateChanged extends BillState {
  final bool canIAddTheBill;

  BillAddingStateChanged({required this.canIAddTheBill});

}

final class BillSuccess extends BillState {
  final List<BillModel> listOfBills;

  BillSuccess({required this.listOfBills});
}
final class BillProductsByIdSuccess extends BillState {
  final List<BillProductModel> listOfBills;

  BillProductsByIdSuccess({required this.listOfBills});
}
final class BillProductFetchingSuccess extends BillState {
  final List<ProductModel> listOfProducts;

  BillProductFetchingSuccess({required this.listOfProducts});
}
final class BillAddingSuccess extends BillState {
final int currentBilLId;
  BillAddingSuccess({required this.currentBilLId});
}


final class BillFailure extends BillState {
  final String errorMessage;

  BillFailure({required this.errorMessage});
}