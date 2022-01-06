import 'package:flutter/cupertino.dart';
import 'package:zartek_sample/others/responses/food_resp.dart';
import 'package:zartek_sample/services/api_service.dart';

class FoodProvider extends ChangeNotifier {
  List<String> menuCategory = [];
  List<CategoryDish> categoryDishList = [];
  Food? _foodItems;

  Future<void> getFoodItems() async {
    try {
      _foodItems = await ApiService().fetchData();
      menuCategory.clear();
      if (_foodItems != null) {
        for (var item in _foodItems!.tableMenuList!) {
          menuCategory.add(item.menuCategory!);
        }
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  List<CategoryDish> filterFood(String? query) {
    categoryDishList.clear();
    if (_foodItems != null && query != null) {
      for (var item in _foodItems!.tableMenuList!) {
        if (item.menuCategory == query) {
          for (var dish in item.categoryDishes!) {
            categoryDishList.add(dish);
          }
        }
      }
    }
    print(categoryDishList);
    return categoryDishList;
  }
}
