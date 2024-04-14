import 'package:flutter/material.dart';
import 'package:checkedin/models/core/recipe.dart';
import 'package:checkedin/models/helper/recipe_helper.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/popular_recipe_card.dart';
import 'package:checkedin/views/widgets/recipe_tile.dart';

class DeliciousTodayPage extends StatelessWidget {
  final Recipe popularRecipe = RecipeHelper.popularRecipe;
  final List<Recipe> featuredRecipe = RecipeHelper.featuredRecipe;

  DeliciousTodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text('Delicious Today',
            style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w400,
                fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Popular Recipe
          Container(
            color: AppColor.primary,
            alignment: Alignment.topCenter,
            height: 210,
            padding: const EdgeInsets.all(16),
            child: PopularRecipeCard(data: popularRecipe),
          ),
          // Section 2 - Bookmarked Recipe
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: featuredRecipe.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
              itemBuilder: (context, index) {
                return RecipeTile(
                  data: featuredRecipe[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
