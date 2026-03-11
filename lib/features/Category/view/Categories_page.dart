import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/home/view/home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int currentIndex = 0;
  bool isGrid = true;

  final List<String> banners = [
    "assets/images/banner_01.jpg",
    "assets/images/banner_02.jpg",
    "assets/images/banner_03.jpg",
  ];

  final List<Map<String, String>> categories = [
    {"title": "Grocery", "image": "assets/images/grocery.png"},
    {"title": "Clothing", "image": "assets/images/cloths.jpg"},
    {"title": "Electronics", "image": "assets/images/electronics.jpg"},
    {"title": "Nutrition", "image": "assets/images/grocery.png"},
    {"title": "Gym Products", "image": "assets/images/grocery.png"},
    {"title": "Travel", "image": "assets/images/grocery.png"},
    {"title": "Jewellery", "image": "assets/images/jewellery.jpg"},
    {"title": "Games", "image": "assets/images/grocery.png"},
    {"title": "E-books", "image": "assets/images/grocery.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.height30 - 5),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// HEADER + CAROUSEL (COLLAPSIBLE)
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: Dimensions.height30 * 8.0,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20 + 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.height10),

                      /// Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/logos/a_one_logo.png",
                            height: Dimensions.height45 - 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isGrid = !isGrid;
                              });
                            },
                            child: Container(
                              height: Dimensions.height45,
                              width: Dimensions.height45,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius20,
                                ),
                              ),
                              child: Icon(
                                isGrid ? Icons.menu : Icons.grid_view,
                                size: Dimensions.iconSize24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: Dimensions.height15),

                      /// Title
                      Text(
                        "Shop by Categories",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: Dimensions.height15),

                      /// Carousel
                      CarouselSlider(
                        options: CarouselOptions(
                          height: Dimensions.height30 * 5,
                          viewportFraction: 1,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        items: banners.map((image) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius20 - 10,
                            ),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: Dimensions.height10),

                      /// Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: banners.asMap().entries.map((entry) {
                          return Container(
                            width: currentIndex == entry.key
                                ? Dimensions.width20
                                : Dimensions.width10,
                            height: Dimensions.height10 / 2,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10 / 2,
                            ),
                            decoration: BoxDecoration(
                              color: currentIndex == entry.key
                                  ? Colors.green
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// CATEGORIES
            isGrid
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20 + 5,
                      vertical: Dimensions.height20,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final category = categories[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(category: category["title"]!),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  category["image"]!,
                                  height: Dimensions.height45 * 2,
                                ),
                                SizedBox(height: Dimensions.height10),
                                Text(
                                  category["title"]!,
                                  style: TextStyle(fontSize: Dimensions.font16),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, childCount: categories.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Dimensions.width15,
                        mainAxisSpacing: Dimensions.height15,
                        mainAxisExtent: 160,
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20 + 5,
                      vertical: Dimensions.height20,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final category = categories[index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.height15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(category: category["title"]!),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(Dimensions.height15),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius20,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    category["image"]!,
                                    height: Dimensions.height45,
                                  ),
                                  SizedBox(width: Dimensions.width15),
                                  Text(
                                    category["title"]!,
                                    style: TextStyle(
                                      fontSize: Dimensions.font16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: categories.length),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
