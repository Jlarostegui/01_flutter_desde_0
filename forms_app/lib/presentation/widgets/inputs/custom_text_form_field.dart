import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.label,
      this.hintText,
      this.erroMessage,
      this.onChanged,
      this.validator,
      this.obscureText});

  final String? label;
  final String? hintText;
  final String? erroMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: colors.primary),
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText ?? false,
      // validator: (value) {
      //   if (value == null) return 'Campo Requerido';
      //   if (value.isEmpty) return 'Campo Requerido';
      //   if (value.trim().isEmpty) return 'Campo Requerido';
      //   return null;
      // },
      decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colors.primary),
          ),
          errorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.red.shade800),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.red.shade800),
          ),
          errorText: erroMessage,
          isDense: true,
          label: Text(label ?? ''),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(color: colors.primary),
          hintText: hintText,
          // focusColor: colors.primary,
          prefixIcon: Icon(
            Icons.supervised_user_circle_outlined,
            color: colors.primary,
          )),
    );
  }
}
