import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/widgets/profile/profile_header_information.dart';
import 'package:autotureid/app/presentation/widgets/profile/profile_option_tile.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Consumer<AuthNotifier>(
        builder: (context, auth, child) {
          final user = auth.user;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ProfileHeaderInformation(user: user),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text(
                          'Akun',
                          style: kSubtitle5TextStyle,
                        ),
                      ),
                      ProfileOptionTile(
                        image: R.ASSETS_ICONS_PROFILE_EDIT_PROFILE_PNG,
                        text: 'Ubah Profil',
                        onTap: () => context.go('/profile/edit'),
                      ),
                      ProfileOptionTile(
                        image: R.ASSETS_ICONS_PROFILE_SUBSCRIPTION_PNG,
                        text: 'Langganan',
                        onTap: () => context.push('/subscription'),
                      ),
                      ProfileOptionTile(
                        image: R.ASSETS_ICONS_PROFILE_ACCOUNT_SETTING_PNG,
                        text: 'Atur Akun',
                        onTap: () => context.go('/profile/manage-account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
