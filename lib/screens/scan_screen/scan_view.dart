import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/constants/app_urls.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/screens/login_screen/login.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/product_screen/cart_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  String barcodeValue = '';
  String apiResponse = '';
  static const String tokenKey = "token";
  // ignore: prefer_typing_uninitialized_variables
  var responseBody;

  @override
  void initState() {
    super.initState();
    scanBarcode();
  }

  Future<String?> userToken() async {
    var sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(tokenKey);
  }

  Future<void> scanBarcode() async {
    try {
      String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      if (!mounted) return;

      if (barcodeScanResult == '-1') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NavigationView()));
      } else {
        setState(() {
          barcodeValue = barcodeScanResult;
        });
      }
    } catch (e) {
      setState(() {
        barcodeValue = 'Failed to get barcode.';
      });
    }
  }

  Future<ProductModel?> fetchApiData(String barcode) async {
    String? token = await userToken();
    final url = '${AppURL.BaseURL}/api/product/barcode/$barcode';
    final dio = Dio();
    if (token != null) {
      try {
        final response = await dio.get(
          url,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
        );
        responseBody = response.data;

        if (response.statusCode == 200) {
          return ProductModel.fromJson(responseBody);
        } else {
          setState(() {
            apiResponse = 'Product not found';
          });
        }
      } catch (e) {
        setState(() {
          apiResponse = "No Product Found -> $barcodeValue";
        });
      }
    } else {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Unauthorized Access'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return null;
  }

  Future<void> addToCart(int id, int quantity) async {
    String? token = await userToken();
    final url = "${AppURL.BaseURL}/api/cart/add_to_cart";
    final dio = Dio();

    try {
      await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode({
          'product_id': id,
          'quantity': quantity,
        }),
      );
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text(
          "Scan to Shop",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: barcodeValue.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<ProductModel?>(
                future: fetchApiData(barcodeValue),
                builder: (context, snapshot) {
                  // ignore: unrelated_type_equality_checks
                  if (snapshot.connectionState == ConnectionState.values) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Text(apiResponse.isEmpty
                          ? 'Product not found'
                          : apiResponse),
                    );
                  } else {
                    final product = snapshot.data!;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartProductView(
                            productId: product.data!.id!,
                            name: product.data!.name ?? "Product",
                            category: product.data!.name ?? "Category",
                            description:
                                product.data!.description ?? "Description",
                            imageUrl: product.data!.featureImage ?? "Category",
                            initialPrice: product.data!.salePrice ?? "0.0",
                            initialQuantity: 1,
                            location: product.data!.updatedAt ?? "Unknown",
                            status: product.data!.stockQuantity ?? 0,
                            onAddToCart: (productData) {
                              addToCart(productData['productId'],
                                  productData['quantity']);
                            },
                          ),
                        ),
                      );
                    });
                    return const SizedBox();
                  }
                },
              ),
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:frontend/constants/app_colors.dart';
// import 'package:frontend/widgets/app_button.dart';

// class ScanView extends StatefulWidget {
//   const ScanView({super.key});

//   @override
//   State<ScanView> createState() => _ScanViewState();
// }

// class _ScanViewState extends State<ScanView> {
//   String? _scanBarcodeResult;

//   @override
//   void initState() {
//     super.initState();
//     scanBarcodeNormal();
//   }

//   Future<void> scanBarcodeNormal() async {
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'cancel',
//         false,
//         ScanMode.BARCODE,
//       );
//       debugPrint(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = "Failed to get platform version";
//     }
//     if (!mounted) return;
//     setState(() {
//       _scanBarcodeResult = barcodeScanRes;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.primary,
//         centerTitle: true,
//         title: const Text("Scan to Shop"),
//       ),
//       body: SafeArea(
//         child: Center(
//           widthFactor: MediaQuery.of(context).size.width * 1,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Place barcode inside the frame to scan.",
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),
//                       ),
//                       Text(
//                         "It will automatically scan.",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColor.secondryTextColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: SizedBox(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AppButton(
//                             buttonText: "Tap to Scan",
//                             onButtonTap: scanBarcodeNormal),
//                         Text("Barcode value : $_scanBarcodeResult"),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: const Text("Powered by ScanGO"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
