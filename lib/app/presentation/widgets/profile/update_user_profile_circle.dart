import 'dart:io';

import 'package:autotureid/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker picker = ImagePicker();

  Widget? getChild(context) {
    final color = Theme.of(context).colorScheme;
    if (widget.imageNotifier.value == null) {
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

  Future showOptions(BuildContext context) async {
    bool showDeleteOption = widget.imageNotifier.value != null || widget.imageUrl != null;
    List<Widget> getActions(context) {
      List<Widget> actions = [
        CupertinoActionSheetAction(
          child: const Text('Galeri Foto'),
          onPressed: () async {
            Navigator.of(context).pop();
            getImageFromGallery();
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Kamera'),
          onPressed: () async {
            Navigator.of(context).pop();
            getImageFromCamera();
          },
        ),
      ];

      if (showDeleteOption) {
        actions.add(CupertinoActionSheetAction(
          child: const Text('Hapus'),
          onPressed: () async {
            Navigator.of(context).pop();
            widget.deleteProfileNotifier.value = true;
            widget.imageNotifier.value = null;
          },
        ));
      }
      return actions;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: getActions(context),
      ),
    );
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.imageNotifier.value = File(pickedFile.path);
        widget.deleteProfileNotifier.value = false;
      });
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        widget.imageNotifier.value = File(pickedFile.path);
        widget.deleteProfileNotifier.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showOptions(context),
      child: Container(
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
      ),
    );
  }
}
