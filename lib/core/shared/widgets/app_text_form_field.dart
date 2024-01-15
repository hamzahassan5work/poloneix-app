import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AppTextFormFieldType {
  email,
  password,
  text,
}

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    this.type = AppTextFormFieldType.text,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.keyboardType,
  });

  final AppTextFormFieldType type;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final _Type type;
  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: type == _Type.password && !_isPasswordVisible,
      keyboardType: switch (type) {
        == _Type.email => TextInputType.emailAddress,
        == _Type.password => TextInputType.visiblePassword,
        _ => widget.keyboardType,
      },
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: type == _Type.password
            ? GestureDetector(
                onTap: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
                child: Icon(
                  _isPasswordVisible
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  size: 16,
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}

typedef _Type = AppTextFormFieldType;
