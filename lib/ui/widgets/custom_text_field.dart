import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String initialValue;
  final TextInputType inputType;
  final TextEditingController textController;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final TextStyle hintTextStyle;
  final TextInputAction keyboardAction;
  final FocusNode focusNode;
  final Function validator;
  final Function onSaved;
  final Function onTap;
  final Function onChanged;
  final Function onFieldSubmitted;
  final Function onEditComplete;

  CustomTextField({
    @required this.hintText,
    this.hintTextStyle,
    this.initialValue,
    this.textController,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines,
    this.keyboardAction = TextInputAction.next,
    this.focusNode,
    this.validator,
    this.onSaved,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 0.0,
          ),
        ),
        filled: true,
        hintStyle: hintTextStyle,
        hintText: hintText,
        fillColor: Colors.white30,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
          fontSize: 14,
        ),
      ),
      style: hintTextStyle?.fontSize != null ? TextStyle(color: Colors.black, fontSize: hintTextStyle.fontSize) : TextStyle(color: Colors.black),
      enabled: enabled,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: inputType,
      textInputAction: keyboardAction,
      validator: validator,
      onSaved: onSaved,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      controller: textController,
      onEditingComplete: onEditComplete,
      maxLines: obscureText ? 1 : maxLines,
    );
  }
}
