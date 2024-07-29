import 'package:autotureid/app/domain/entities/user_data.dart';
import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/widgets/profile/profile_header_information.dart';
import 'package:autotureid/app/presentation/widgets/profile/profile_option_tile.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserData user;

  @override
  void initState() {
    user = Provider.of<AuthNotifier>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              ProfileHeaderInformation(user: user),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Akun',
                    style: kSubtitle5TextStyle,
                  ),
                  ProfileOptionTile(
                    image: R.ASSETS_ICONS_PROFILE_EDIT_PROFILE_PNG,
                    text: 'Ubah Profil',
                    onTap: () {},
                  ),
                  ProfileOptionTile(
                    image: R.ASSETS_ICONS_PROFILE_SUBSCRIPTION_PNG,
                    text: 'Langganan',
                    onTap: () {},
                  ),
                  ProfileOptionTile(
                    image: R.ASSETS_ICONS_PROFILE_ACCOUNT_SETTING_PNG,
                    text: 'Atur Akun',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
