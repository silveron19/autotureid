import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/utils/parse_price.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewProductCard extends StatelessWidget {
  const NewProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.go('/home/detail', extra: product),
      child: Container(
        margin: const EdgeInsets.only(right: kDefaultPadding),
        // padding: const EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //   color: color.surface,
        //   borderRadius: BorderRadius.circular(16),
        //   boxShadow: [
        //     BoxShadow(
        //       color: color.onSurface.withOpacity(0.3),
        //       blurRadius: 8,
        //       offset: const Offset(0, 4),
        //     ),
        //   ],
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.picture,
              width: 150,
              height: 175,
              fit: BoxFit.cover,
            ),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 16,
                color: color.onSurface,
                fontWeight: kFontweightSemiBold,
              ),
            ),
            Text(
              ParsePrice.parsePriceToRupiah(product.price),
              style: const TextStyle(
                fontSize: 16,
                color: kGreenColor,
                fontWeight: kFontweightSemiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
