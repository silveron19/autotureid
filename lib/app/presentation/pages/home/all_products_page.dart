import 'package:autotureid/app/presentation/provider/product_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/erro_retry_fetch_button.dart';
import 'package:autotureid/app/presentation/widgets/home/last_seen_product_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  late ScrollController scrollController;

  @override
  void initState() {
    Future.microtask(
        () => Provider.of<ProductNotifier>(context, listen: false).getAllProducts(widget.title));
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final notifier = Provider.of<ProductNotifier>(context, listen: false);
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        !notifier.fetchMoreProductsState.isLoading()) {
      Future.microtask(() => notifier.fetchMoreProducts(widget.title));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Consumer<ProductNotifier>(
        builder: (context, notifier, child) {
          final state = notifier.allProductsState;
          if (state.isLoading() || state.isInitial()) {
            return const CircularLoadingIndicator();
          } else if (state.isError()) {
            return ErrorRetryFetchButton(
              failure: state.failure!,
              onRetry: () => notifier.getAllProducts(widget.title),
            );
          }
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title != null
                      ? 'Pencarian untuk kata kunci \'${widget.title}\''
                      : 'Semua Produk',
                  style: kTitle2TextStyle,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.value!.length,
                itemBuilder: (context, index) {
                  return LastSeenProductCard(product: state.value![index]);
                },
              ),
              if (notifier.fetchMoreProductsState.isLoading()) const CircularLoadingIndicator(),
            ],
          );
        },
      ),
    );
  }
}
