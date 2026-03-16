import 'package:flutter/material.dart';
import '../../data/models/food_item.dart';

class MealListItem extends StatelessWidget {
  final FoodItem meal;
  final String timeAgo;

  const MealListItem({
    super.key,
    required this.meal,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final heroTag = 'meal-${meal.id}';

    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Hero(
          tag: heroTag,
          child: CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            child: Text(
              meal.name.isNotEmpty ? meal.name[0].toUpperCase() : '?',
              style: TextStyle(color: Colors.orange.shade800),
            ),
          ),
        ),
        title: Text(meal.name),
        subtitle: Text('$timeAgo\n${meal.calories.toStringAsFixed(1)} kcal'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}