import 'package:astrohub_user/utils/constants.dart';
import 'package:astrohub_user/utils/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/telescope.dart';

class TelescopeGridItemView extends StatelessWidget {
  final Telescope telescope;

  const TelescopeGridItemView({super.key, required this.telescope});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Card(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: telescope.thumbnail.downloadUrl,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Text(
                  telescope.model,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
                if (telescope.discount > 0)
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: RichText(
                      text: TextSpan(
                        text:
                            '$currencySymbol${priceAfterDiscount(telescope.price, telescope.discount)}',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' $currencySymbol${telescope.price}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (telescope.discount == 0)
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      '$currencySymbol${telescope.price}',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(telescope.avgRating.toStringAsFixed(1)),
                      SizedBox(
                        width: 5,
                      ),
                      RatingBar.builder(
                        initialRating: telescope.avgRating.toDouble(),
                        minRating: 0.0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (telescope.discount > 0)
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    child: Text(
                      '${telescope.discount}% Off',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
