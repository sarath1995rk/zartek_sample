import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/providers/cart_provider.dart';
import 'package:zartek_sample/providers/food_provider.dart';
import 'package:zartek_sample/screens/main_screen_body.dart';
import 'package:zartek_sample/widgets/badge.dart';
import 'package:zartek_sample/widgets/nav_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late FoodProvider _foodProvider;
  String? selectedCat;
  bool _loading = false;

  @override
  void initState() {
    _loading = true;
    _foodProvider = Provider.of<FoodProvider>(context, listen: false);
    _foodProvider.getFoodItems().then((value) {
      selectedCat = _foodProvider.menuCategory[0];
      _foodProvider.filterFood(selectedCat);
      setState(() {
        _loading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _foodProvider.menuCategory.length,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Consumer<CartProvider>(
                  builder: (_, val, Widget? ch) {
                    return Badge(ch!, val.itemCount.toString());
                  },
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            title: Text(''),
            bottom: TabBar(
                onTap: (val) {
                  selectedCat = _foodProvider.menuCategory[val];
                  print(selectedCat);
                  _foodProvider.filterFood(selectedCat);
                  setState(() {});
                },
                indicatorColor: Colors.pink[300],
                labelColor: Colors.pink[300],
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                unselectedLabelStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                labelStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                indicatorWeight: 2.5,
                tabs: _foodProvider.menuCategory.map((e) {
                  return Tab(
                    text: e,
                  );
                }).toList()),
          ),
          drawer: SizedBox(child: DrawerWidget()),
          body: _loading
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
                  children:
                      List.generate(_foodProvider.menuCategory.length, (index) {
                  return MainScreenBody(index);
                }))),
    );
  }
}
