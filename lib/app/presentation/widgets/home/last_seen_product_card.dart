import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/utils/parse_price.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LastSeenProductCard extends StatelessWidget {
  const LastSeenProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            product.picture,
            width: 85,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
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
          PrimaryElevatedButton(
            text: 'Lihat Detail',
            dense: true,
            borderRadius: 100,
            onPressed: () => context.push('/home/detail/${product.id}'),
          ),
        ],
      ),
    );
  }
}
