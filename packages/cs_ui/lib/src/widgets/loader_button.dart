import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  const LoaderButton({
    Key? key,
    this.text,
    this.onPressed,
    this.color = CsColors.primary,
    this.textColor = CsColors.white,
    this.textSize = 18.0,
    this.elevation = 0.0,
    this.isLoading = false,
    this.loaderColor = Colors.white,
    this.border = const BorderSide(color: CsColors.primary),
  }) : super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final double textSize;
  final double elevation;
  final BorderSide border;
  final bool isLoading;
  final Color loaderColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      minWidth: double.infinity,
      onPressed: onPressed,
      elevation: elevation,
      disabledColor: color.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
        side: onPressed == null
            ? const BorderSide(color: Colors.transparent)
            : border,
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          15,
        ),
        child: isLoading
            ? CircularProgressIndicator(
                backgroundColor: loaderColor,
              )
            : Text(
                text!,
                style: CsTextStyle.caption.copyWith(
                  color: textColor,
                  fontSize: textSize,
                ),
              ),
      ),
    );
  }
}
