import 'package:astrohub_user/models/cart_model.dart';
import 'package:astrohub_user/providers/cart_provider.dart';
import 'package:astrohub_user/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CartItemView extends StatelessWidget {
  final CartModel cartModel;
  final CartProvider provider;
  const CartItemView({super.key, required this.cartModel, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: CachedNetworkImage(
                width: 72,
                height: 72,
                imageUrl: cartModel.imageUrl,
                placeholder: (context , url)=> Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context,url,error)=> Icon(Icons.error),
              ),
              title: Text(cartModel.telescopeModel),
              subtitle: Text('Unit Price: $currencySymbol${cartModel.price}'),
              trailing: IconButton(
                onPressed: (){
                  provider.removeFromCart(cartModel.telescopeId);
                },
                icon: Icon(Icons.delete),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_circle,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${cartModel.quantity}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle,
                    size: 30,
                  ),
                ),
                const Spacer(),
              Text('$currencySymbol',  style: Theme.of(context).textTheme.titleLarge,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
