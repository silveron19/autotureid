import 'package:autotureid/app/presentation/provider/product_notifier.dart';
import 'package:autotureid/app/presentation/provider/search_notifier.dart';
import 'package:autotureid/app/presentation/widgets/home/new_product_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewProductCatalog extends StatelessWidget {
  const NewProductCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ProductNotifier>(context, listen: false).newProductsState.value!;
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
                  onPressed: () =>
                      Provider.of<SearchNotifier>(context, listen: false).onAllProductModeOn(),
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
          items.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada produk baru',
                    style: kSubtitle5TextStyle,
                  ),
                )
              : SizedBox(
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
