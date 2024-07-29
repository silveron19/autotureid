import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final bigScreen = MediaQuery.of(context).size.width > 480;
    final activeColor = color.primary;
    const inActiveColor = kDarkGrey;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 480,
          ),
          child: navigationShell,
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: bigScreen ? 0 : 1,
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 480,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: color.primary.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.shadow.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 14.0,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: color.surface,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: inActiveColor,
                selectedItemColor: activeColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_HOME_PNG),
                        color: navigationShell.currentIndex == 0 ? activeColor : inActiveColor,
                        width: 24,
                      ),
                    ),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_AR_PNG),
                        color: navigationShell.currentIndex == 1 ? activeColor : inActiveColor,
                        width: 24,
                      ),
                    ),
                    label: 'ARTure',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_SUBSCRIBE_PNG),
                        color: navigationShell.currentIndex == 2 ? activeColor : inActiveColor,
                        width: 24,
                      ),
                    ),
                    label: 'Langganan',
                  ),
                ],
                currentIndex: navigationShell.currentIndex,
                onTap: (int idx) => _onItemTapped(idx, context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
