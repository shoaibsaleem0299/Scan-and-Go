import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/home_screen/widgets/offer_card.dart';
import 'package:frontend/screens/home_screen/widgets/user_tile.dart';
import 'package:frontend/widgets/custom_category_card.dart';
import 'package:frontend/widgets/custom_product_card.dart';
// import 'package:frontend/widgets/custom_user_inputfield.dart';

class HomeVeiw extends StatefulWidget {
  const HomeVeiw({super.key});

  @override
  State<HomeVeiw> createState() => _HomeVeiwState();
}

class _HomeVeiwState extends State<HomeVeiw> {
  List productData = [
    {
      'title': 'title',
      'imageUrl': 'imageUrl',
      'price': '123',
      'subTitle': 'subTitle',
      'status': 'status',
    },
    {
      'title': 'title',
      'imageUrl': 'imageUrl',
      'price': '123',
      'subTitle': 'subTitle',
      'status': 'status',
    },
    {
      'title': 'title',
      'imageUrl': 'imageUrl',
      'price': '123',
      'subTitle': 'subTitle',
      'status': 'status',
    },
  ];
  List productCategoryData = [
    {
      'title': "Apple",
      'imageUrl':
          "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
    },
    {
      'title': "Apple",
      'imageUrl':
          "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
    },
    {
      'title': "Apple",
      'imageUrl':
          "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              const UserTile(
                name: "User Name",
                imageUrl: "",
              ),
              const SizedBox(
                height: 16.0,
              ),
              ListTile(
                leading: const Text(
                  "Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All",
                    style: TextStyle(fontSize: 16, color: AppColor.primary),
                  ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     CustomCategoryCard(
              //       title: "Apple",
              //      onTap: () {},
              //     ),
              //     Cu imageUrl:
              //           "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
              //       stomCategoryCard(
              //       title: "Apple",
              //       imageUrl:
              //           "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
              //       onTap: () {},
              //     ),
              //     CustomCategoryCard(
              //       title: "Apple",
              //       imageUrl:
              //           "https://www.fruitsmith.com/pub/media/catalog/product/cache/3d1197b96d84cacc4f40a78b1d94d82b/g/a/gala-apple-2_1.png",
              //       onTap: () {},
              //     ),
              //   ],
              // ),
              // GridView.count(
              //   crossAxisSpacing: 5,
              //   scrollDirection: Axis.horizontal,
              //   crossAxisCount: 3,
              //   children: List.generate(productCategoryData.length, (index) {
              //     return Center(
              //         child: CustomCategoryCard(
              //       title: productCategoryData[index]['title'],
              //       imageUrl: productCategoryData[index]['imageUrl'],
              //       onTap: () {},
              //     ));
              //   }),
              // ),
              ListTile(
                leading: const Text(
                  "Today's Offers",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 2, 180, 70)),
                  ),
                ),
              ),
              OfferCard(
                title: "50%",
                imageUrl:
                    "https://www.theproducemoms.com/wp-content/uploads/2022/02/Broccoli-Rabe.png",
                onTap: () {},
                subTitle: "Limited Offer",
              ),
              const ListTile(
                title: Text(
                  "Recommended For You",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 16, right: 16),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomProductCard(
                        title: "title",
                        imageUrl: "imageUrl",
                        price: "price",
                        onTap: () {},
                        subTitle: "subTitle",
                        status: "status"),
                    CustomProductCard(
                        title: "title",
                        imageUrl: "imageUrl",
                        price: "price",
                        onTap: () {},
                        subTitle: "subTitle",
                        status: "status"),
                    CustomProductCard(
                        title: "title",
                        imageUrl: "imageUrl",
                        price: "price",
                        onTap: () {},
                        subTitle: "subTitle",
                        status: "status"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
