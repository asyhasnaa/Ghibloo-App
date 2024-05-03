import 'package:flutter/material.dart';
import 'package:ghibloo_app/models/categories.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.currentCategories,
  });

  final String currentCategories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Container(
            decoration: BoxDecoration(
              color: currentCategories == categories[index]
                  ? Colors.green
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              categories[index],
              style: TextStyle(
                color: currentCategories == categories[index]
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
