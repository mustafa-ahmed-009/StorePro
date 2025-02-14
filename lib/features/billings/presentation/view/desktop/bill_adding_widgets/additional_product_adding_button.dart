import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shops_manager_offline/features/billings/presentation/managers/cubit/bill_cubit.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AdditionalProductAddingButton extends StatelessWidget {
  const AdditionalProductAddingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BillCubit billsCubit = context.read<BillCubit>();
    return ElevatedButton(
      onPressed: () async {
        String? res = await SimpleBarcodeScanner.scanBarcode(
          context,
          barcodeAppBar: const BarcodeAppBar(
            appBarTitle: 'Test',
            centerTitle: false,
            enableBackButton: true,
            backButtonIcon: Icon(Icons.arrow_back_ios),
          ),
          isShowFlashIcon: true,
          delayMillis: 500,
          cameraFace: CameraFace.back,
          scanFormat: ScanFormat.ONLY_BARCODE,
        );
        billsCubit.fetchProductByBarcode(barCode: res!);
      },
      child: Text("اضافة عنصر اخر "),
    );
  }
}
