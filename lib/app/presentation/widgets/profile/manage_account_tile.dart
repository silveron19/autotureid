import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class ManageAccountTile extends StatelessWidget {
  const ManageAccountTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding, top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              image,
              width: 25,
              height: 25,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  right: kDefaultPadding,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: kTitle5TextStyle,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            // overflow: TextOverflow.ellipsis,
                            style: kSubtitle6TextStyle,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
