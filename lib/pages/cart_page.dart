import 'package:astrohub_user/customwidgets/cart_item_view.dart';
import 'package:astrohub_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  static const String routeName = 'cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart '),
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cartList.length,
                itemBuilder: (context, index) {
                  final model = provider.cartList[index];
                  return CartItemView(cartModel: model, provider: provider);
                },
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Sub Total : $currencySymbol${provider.getCartSubTotal()}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    OutlinedButton(onPressed: provider.totalItemsInCart == 0  ? null : (){ context.pop();
                    context.goNamed(CheckoutPage.routeName);},
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
