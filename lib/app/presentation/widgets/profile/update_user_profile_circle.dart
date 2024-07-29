import 'dart:io';

import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class UpdateUserProfileCircle extends StatefulWidget {
  const UpdateUserProfileCircle({
    super.key,
    required this.username,
    required this.imageNotifier,
    required this.imageUrl,
    required this.deleteProfileNotifier,
  });

  final String username;
  final ValueNotifier<File?> imageNotifier;
  final String? imageUrl;
  final ValueNotifier<bool> deleteProfileNotifier;

  @override
  State<UpdateUserProfileCircle> createState() => _UpdateUserProfileCircleState();
}

class _UpdateUserProfileCircleState extends State<UpdateUserProfileCircle> {
  Widget? getChild(context) {
    final color = Theme.of(context).colorScheme;
    if (widget.deleteProfileNotifier.value && widget.imageNotifier.value == null) {
      return Center(
        child: Text(
          widget.username[0].toUpperCase(),
          style: kTitle1TextStyle.copyWith(
            color: color.surface,
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      width: 82,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        shape: BoxShape.circle,
        image: widget.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(widget.imageUrl!),
                fit: BoxFit.cover,
              )
            : widget.imageNotifier.value != null
                ? DecorationImage(
                    image: FileImage(widget.imageNotifier.value!),
                    fit: BoxFit.cover,
                  )
                : null,
      ),
      child: getChild(context),
    );
  }
}
