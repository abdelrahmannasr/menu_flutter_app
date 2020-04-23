import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

import '../models/category.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  Category _selectedCategory;
  List<Meal> _categoryMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Category>;
      _selectedCategory = routeArgs['selectedCategory'];
      _categoryMeals = widget.availableMeals.where(
        (meal) {
          return meal.categories.contains(_selectedCategory.id);
        },
      ).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedCategory.title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            selectedMeal: _categoryMeals[index],
            // removeMeal: _removeMeal,
          );
        },
        itemCount: _categoryMeals.length,
      ),
    );
  }

  void _removeMeal(String mealId) {
    setState(() {
      _categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }
}
