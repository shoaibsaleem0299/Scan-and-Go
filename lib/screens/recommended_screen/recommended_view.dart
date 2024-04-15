// import 'package:flutter/material.dart';
// import 'package:frontend/data/product_data.dart';
// import 'package:frontend/widgets/custom_product_card.dart';

// class RecommendedView extends StatelessWidget {
//   const RecommendedView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Recommended For You"),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: GridView(
//               padding: const EdgeInsets.all(6.0),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 // mainAxisSpacing: 4,
//                 crossAxisSpacing: 10,
//               ),
//               children: [
//                 CustomProductCard(
//                   productName: "Apple",
//                   imageUrl:
//                       "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
//                   price: "212",
//                   onTap: () {},
//                   category: "fruit",
//                   status: "availabe",
//                   description: 'this is product Description',
//                 ),
//                 CustomProductCard(
//                   productName: "Apple",
//                   imageUrl:
//                       "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
//                   price: "212",
//                   onTap: () {},
//                   category: "fruit",
//                   status: "availabe",
//                   description: 'this is product Description',
//                 ),
//                 CustomProductCard(
//                   productName: "Apple",
//                   imageUrl:
//                       "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
//                   price: "212",
//                   onTap: () {},
//                   category: "fruit",
//                   status: "availabe",
//                   description: 'this is product Description',
//                 ),
//                 CustomProductCard(
//                   productName: "Apple",
//                   imageUrl:
//                       "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
//                   price: "212",
//                   onTap: () {},
//                   category: "fruit",
//                   status: "availabe",
//                   description: 'this is product Description',
//                 ),
//                 const Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/widgets/custom_product_card.dart';

class RecommendedView extends StatefulWidget {
  const RecommendedView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecommendedViewState createState() => _RecommendedViewState();
}

class _RecommendedViewState extends State<RecommendedView> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2/api/all_products_data.php'));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return List<Product>.from(list.map((model) => Product.fromJson(model)));
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended For You"),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<Product>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> products = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(6.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return CustomProductCard(
                        productName: products[index].productName,
                        imageUrl: products[index].imageUrl,
                        price: products[index].price,
                        onTap: () {},
                        category: products[index].category,
                        status: products[index].status,
                        description: products[index].description,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class Product {
  final String productName;
  final String imageUrl;
  final String price;
  final String category;
  final String status;
  final String description;

  Product({
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.status,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      category: json['category'],
      status: json['status'],
      description: json['description'],
    );
  }
}
