import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/constant/app_colors.dart';

class AppFeild extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final double? iconSize;
  final Color? iconColor;
  final bool feildSideClr;
  final bool feildFocusClr;

  const AppFeild({
    super.key,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    required this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.prefixIcon,
    this.iconSize,
    this.iconColor,
    this.feildSideClr = false,
    this.feildFocusClr = false,
  });

  @override
  AppFeildState createState() => AppFeildState();
}

class AppFeildState extends State<AppFeild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: TextFormField(
        style: AppTextStyles.lightStyle,
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.feildFocusClr
                  ? AppColors.mainColor
                  : AppColors.greyColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: widget.feildSideClr
                    ? AppColors.mainColor
                    : AppColors.greyColor,
              )),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: AppColors.mainColor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: widget.iconSize,
                  color: widget.iconColor,
                )
              : null,
          suffixIcon: widget.isPasswordField == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    size: widget.iconSize,
                    color: _obscureText
                        ? AppColors.mainColor
                        : AppColors.textColor,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
