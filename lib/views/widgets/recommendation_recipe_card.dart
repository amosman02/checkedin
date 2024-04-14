import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:checkedin/models/core/recipe.dart';
import 'package:checkedin/views/screens/recipe_detail_page.dart';

class RecommendationRecipeCard extends StatelessWidget {
  final Recipe data;
  const RecommendationRecipeCard({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailPage(data: data)));
      },
      child: SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Photo
            Container(
              height: 120,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey,
                image: DecorationImage(
                  image: AssetImage(data.photo!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Recipe title
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                data.title!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'inter'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Recipe calories and time
            Container(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/fire-filled.svg',
                    color: Colors.black,
                    width: 12,
                    height: 12,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text(
                      '2100 Cal',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.alarm,
                    size: 12,
                    color: Colors.black,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text(
                      '25 min',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
