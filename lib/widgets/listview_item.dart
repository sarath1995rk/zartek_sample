import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/others/routes.dart';
import 'package:zartek_sample/providers/cart_provider.dart';
import 'package:zartek_sample/resources/assets.dart';
import 'package:zartek_sample/utilities/utilities.dart';
import 'package:zartek_sample/widgets/green_red_circle_container.dart';

class ListViewItems extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double calories;
  final double price;
  final int index;
  final String description;
  final bool customisation;
  final String dishId;
  final int dishType;

  ListViewItems(
      this.title,
      this.imageUrl,
      this.calories,
      this.price,
      this.index,
      this.description,
      this.customisation,
      this.dishId,
      this.dishType);

  final _utils = Utilities();

  @override
  Widget build(BuildContext context) {
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GreenCircleContainer(dishType == 2 ? Colors.green : Colors.red[300]!),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('INR $price'),
                              SizedBox(
                                width: 80,
                              ),
                              Text('$calories Calories'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            description,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green[300]),
                            onPressed: () {
                              cart.addItem(
                                  productId: dishId,
                                  title: title,
                                  unit: '1',
                                  price: price,
                                  calories: calories);
                              _utils.showSnackBarWithAction(
                                  context,
                                  'Item added to cart!',
                                  'Go to cart',
                                  () => Navigator.of(context)
                                      .pushNamed(kCartScreen));
                            },
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (!customisation)
                            Text(
                              'Customisations Available',
                              style: TextStyle(color: Colors.red),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        height: 60,
                        width: 60,
                        child: FadeInImage(
                          image: NetworkImage(imageUrl),
                          placeholder: AssetImage(kPlaceHolder),
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
