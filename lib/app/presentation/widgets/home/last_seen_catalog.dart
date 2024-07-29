import 'package:autotureid/app/presentation/provider/product_notifier.dart';
import 'package:autotureid/app/presentation/widgets/home/last_seen_product_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LastSeenCatalog extends StatelessWidget {
  const LastSeenCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ProductNotifier>(context, listen: false).lastSeenProductsState.value!;
    final color = Theme.of(context).colorScheme;
    return items.isEmpty
        ? const SizedBox()
        : Padding(
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
