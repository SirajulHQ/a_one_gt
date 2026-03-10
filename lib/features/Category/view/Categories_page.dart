import 'package:a_one_gt/core/utils/dimensions.dart';
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
    "https://picsum.photos/800/300?random=1",
    "https://picsum.photos/800/300?random=2",
    "https://picsum.photos/800/300?random=3",
  ];

  final List<Map<String, String>> categories = [
    {
      "title": "Grocery",
      "image": "https://cdn-icons-png.flaticon.com/512/3075/3075977.png",
    },
    {
      "title": "Electronics",
      "image": "https://cdn-icons-png.flaticon.com/512/1041/1041916.png",
    },
    {
      "title": "Cloths",
      "image": "https://cdn-icons-png.flaticon.com/512/892/892458.png",
    },
    {
      "title": "Automotive",
      "image": "https://cdn-icons-png.flaticon.com/512/743/743922.png",
    },
    {
      "title": "Jewellery",
      "image": "https://cdn-icons-png.flaticon.com/512/992/992651.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/icons/logo.png",
                    height: Dimensions.height45,
                    fit: BoxFit.contain,
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

              SizedBox(height: Dimensions.height20),

              /// Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Shop by Categories",
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height15),

              /// Carousel
              Column(
                children: [
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
                          Dimensions.radius20,
                        ),
                        child: Image.network(
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

              SizedBox(height: Dimensions.height20),

              /// Categories
              Expanded(child: isGrid ? gridView() : listView()),
            ],
          ),
        ),
      ),
    );
  }

  /// GRID VIEW
  Widget gridView() {
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Dimensions.width15,
        mainAxisSpacing: Dimensions.height15,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(Dimensions.radius20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
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
        );
      },
    );
  }

  /// LIST VIEW
  Widget listView() {
    return ListView.separated(
      itemCount: categories.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: Dimensions.height15),
      itemBuilder: (context, index) {
        final category = categories[index];

        return Container(
          padding: EdgeInsets.all(Dimensions.height15),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(Dimensions.radius20),
          ),
          child: Row(
            children: [
              Image.network(category["image"]!, height: Dimensions.height45),

              SizedBox(width: Dimensions.width15),

              Text(
                category["title"]!,
                style: TextStyle(fontSize: Dimensions.font20),
              ),
            ],
          ),
        );
      },
    );
  }
}
