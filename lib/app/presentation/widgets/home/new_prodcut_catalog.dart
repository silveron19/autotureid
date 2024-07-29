import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/app/presentation/widgets/home/new_product_card.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class NewProductCatalog extends StatelessWidget {
  const NewProductCatalog({super.key});

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
                    'Produk Baru',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: kFontweightSemiBold,
                      color: color.onSurface,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                  ),
                  iconSize: 32,
                  color: color.onSurface,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 229,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final product = items[index];
                return NewProductCard(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
