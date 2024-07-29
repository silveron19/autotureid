import 'package:autotureid/app/presentation/provider/product_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_action_button.dart';
import 'package:autotureid/app/presentation/widgets/product/product_detail_shimmer.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/utils/parse_price.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<ProductNotifier>(context, listen: false).getProductDetail(widget.id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Provider.of<ProductNotifier>(context, listen: false).cancelProductDetailSubscription();
        context.pop();
      },
      child: Scaffold(
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
          child: Consumer<ProductNotifier>(
            builder: (context, notifier, child) {
              final state = notifier.productDetailState;

              if (state.isLoading()) {
                return const ProductDetailLoading();
              } else if (state.isError()) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: color.error, size: 64),
                      const SizedBox(height: 16),
                      Text(
                        'Gagal memuat data: ${state.failure}',
                        style: TextStyle(
                          color: color.onSurface,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            notifier.getProductDetail(widget.id);
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state.isSuccess()) {
                final product = state.value!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
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
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title, style: kTitle4TextStyle),
                            const SizedBox(height: 4),
                            Text(
                              'Harga: ${ParsePrice.parsePriceToRupiah(product.price)}',
                              style: kTitle4TextStyle.copyWith(color: kGreenColor),
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
                                          const Text('Deskripsi', style: kTitle4TextStyle),
                                          const SizedBox(height: 8),
                                          const Divider(),
                                          const SizedBox(height: 8),
                                          Text(product.desc, style: kSubtitle5TextStyle),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      iconSize: 32,
                                      icon: Icon(Icons.shopping_cart_outlined,
                                          color: color.onSurface),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 12, vertical: 31),
                                    decoration: BoxDecoration(
                                      color: color.onSurface,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      'Buy Now',
                                      style: kSubtitle5TextStyle.copyWith(color: color.surface),
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
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
