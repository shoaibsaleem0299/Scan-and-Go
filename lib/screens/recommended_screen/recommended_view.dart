import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_product_card.dart';

class RecommendedView extends StatelessWidget {
  const RecommendedView({super.key});

  @override
  Widget build(BuildContext context) {
    List productData = [
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
      {
        'title': 'title',
        'imageUrl':
            "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
        'price': '123',
        'subTitle': 'subTitle',
        'status': 'status',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recommened For You",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          // mainAxisSpacing: 5,
          // childAspectRatio: 1.0,
          crossAxisCount: 2,
          children: List.generate(productData.length, (index) {
            return Center(
                child: CustomProductCard(
                    title: productData[index]['title'],
                    imageUrl: productData[index]['imageUrl'],
                    price: productData[index]['price'],
                    onTap: () {},
                    subTitle: productData[index]['subTitle'],
                    status: productData[index]['status']));
          }),
        ),
      ),
    );
  }
}
