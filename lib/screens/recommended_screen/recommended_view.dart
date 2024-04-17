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
  getProducts() async {
    try {
      var url = Uri.parse("http://192.168.100.2/api/all_products_data.php");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        const Center(child: Text("No Items Found"));
      }
    } catch (e) {
      const Center(child: Text("No Items Found"));
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
          child: FutureBuilder(
            future: getProducts(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomProductCard(
                      productName: snapshot.data[index]['name'],
                      category: snapshot.data[index]['category'],
                      price: snapshot.data[index]['price'],
                      imageUrl: snapshot.data[index]['imageUrl'],
                      status: snapshot.data[index]['status'],
                      onTap: () {},
                      description: snapshot.data[index]['description'],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
