import 'package:autotureid/app/domain/entities/user_data.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class ProfileHeaderInformation extends StatelessWidget {
  const ProfileHeaderInformation({
    super.key,
    required this.user,
  });

  final UserData user;

  Widget getProfilePicture(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    if (user.profilePicture == null) {
      return Container(
        width: 82,
        height: 82,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.onSurface,
        ),
        child: Center(
          child: Text(
            user.username[0].toUpperCase(),
            style: kTitle1TextStyle.copyWith(
              color: color.surface,
            ),
          ),
        ),
      );
    }
    return Container(
      width: 82,
      height: 82,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(R.ASSETS_IMAGES_ROTAN_SEAT_PNG),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Row(
        children: [
          getProfilePicture(context),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: kTitle4TextStyle,
                ),
                Text(
                  user.email,
                  style: kSubtitle5TextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
