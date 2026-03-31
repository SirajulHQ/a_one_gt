import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/category/widgets/exit_dialog_widget.dart';
import 'package:a_one_gt/features/main_navigation/view/main_navigation_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final List<String> categories = [
    "Grocery",
    "Clothing",
    "Electronics",
    "Nutrition",
    "Gym Products",
    "Travel",
    "Jewellery",
    "Games",
    "E-boooks",
  ];
  Future<bool> _showExitConfirmation() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ExitDialogWidget(),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _showExitConfirmation();
        if (shouldPop && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Appcolors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20 + 5),
            child: Column(
              children: [
                SizedBox(height: Dimensions.height10),

                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/logos/a_one_logo.png",
                      height: Dimensions.height45 - 10,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          // height: Dimensions.height45 - 10,
                          // width: Dimensions.height45 * 2,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
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

                SizedBox(height: Dimensions.height10),

                /// Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Shop by Categories",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
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
                            Dimensions.radius20 - 10,
                          ),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                              );
                            },
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
      ),
    );
  }

  /// GRID VIEW
  Widget gridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Dimensions.width15,
        mainAxisSpacing: Dimensions.height15,
        mainAxisExtent: 160,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavigationPage(category: category),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/grocery.png",
                  height: Dimensions.height45 * 2,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: Dimensions.height45 * 2,
                      width: Dimensions.height45 * 2,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
                SizedBox(height: Dimensions.height10),
                Text(category, style: TextStyle(fontSize: Dimensions.font16)),
              ],
            ),
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

        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavigationPage(category: category),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(Dimensions.height15),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/grocery.png",
                  height: Dimensions.height45,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: Dimensions.height45,
                      width: Dimensions.height45,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
                SizedBox(width: Dimensions.width15),
                Text(category, style: TextStyle(fontSize: Dimensions.font16)),
              ],
            ),
          ),
        );
      },
    );
  }
}
