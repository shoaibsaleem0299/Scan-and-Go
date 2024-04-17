import 'package:flutter/material.dart';
import 'package:frontend/data/product_data.dart';
import 'package:frontend/widgets/custom_product_card.dart';

class RecommendedProducts extends StatefulWidget {
  const RecommendedProducts({super.key});

  @override
  State<RecommendedProducts> createState() => _RecommendedProductsState();
}

class _RecommendedProductsState extends State<RecommendedProducts> {
  List<Product> favorites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommended For You"),
      ),
      body: SafeArea(
        child: GridView.builder(
            itemCount: Products.length,
            padding: const EdgeInsets.all(12.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              return CustomProductCard(
                productName: Products[index]['name'],
                imageUrl: Products[index]['image'],
                price: Products[index]['price'],
                onTap: () {},
                category: Products[index]['category'],
                status: Products[index]['status'],
                description: Products[index]['description'],
                onAddToFavorites: (Product) {
                  setState(() {
                    favorites.add(Product);
                  });
                },
              );
            }),
      ),
    );
  }
}
