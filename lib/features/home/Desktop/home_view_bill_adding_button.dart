import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart';
import 'package:shops_manager_offline/features/billings/presentation/view/desktop/bill_adding_widgets/billings_adding_detail_view.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class HomeVIewBillAddingButton extends StatelessWidget {
  const HomeVIewBillAddingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: ElevatedButton(
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
            delayMillis: 1000,
            cameraFace: CameraFace.front,
          );
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BillingsAddingDetail(
                        receviedBarCode: res!,
                      )),
            );
          }
        },
        child: Text(
          'اضافة فاتورة جديدة',
          style: AppStyles.styleRegular20(context),
        ),
      ),
    );
  }
}
