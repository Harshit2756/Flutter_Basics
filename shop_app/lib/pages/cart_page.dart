import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context).cart; same as below
    final cart = context.watch<CartProvider>().cartList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];
          return ListTile(
            leading: CircleAvatar(
              foregroundImage: AssetImage(
                cartItem['imageUrl'] as String,
              ),
              radius: 30,
            ),
            title: Text(
              cartItem['title'] as String,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('Size: ${cartItem['size']}'),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Remove from cart?',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        content: Text(
                          'Are you sure you want to remove this item from the cart?',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Provider.of<CartProvider>(context, listen: false).removeFromCart(cartItem); same as below read is used when listen is false
                              context
                                  .read<CartProvider>()
                                  .removeFromCart(cartItem);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Remove',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
