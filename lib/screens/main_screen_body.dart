import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/providers/food_provider.dart';
import 'package:zartek_sample/widgets/listview_item.dart';

class MainScreenBody extends StatefulWidget {
  final int index;

  MainScreenBody(this.index);

  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  late FoodProvider _foodProvider;
  @override
  void initState() {
    _foodProvider = Provider.of<FoodProvider>(context, listen: false);
    var selectedCat = _foodProvider.menuCategory[widget.index];
    _foodProvider.filterFood(selectedCat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10, bottom: 50),
        itemBuilder: (ctx, index) {
          final foods = _foodProvider.categoryDishList[index];

          final bool custom = foods.addonCat == null || foods.addonCat!.isEmpty;
          return ListViewItems(
              foods.dishName!,
              foods.dishImage!,
              foods.dishCalories!,
              foods.dishPrice!,
              index,
              foods.dishDescription!,
              custom,
              foods.dishId!,
              foods.dishType!);
        },
        separatorBuilder: (ctx, i) {
          return const Divider(
            thickness: 1.0,
          );
        },
        itemCount: _foodProvider.categoryDishList.length);
  }
}
