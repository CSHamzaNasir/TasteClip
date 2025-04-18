import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';

class AppFeild extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final bool isSearchField;
  final String hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final String? prefixImage;
  final double? iconSize;
  final Color? iconColor;
  final bool feildSideClr;
  final bool feildFocusClr;
  final Color? feildClr;
  final double radius;
  final double height;
  final Color? hintTextColor;
  final Color? fieldTextColor;
  final String? suffixImage;
  final VoidCallback? onSuffixTap;
  final bool isRating;

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
    this.prefixImage,
    this.iconSize,
    this.iconColor,
    this.feildSideClr = false,
    this.feildFocusClr = false,
    this.feildClr,
    this.radius = 12,
    this.isSearchField = false,
    this.height = 55,
    this.hintTextColor,
    this.fieldTextColor,
    this.suffixImage,
    this.onSuffixTap,
    this.isRating = false,
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
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.feildClr ?? AppColors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      ),
      child: TextFormField(
        style: AppTextStyles.lightStyle.copyWith(
          color: widget.fieldTextColor ?? AppColors.mainColor,
          fontFamily: AppFonts.sandMedium,
        ),
        controller: widget.controller,
        keyboardType: widget.isRating
            ? TextInputType.numberWithOptions(decimal: true)
            : widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          if (widget.isRating && value != null && value.isNotEmpty) {
            final rating = double.tryParse(value);
            if (rating == null || rating > 5 || rating < 0) {
              return 'Rating must be between 0 and 5';
            }
          }
          return null;
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.isRating
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'^\d?\.?\d?')),
                _MaxValueInputFormatter(5.0),
              ]
            : null,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.feildFocusClr
                  ? AppColors.mainColor
                  : AppColors.greyColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            borderSide: BorderSide(
              color: widget.feildSideClr
                  ? AppColors.mainColor
                  : AppColors.greyColor,
            ),
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.hintTextColor ?? AppColors.mainColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: widget.prefixImage != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0).copyWith(left: 16),
                  child: SvgPicture.asset(
                    widget.prefixImage!,
                    width: widget.iconSize ?? 24,
                    height: widget.iconSize ?? 24,
                    fit: BoxFit.contain,
                  ),
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
              : widget.suffixImage != null
                  ? GestureDetector(
                      onTap: widget.onSuffixTap,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0).copyWith(right: 16),
                        child: SvgPicture.asset(
                          widget.suffixImage!,
                          width: widget.iconSize ?? 24,
                          height: widget.iconSize ?? 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : null,
        ),
      ),
    );
  }
}

class _MaxValueInputFormatter extends TextInputFormatter {
  final double maxValue;

  _MaxValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);
    if (value == null || value > maxValue) {
      return oldValue;
    }

    return newValue;
  }
}
