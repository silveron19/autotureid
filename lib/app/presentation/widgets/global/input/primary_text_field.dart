import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isLastInput;
  final bool email;
  final bool number;
  final void Function()? onComplete;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool Function(String value)? validator;
  final String validatorText;
  final double borderRadius;
  final Widget? prefixWidget;
  final void Function(String value)? onChanged;
  final void Function(bool value)? onFocusChanged;
  final FocusNode? focusNode;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.email = false,
    this.number = false,
    this.isPassword = false,
    this.isLastInput = false,
    this.onComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.validatorText = 'Field must be filled',
    this.borderRadius = 10,
    this.prefixWidget,
    this.onChanged,
    this.onFocusChanged,
    this.focusNode,
  });

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  late FocusNode _focusNode;
  late bool _isObscure;
  late Widget? _suffixIcon;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _isObscure = widget.isPassword;
    _focusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    _suffixIcon = _getSuffix();
    return TextFormField(
      onChanged: widget.onChanged,
      cursorColor: color.primary,
      focusNode: _focusNode,
      validator: widget.validator != null
          ? (value) {
              if (widget.validator!(value!)) {
                return widget.validatorText;
              }
              return null;
            }
          : null,
      onEditingComplete: () async {
        if (widget.onComplete != null) {
          _focusNode.unfocus();
          widget.onComplete!();
        } else {
          _focusNode.nextFocus();
        }
      },
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: _isObscure,
      keyboardType: widget.email
          ? TextInputType.emailAddress
          : widget.number
              ? TextInputType.number
              : widget.isPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
      // deny minus sign for number input
      inputFormatters: widget.number
          ? [
              FilteringTextInputFormatter.deny('-'),
              FilteringTextInputFormatter.deny(','),
              FilteringTextInputFormatter.deny(' '),
            ]
          : null,
      textInputAction: widget.isLastInput ? TextInputAction.done : TextInputAction.next,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: kFontweightBold,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: kDarkGrey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: const BorderSide(
            color: kDarkGrey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: const BorderSide(
            color: kDarkGrey,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: const BorderSide(
            color: kDarkGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: const BorderSide(
            color: kDarkGrey,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.prefixWidget,
        suffix: _suffixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }

  Widget? _getSuffix() {
    if (widget.isPassword) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
        child: Icon(
          _isObscure ? Icons.visibility : Icons.visibility_off,
          color: kDarkGrey,
        ),
      );
    }
    return null;
  }
}
