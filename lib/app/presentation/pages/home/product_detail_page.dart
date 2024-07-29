import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_action_button.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/utils/parse_price.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final Product product = Product(
    id: '1',
    mitraId: '2',
    title: 'Kursi Rotan, Light Brown',
    desc: 'Kursi dapat dipakai sebagai tempat duduk  anak maupun orang dewasa',
    price: 100,
    picture: R.ASSETS_IMAGES_ROTAN_SEAT_PNG,
    model: R.ASSETS_IMAGES_ROTAN_SEAT_PNG,
  );

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
            color: color.onSurface,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  product.picture,
                  width: 263,
                  height: 252,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryActionButton(
                  text: 'Lihat dengan ARTure',
                  radiusOnlyRight: false,
                  fontSize: 16,
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title, style: kTitle4TextStyle),
                    const SizedBox(height: 4),
                    Text(
                      'Harga: ${ParsePrice.parsePriceToRupiah(product.price)}',
                      style: kTitle4TextStyle.copyWith(
                        color: kGreenColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                kDefaultPadding,
                                kDefaultPadding,
                                kDefaultPadding,
                                40,
                              ),
                              decoration: BoxDecoration(
                                color: color.primary,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Deskripsi',
                                    style: kTitle4TextStyle,
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.desc,
                                    style: kSubtitle5TextStyle,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 32,
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: color.onSurface,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 31,
                            ),
                            decoration: BoxDecoration(
                              color: color.onSurface,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              'Buy Now',
                              style: kSubtitle5TextStyle.copyWith(
                                color: color.surface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
