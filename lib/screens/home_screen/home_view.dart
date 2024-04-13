import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen/widgets/heading_tile.dart';
import 'package:frontend/screens/home_screen/widgets/user_tile.dart';
import 'package:frontend/widgets/custom_category_card.dart';
import 'package:frontend/widgets/custom_product_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                            title: "Title",
                            imageUrl:
                                "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
                            onTap: () {},
                          ),
                          CustomCategoryCard(
                            title: "Title",
                            imageUrl:
                                "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
                            onTap: () {},
                          ),
                          CustomCategoryCard(
                            title: "Title",
                            imageUrl:
                                "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
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
                      goTO: () {},
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomProductCard(
                              productName: "Apple",
                              imageUrl:
                                  "https://static.wixstatic.com/media/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png/v1/fill/w_557,h_414,al_c,lg_1,q_85/6d3e87_fccea9f825fe4bb5b6f09e9ebb86aabd~mv2.png",
                              price: "212",
                              onTap: () {},
                              category: "fruit",
                              status: "availabe",
                              description: 'this is product Description',
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
