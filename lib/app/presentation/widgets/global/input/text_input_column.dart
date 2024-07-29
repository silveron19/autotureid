import 'package:autotureid/app/presentation/widgets/global/input/primary_text_field.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class TextInputColumn extends StatelessWidget {
  const TextInputColumn({
    super.key,
    required this.text,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.email = false,
    this.number = false,
    this.isPassword = false,
    this.isLastInput = false,
    this.onComplete,
    this.validator,
    this.validatorText = 'Form harus diisi',
  });

  final String text;
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool email;
  final bool number;
  final bool isPassword;
  final bool isLastInput;
  final void Function()? onComplete;
  final bool Function(String value)? validator;
  final String validatorText;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: kFontweightBold,
              color: color.onBackground,
            ),
          ),
          const SizedBox(height: 12),
          PrimaryTextField(
            controller: controller,
            hintText: hintText,
            prefixIcon: prefixIcon,
            email: email,
            number: number,
            isPassword: isPassword,
            isLastInput: isLastInput,
            onComplete: onComplete,
            validator: validator,
            validatorText: validatorText,
          ),
        ],
      ),
    );
  }
}
