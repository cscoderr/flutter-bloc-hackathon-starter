import 'dart:io';

import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension SizeX on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get minScreenWidth => screenWidth / 100;
  double get minScreenHeight => screenHeight / 100;
  double get screenSymmetricHorizontal =>
      MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right;
  double get screenSymmetricVertical =>
      MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom;
  double get minBlockHorizontal =>
      (screenWidth - screenSymmetricHorizontal) / 100;
  double get minBlockVertical => (screenHeight - screenSymmetricVertical) / 100;

  void back() => Navigator.maybePop(this);

  void showErrorMessage(String error) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: CsColors.white),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              child: Text(
                error,
                style: CsTextStyle.smallText.copyWith(
                  fontSize: 16,
                  color: CsColors.white,
                ),
              ),
            )
          ],
        ),
        dismissDirection: DismissDirection.startToEnd,
        margin: const EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: CsColors.white),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              child: Text(
                message,
                style: CsTextStyle.smallText.copyWith(
                  fontSize: 16,
                  color: CsColors.white,
                ),
              ),
            )
          ],
        ),
        dismissDirection: DismissDirection.startToEnd,
        margin: const EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> showDeleteDialog(
    String title,
    String message,
    VoidCallback onPressed,
  ) {
    return showDialog<void>(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: CsColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.all(20),
          children: <Widget>[
            Text(
              title,
              style: CsTextStyle.headline4.copyWith(
                fontWeight: CsFontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(message, style: CsTextStyle.bodyText1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: back,
                  child: Text(
                    'Cancel',
                    style: CsTextStyle.headline5.copyWith(
                      fontWeight: CsFontWeight.semiBold,
                      fontSize: 20,
                      color: CsColors.danger,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'Delete',
                    style: CsTextStyle.headline5.copyWith(
                      fontWeight: CsFontWeight.semiBold,
                      fontSize: 20,
                      color: CsColors.primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> showLoadingDialog() {
    return showDialog<void>(
      context: this,
      // for testing, for now this will be true, should be changed to false later
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          // for testing, for now this will be true, should be changed to false later
          onWillPop: () async => true,
          child: SimpleDialog(
            //key: key ?? const Key('0'),
            elevation: 0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              if (Platform.isIOS)
                Center(
                  child: Theme(
                      data: ThemeData(
                        cupertinoOverrideTheme: const CupertinoThemeData(
                            brightness: Brightness.dark),
                      ),
                      child: const CupertinoActivityIndicator(
                        radius: 18,
                      )),
                )
              else
                const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: CsColors.primary,
                    strokeWidth: 1.3,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
