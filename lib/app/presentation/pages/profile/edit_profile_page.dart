import 'dart:io';

import 'package:autotureid/app/domain/entities/user_data.dart';
import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/input/text_input_column.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/app/presentation/widgets/profile/update_user_profile_circle.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserData user;
  late ValueNotifier<File?> imageNotifier;
  late ValueNotifier<bool> deleteProfileNotifier;
  late TextEditingController usernameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    Provider.of<AuthNotifier>(context, listen: false).updateProfileState.reset();
    user = Provider.of<AuthNotifier>(context, listen: false).user!;
    imageNotifier = ValueNotifier<File?>(null);
    usernameController = TextEditingController(text: user.username);
    phoneController = TextEditingController(text: user.phoneNumber);
    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController();
    deleteProfileNotifier = ValueNotifier<bool>(false);
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    imageNotifier.dispose();
    deleteProfileNotifier.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void onEmailChanged(String value) {
    setState(() {
      Provider.of<AuthNotifier>(context, listen: false).updateProfileState.reset();
    });
  }

  void onComplete() {
    if (formKey.currentState!.validate()) {
      Provider.of<AuthNotifier>(context, listen: false).updateProfile(
        usernameController.text,
        emailController.text,
        passwordController.text,
        phoneController.text,
        imageNotifier.value,
        deleteProfileNotifier.value &&
            user.profilePicture !=
                null, // delete profile picture if user already have profile picture
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profil'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Consumer<AuthNotifier>(
              builder: (context, value, child) {
                final state = value.updateProfileState;
                if (state.isLoading()) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 32),
                    child: CircularLoadingIndicator(),
                  );
                } else if (state.isError()) {
                  Fluttertoast.showToast(
                    msg: state.failure!,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (state.isSuccess()) {
                  final text = passwordController.text.isNotEmpty
                      ? 'Profil berhasil diubah, silakan buka link di email yang baru'
                      : 'Profil berhasil diubah';
                  Fluttertoast.showToast(
                    msg: text,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  Future.microtask(() => context.go('/profile'));
                }
                return PrimaryElevatedButton(
                  text: 'Simpan',
                  dense: true,
                  borderRadius: 12,
                  primaryColor: true,
                  onPressed: onComplete,
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UpdateUserProfileCircle(
                      username: user.username,
                      imageNotifier: imageNotifier,
                      imageUrl: user.profilePicture,
                      deleteProfileNotifier: deleteProfileNotifier,
                    ),
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
                const SizedBox(height: kDefaultPadding),
                TextInputColumn(
                  text: 'Nama',
                  controller: usernameController,
                  hintText: 'Nama',
                  arterisk: true,
                  validator: (value) => value.isEmpty,
                  validatorText: 'Nama harus diisi',
                ),
                TextInputColumn(
                  text: 'Nomor HP',
                  controller: phoneController,
                  hintText: 'Nomor HP',
                  arterisk: true,
                  number: true,
                  phoneNumber: true,
                  prefixWidget: Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        '+62',
                        style: TextStyle(
                          fontWeight: kFontweightBold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                TextInputColumn(
                  text: 'Email',
                  controller: emailController,
                  hintText: 'Email',
                  arterisk: true,
                  validator: (value) => value.isEmpty,
                  validatorText: 'Email harus diisi',
                  onChanged: onEmailChanged,
                ),
                user.email != emailController.text
                    ? TextInputColumn(
                        text: 'Password',
                        controller: passwordController,
                        hintText: 'Password',
                        isPassword: true,
                        validator: (value) => value.isEmpty,
                        validatorText: 'Password harus diisi',
                        onComplete: onComplete,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
