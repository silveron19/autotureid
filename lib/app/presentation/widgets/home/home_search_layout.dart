import 'package:autotureid/app/presentation/provider/search_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeSearchLayout extends StatefulWidget {
  const HomeSearchLayout({super.key});

  @override
  State<HomeSearchLayout> createState() => _HomeSearchLayoutState();
}

class _HomeSearchLayoutState extends State<HomeSearchLayout> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      color: color.surface,
      child: SingleChildScrollView(
        child: Consumer<SearchNotifier>(
          builder: (context, value, child) {
            final state = value.searchProductsState;
            if (state.isLoading()) {
              return const Padding(
                padding: EdgeInsets.only(top: kDefaultPadding),
                child: CircularLoadingIndicator(),
              );
            } else if (state.isError()) {
              return const Text('error');
            } else if (state.value == null) {
              return const SizedBox();
            }
            return Column(
              children: state.value!
                  .map(
                    (product) => GestureDetector(
                      onTap: () => context.go('/home/detail/${product.id}'),
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: kDefaultPadding,
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              product.picture,
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              product.title,
                              style: kSubtitle5TextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
