import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/providers/cart_provider.dart';
import 'package:zartek_sample/widgets/cart_screen_items.dart';
import 'package:zartek_sample/widgets/submit_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartData = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Order Summary',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: cartData.items.length == 0
            ? Center(child: Text('No items in cart!'))
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 65,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green[900]),
                            child: Consumer<CartProvider>(
                              builder: (_, val, __) {
                                return Text(
                                  '${val.itemCount} Dishes - ${val.productsCount} Items',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                );
                              },
                            ),
                          ),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                final item =
                                    cartData.items.values.toList()[index];
                                return CartScreenItems(
                                    item.productId,
                                    item.title,
                                    item.calories,
                                    item.price,
                                    index,
                                    item.quantity);
                              },
                              separatorBuilder: (c, i) {
                                return const Divider(
                                  thickness: 1,
                                );
                              },
                              itemCount: cartData.items.length),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: const Divider(
                              thickness: 1.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amount',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Consumer<CartProvider>(builder: (_, val, __) {
                                  return Text(
                                    'INR ${val.totalAmount}',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 16),
                                  );
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SubmitButton()
                  ],
                ),
              ));
  }
}
