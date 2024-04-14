import 'package:flutter/material.dart';
import 'package:checkedin/models/core/recipe.dart';
import 'package:checkedin/models/helper/recipe_helper.dart';
import 'package:checkedin/views/screens/delicious_today_page.dart';
import 'package:checkedin/views/screens/newly_posted_page.dart';
import 'package:checkedin/views/screens/profile_page.dart';
import 'package:checkedin/views/screens/search_page.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/custom_app_bar.dart';
import 'package:checkedin/views/widgets/dummy_search_bar.dart';
import 'package:checkedin/views/widgets/featured_recipe_card.dart';
import 'package:checkedin/views/widgets/recipe_tile.dart';
import 'package:checkedin/views/widgets/recommendation_recipe_card.dart';

class HomePage extends StatelessWidget {
  final List<Recipe> featuredRecipe = RecipeHelper.featuredRecipe;
  final List<Recipe> recommendationRecipe = RecipeHelper.recommendationRecipe;
  final List<Recipe> newlyPostedRecipe = RecipeHelper.newlyPostedRecipe;

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(
          'Hungry?',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        showProfilePhoto: true,
        profilePhoto: const AssetImage('assets/images/pp.png'),
        profilePhotoOnPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage()));
        },
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Featured Recipe - Wrapper
          Container(
            height: 350,
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  height: 245,
                  color: AppColor.primary,
                ),
                // Section 1 - Content
                Column(
                  children: [
                    // Search Bar
                    DummySearchBar(
                      routeTo: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                      },
                    ),
                    // Delicious Today - Header
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Delicious Today',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DeliciousTodayPage()));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14)),
                            child: const Text('see all'),
                          ),
                        ],
                      ),
                    ),
                    // Delicious Today - ListView
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 220,
                      child: ListView.separated(
                        itemCount: featuredRecipe.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 16,
                          );
                        },
                        itemBuilder: (context, index) {
                          return FeaturedRecipeCard(
                              data: featuredRecipe[index]);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Section 2 - Recommendation Recipe
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    'Today recomendation based on your taste...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                // Content
                SizedBox(
                  height: 174,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendationRecipe.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                    itemBuilder: (context, index) {
                      return RecommendationRecipeCard(
                          data: recommendationRecipe[index]);
                    },
                  ),
                )
              ],
            ),
          ),
          // Section 3 - Newly Posted
          Container(
            margin: const EdgeInsets.only(top: 14),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Newly Posted',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewlyPostedPage()));
                      },
                      style: TextButton.styleFrom(
                        // backgroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      child: const Text('see all'),
                    ),
                  ],
                ),
                // Content
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 3 ?? newlyPostedRecipe.length,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    return RecipeTile(
                      data: newlyPostedRecipe[index],
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
