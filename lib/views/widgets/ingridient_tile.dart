import 'package:flutter/material.dart';
import 'package:checkedin/models/core/recipe.dart';

class IngridientTile extends StatelessWidget {
  final Ingridient data;
  const IngridientTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[350]!, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 9,
            child: Text(
              data.name!,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, height: 150 / 100),
            ),
          ),
          Flexible(
            flex: 3,
            child: Text(
              data.size!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'inter',
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
