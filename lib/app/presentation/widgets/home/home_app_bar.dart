import 'package:autotureid/app/presentation/provider/search_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/input/primary_text_field.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color.primary.withOpacity(0.5),
            ),
          ),
        ),
        child: Consumer<SearchNotifier>(
          builder: (context, notifier, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                notifier.searchMode || notifier.allProductMode
                    ? IconButton(
                        onPressed: notifier.allProductMode
                            ? notifier.onAllProductModeOff
                            : notifier.onSearchModeOff,
                        icon: const Icon(Icons.arrow_back),
                      )
                    : const SizedBox(),
                Expanded(
                  child: PrimaryTextField(
                    controller: notifier.searchController,
                    hintText: 'Search',
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    borderRadius: 100,
                    focusNode: notifier.searchFocusNode,
                    onChanged: notifier.onSearchChanged,
                    onComplete: notifier.onSearchSubmit,
                    onFocusChanged: (value) {
                      if (value) {
                        notifier.onSearchModeOn();
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
