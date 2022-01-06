import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/providers/cart_provider.dart';

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green[900],
        ),
        child: const Text('Submit'),
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).clearCart();
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Successful'),
                    content: Text('Your order succefully placed'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            'Okay',
                            style: TextStyle(color: Colors.green[900]),
                          ))
                    ],
                  ));
        },
      ),
    );
  }
}
