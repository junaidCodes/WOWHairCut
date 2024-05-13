import 'package:flutter/material.dart';
import 'dart:async';

import 'package:wowcut/Utils/app_colors.dart';

class Fluttertoast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static void showToast(BuildContext context, String message) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _overlayEntry = _createOverlayEntry(context, message);
    Overlay.of(context).insert(_overlayEntry!);

    _timer = Timer(const Duration(seconds: 2), () {
      _overlayEntry?.remove();
    });
  }

  static void cancelToast() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
    }
  }

  static OverlayEntry _createOverlayEntry(
      BuildContext context, String message) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width - 200,
        left: MediaQuery.of(context).size.width * 0.25,
        child: Material(
          color: AppColors.primaryColor,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                message,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
