import 'package:astrohub_user/models/telescope.dart';
import 'package:astrohub_user/providers/telescope_provider.dart';
import 'package:astrohub_user/utils/colors.dart';
import 'package:astrohub_user/utils/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';

class TelescopeDetailsPage extends StatefulWidget {
  static const String routeName = 'productdetails';
  final String id;

  const TelescopeDetailsPage({super.key, required this.id});

  @override
  State<TelescopeDetailsPage> createState() => _TelescopeDetailsPageState();
}

class _TelescopeDetailsPageState extends State<TelescopeDetailsPage> {
  late Telescope telescope;
  late TelescopeProvider provider;
  double userRating = 0.0;

  @override
  void didChangeDependencies() {
    provider = Provider.of<TelescopeProvider>(
      context,
    );
    telescope = provider.findTelescopeById(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          telescope.model,
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: telescope.thumbnail.downloadUrl,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Consumer<CartProvider>(
              builder: (context, provider, child) {
                final isInCart = provider.isTelescopeInCart(telescope.id!);

                  return ElevatedButton.icon(
                  onPressed: () {
                    if(isInCart) {
                      provider.removeFromCart(telescope.id!);
                    } else {
                      provider.addToCart(telescope);
                    }
                    
                  },
                  icon: Icon(isInCart ?Icons.remove_shopping_cart : Icons.shopping_cart),
                  label: Text(isInCart ? 'Remove from cart' :'Add to cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:isInCart? kShrineBrown900 : kShrinePink400,
                    foregroundColor: isInCart? kShrinePink100 : kShrinePink50,
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text(
                'Sale Price : $currencySymbol${priceAfterDiscount(telescope.price, telescope.discount)}'),
            subtitle: Text('stock ${telescope.stock}'),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
               children: [
                RatingBar.builder(
                  initialRating:0.0,
                  minRating:0.0,
                  direction:Axis.horizontal,
                  allowHalfRating:true,
                  itemCount:5,
                  itemBuilder:(context,index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate:(value){
                  userRating = value;
                  },
                ),
                 OutlinedButton(
                   onPressed: _rateThisProduct,
                   child: Text('SUBMIT'),
                 )
               ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _rateThisProduct() async {
    EasyLoading.show(status:'please wait');
    final appUser = Provider.of<UserProvider>(context, listen: false).appUser;
await provider.addRating(telescope.id!, appUser!, userRating);
EasyLoading.dismiss();
showMsg(context, 'Thanks For rating');
  }
}
