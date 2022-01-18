import 'package:cs_ui/cs_ui.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DateInputMode {
  date,
  datetime,
  time,
}

class DateInputBox extends StatelessWidget {
  ///@macro TextBox Constructor
  const DateInputBox(
      {Key? key,
      this.controller,
      this.validator,
      this.hintText,
      this.labelText,
      this.errorText,
      this.icon,
      this.value = '',
      this.leadingIcon,
      this.leadingColor = CsColors.primaryText,
      this.fillColor = const Color(0xFFF6F6F6),
      this.maxLength,
      this.inputFormat,
      this.inputType,
      this.isPassword = false,
      this.raduis = 10.0,
      this.borderSide = const BorderSide(color: Color(0xFFF6F6F6)),
      this.iconSize = 24.0,
      this.isWritable = true,
      this.enablePrefix = true,
      this.mode = DateInputMode.date,
      //DateTimeFieldPickerMode.date,
      this.onChanged,
      this.focus,
      this.onIconClick})
      : super(key: key);

  ///@macro TextEditingController fields
  final TextEditingController? controller;

  ///@macro Validator fields
  final FormFieldValidator<DateTime?>? validator;

  final DateInputMode? mode;

  ///@macro HintText
  final String? hintText;

  ///@macro Label Text
  final String? labelText;

  ///@macro Error Text
  final String? errorText;

  ///@macro Icon
  final IconData? icon;

  ///@macro value
  final String? value;

  ///@macro Leading Icon
  final IconData? leadingIcon;

  ///@macro Max Length
  final int? maxLength;

  ///@macro InputForm
  final List<TextInputFormatter>? inputFormat;

  ///@macro Input Type
  final TextInputType? inputType;

  ///@macro IsPassword either true/false
  final bool isPassword;

  ///@macro InputBox Border Raduis
  final double raduis;

  ///@macro BorderSide
  final BorderSide borderSide;

  ///@macro Icon Size
  final double iconSize;

  ///@macro Iswritable true/false
  final bool isWritable;

  ///@macro onIconClick
  final VoidCallback? onIconClick;

  ///@macro LeadingIcon Color
  final Color leadingColor;

  ///@macro TextBox Background Color
  final Color fillColor;

  ///@macro Enable Prefix Icon true/false
  final bool enablePrefix;

  ///@macro OnChange function
  final ValueChanged<DateTime>? onChanged;

  ///@macro TextBox Focus
  final FocusNode? focus;

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      decoration: InputDecoration(
        hintStyle: CsTextStyle.caption.copyWith(
          color: const Color(0xFFA8AAB8),
        ),
        hintText: hintText,
        labelStyle: CsTextStyle.caption.copyWith(
          color: CsColors.secondary,
        ),
        fillColor: fillColor,
        filled: true,
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            raduis,
          ),
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            raduis,
          ),
          borderSide: borderSide,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            raduis,
          ),
          borderSide: borderSide,
        ),
        contentPadding: const EdgeInsets.only(
          left: 20,
          bottom: 20,
          top: 20,
        ),
        suffixIcon: const Icon(Icons.event_note),
      ),
      mode: mode!.toDateTimePickerMode(),
      //DateTimeFieldPickerMode
      firstDate: DateTime.now(),
      initialDate: DateTime.now().subtract(const Duration(days: 10000)),
      autovalidateMode: AutovalidateMode.always,
      validator: validator,
      onDateSelected: onChanged,
    );
  }
}

extension Modes on DateInputMode {
  DateTimeFieldPickerMode toDateTimePickerMode() {
    if (this == DateInputMode.date) {
      return DateTimeFieldPickerMode.date;
    } else if (this == DateInputMode.time) {
      return DateTimeFieldPickerMode.time;
    } else {
      return DateTimeFieldPickerMode.dateAndTime;
    }
  }
}
