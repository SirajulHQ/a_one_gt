import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/dummy_data/dummy_data.dart';
import 'package:a_one_gt/features/product/view/product_home_page.dart';
import 'package:a_one_gt/features/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final String category;

  const HomePage({super.key, required this.category});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> displayedSubCategories;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.category == "All") {
      displayedSubCategories = subCategories.values.expand((e) => e).toList();
    } else {
      displayedSubCategories = subCategories[widget.category] ?? [];
    }
  }

  void _runFilter(String query) {
    List<String> results = [];

    if (query.isEmpty) {
      if (widget.category == "All") {
        results = subCategories.values.expand((e) => e).toList();
      } else {
        results = subCategories[widget.category] ?? [];
      }
    } else {
      final source = widget.category == "All"
          ? subCategories.values.expand((e) => e).toList()
          : subCategories[widget.category] ?? [];

      results = source
          .where((sub) => sub.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      displayedSubCategories = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          /// APP BAR
          CustomSliverAppBar(
            title: widget.category,
            subtitle: "${displayedSubCategories.length} subcategories",
          ),

          /// SEARCH
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: TextField(
                controller: _searchController,
                onChanged: _runFilter,
                decoration: InputDecoration(
                  hintText: "Search subcategories...",
                  prefixIcon: Icon(Icons.search, color: Appcolors.primaryGreen),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          /// SECTION HEADER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Row(
                children: [
                  Container(
                    width: Dimensions.width10,
                    height: Dimensions.height20,
                    decoration: BoxDecoration(
                      color: Appcolors.primaryGreen,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: Dimensions.width20),
                  Text(
                    "Best Deal",
                    style: TextStyle(
                      fontSize: Dimensions.font16 + 2,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 13,
                      color: Appcolors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// HORIZONTAL OFFER LIST
          SliverToBoxAdapter(
            child: SizedBox(
              height: 180,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 16, top: 16),
                scrollDirection: Axis.horizontal,
                itemCount: displayedSubCategories.length,
                itemBuilder: (context, index) {
                  final sub = displayedSubCategories[index];

                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(
                                subCategoryImages[sub] ??
                                    "assets/images/grocery.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              "ITEMS\nAT \$25",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          sub,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: const [
                            Icon(Icons.star, size: 14, color: Colors.teal),
                            SizedBox(width: 4),
                            Text(
                              "4.8 • 15-20mins",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          /// GRID
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final sub = displayedSubCategories[index];

                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductHomePage(
                          category: widget.category,
                          subCategory: sub,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          subCategoryImages[sub] ?? "assets/images/grocery.png",
                          height: 60,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          sub,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: displayedSubCategories.length),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.85,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
