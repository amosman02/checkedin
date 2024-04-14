import 'package:flutter/material.dart';
import 'package:checkedin/models/core/recipe.dart';
import 'package:checkedin/models/helper/recipe_helper.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/recipe_tile.dart';

class NewlyPostedPage extends StatelessWidget {
  final TextEditingController searchInputController = TextEditingController();
  final List<Recipe> newlyPostedRecipe = RecipeHelper.newlyPostedRecipe;

  NewlyPostedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.dark,
        backgroundColor: AppColor.primary,
        centerTitle: true,
        elevation: 0,
        title: const Text('Newly Posted',
            style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w400,
                fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: newlyPostedRecipe.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          return RecipeTile(
            data: newlyPostedRecipe[index],
          );
        },
      ),
    );
  }
}
