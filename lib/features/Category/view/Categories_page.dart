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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image.network(
                  //   "https://picsum.photos/200/80",
                  //   height: 35,
                  // ),
                  Image.asset("assets/icons/logo.png", height: 100),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        isGrid ? Icons.menu : Icons.grid_view,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Shop by Categories",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 15),

              /// Carousel
              Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
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
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 10),

                  /// Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: banners.asMap().entries.map((entry) {
                      return Container(
                        width: currentIndex == entry.key ? 20 : 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: currentIndex == entry.key
                              ? Colors.green
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              const SizedBox(height: 20),

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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(category["image"]!, height: 90),

              const SizedBox(height: 10),

              Text(category["title"]!, style: const TextStyle(fontSize: 16)),
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
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        final category = categories[index];

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Image.network(category["image"]!, height: 45),

              const SizedBox(width: 15),

              Text(category["title"]!, style: const TextStyle(fontSize: 18)),
            ],
          ),
        );
      },
    );
  }
}
