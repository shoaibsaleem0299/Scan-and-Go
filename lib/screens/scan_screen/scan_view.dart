import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/widgets/app_button.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  String? _scanBarcodeResult;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'cancel',
        false,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version";
    }
    if (!mounted) return;
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text("Scan to Shop"),
      ),
      body: SafeArea(
        child: Center(
          widthFactor: MediaQuery.of(context).size.width * 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Place barcode inside the frame to scan.",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "It will automatically scan.",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.secondryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                            buttonText: "Tap to Scan",
                            onButtonTap: scanBarcodeNormal),
                        Text("Barcode value : $_scanBarcodeResult"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text("Powered by ScanGO"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
