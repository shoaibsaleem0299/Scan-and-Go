import 'package:flutter/material.dart';
import 'package:frontend/data/product_data.dart';
import 'package:frontend/screens/home_screen/widgets/heading_tile.dart';
import 'package:frontend/screens/home_screen/widgets/user_tile.dart';
import 'package:frontend/screens/product_screen/product_view.dart';
import 'package:frontend/screens/recommended_screen/recommend_products.dart';
import 'package:frontend/widgets/custom_category_card.dart';
import 'package:frontend/widgets/custom_product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> favorites = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const UserTile(
                  name: "shoaib saleem",
                  imageUrl:
                      "https://avatars.githubusercontent.com/u/144604674?v=4"),
              Expanded(
                child: Column(
                  children: [
                    HeadingTile(
                      title: "Categories",
                      goTO: () {},
                    ),
                    Expanded(
                      child: GridView(
                        padding: const EdgeInsets.all(6.0),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                        ),
                        children: [
                          CustomCategoryCard(
                            title: "Fruits",
                            imageUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXOEIot18RKqc7oCqQPbiia4R7PLLziscAF7cKR6E8Cw&s",
                            onTap: () {},
                          ),
                          CustomCategoryCard(
                            title: "Vegetables",
                            imageUrl:
                                "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
                            onTap: () {},
                          ),
                          CustomCategoryCard(
                            title: "Meat",
                            imageUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ1c6KQSQMdqTsMSpDAZ5J3aEwJEektwdT1DI2NL7CpA&s",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    HeadingTile(
                      title: "Today's Offer",
                      goTO: () {},
                    ),
                    Expanded(
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdhgFhMqJvOIrYVgqUtkPCtXkcElwha0F_cN-DGbN7_g&s",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    HeadingTile(
                      title: "Recommended For You",
                      goTO: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RecommendedProducts()));
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Products.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomProductCard(
                              productName: Products[index]['name'],
                              imageUrl: Products[index]['image'],
                              price: Products[index]['price'],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductView(
                                              name: Products[index]['name'],
                                              category: Products[index]
                                                  ['category'],
                                              price: Products[index]['price'],
                                              description: Products[index]
                                                  ['description'],
                                              location: Products[index]
                                                  ['location'],
                                              status: Products[index]['status'],
                                              imageUrl: Products[index]
                                                  ['image'],
                                            )));
                              },
                              category: Products[index]['category'],
                              status: Products[index]['status'],
                              description: Products[index]['description'],
                              onAddToFavorites: (Product) {
                                setState(() {
                                  favorites.add(Product);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
