import 'package:autotureid/app/presentation/widgets/global/input/primary_text_field.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _HomeAppBarState extends State<HomeAppBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PrimaryTextField(
                controller: searchController,
                hintText: 'Search',
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                borderRadius: 100,
              ),
            ),
            const SizedBox(width: 32),
            IconButton(
              onPressed: () {},
              iconSize: 40,
              icon: const Icon(Icons.account_circle),
              color: color.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
