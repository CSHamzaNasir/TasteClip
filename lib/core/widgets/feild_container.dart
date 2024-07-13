import 'package:flutter/material.dart';
import 'package:tasteclip/theme/text_style.dart';

class FieldContainer extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
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

  const FieldContainer({
    super.key,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
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
  FieldContainerState createState() => FieldContainerState();
}

class FieldContainerState extends State<FieldContainer> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
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
              color: widget.feildFocusClr ? primaryColor : Colors.transparent,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: widget.feildSideClr ? primaryColor : Colors.transparent,
              )),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: mainColor, fontSize: 15, fontWeight: FontWeight.w500),
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
                    color: _obscureText ? mainColor : textColor,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
