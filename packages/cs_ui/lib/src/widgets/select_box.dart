import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class SelectBox<T> extends StatelessWidget {
  const SelectBox({
    Key? key,
    @required this.items,
    this.validator,
    this.radius = 8.0,
    this.value,
    this.onChanged,
    this.icon,
    this.borderSide = const BorderSide(color: Color(0xFFF6F6F6)),
  }) : super(key: key);

  final List<DropdownMenuItem<T>>? items;
  final FormFieldValidator<dynamic>? validator;
  final double radius;
  final dynamic value;
  final ValueSetter<T?>? onChanged;
  final BorderSide borderSide;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value as T,
      items: items,
      isExpanded: true,
      validator: validator,
      decoration: InputDecoration(
        hintStyle: CsTextStyle.smallText.copyWith(
          color: CsColors.black,
        ),
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        labelStyle: CsTextStyle.smallText.copyWith(
          color: CsColors.secondary,
        ),
        prefixIcon: icon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          borderSide: borderSide,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          borderSide: borderSide,
        ),
        contentPadding: const EdgeInsets.only(
          left: 10,
          bottom: 15,
          top: 15,
          right: 10,
        ),
      ),
      onChanged: onChanged,
      dropdownColor: CsColors.white,
      style: CsTextStyle.smallText.copyWith(
        color: CsColors.black,
      ),
      iconEnabledColor: CsColors.black,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 25,
        color: CsColors.secondaryBorder,
      ),
    );
  }
}
