import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/app/presentation/widgets/home/last_seen_product_card.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class LastSeenCatalog extends StatelessWidget {
  const LastSeenCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Product(
        id: 'id',
        mitraId: 'mitraId',
        title: 'Kursi Rotan',
        desc: 'desc',
        price: 200000,
        picture: R.ASSETS_IMAGES_ROTAN_SEAT_PNG,
        model: 'model',
      ),
      Product(
        id: 'id',
        mitraId: 'mitraId',
        title: 'Kursi Rotan',
        desc: 'desc',
        price: 200000,
        picture: R.ASSETS_IMAGES_ROTAN_SEAT_PNG,
        model: 'model',
      ),
      Product(
        id: 'id',
        mitraId: 'mitraId',
        title: 'Kursi Rotan',
        desc: 'desc',
        price: 200000,
        picture: R.ASSETS_IMAGES_ROTAN_SEAT_PNG,
        model: 'model',
      ),
    ];
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Terakhir Dilihat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: kFontweightSemiBold,
                      color: color.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return LastSeenProductCard(product: product);
            },
          ),
        ],
      ),
    );
  }
}
