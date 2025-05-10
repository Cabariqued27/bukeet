import 'package:bukeet/widgets/alert/confirmation_reservation_alert_widget.dart';
import 'package:bukeet/widgets/alert/message_alert_widget.dart';
import 'package:bukeet/widgets/alert/single_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertUtils {
  static void showSingleAlert({
    required String title,
    required String positiveTitle,
    required String negativeTitle,
    required VoidCallback positiveAction,
    required VoidCallback negativeAction,
    bool? barrierDismissible,
  }) async {
    await showDialog(
      useSafeArea: false,
      context: Get.context!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) => AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: SingleAlertWidget(
          title: title,
          positiveAction: positiveAction,
          negativeAction: negativeAction,
          positiveTitle: positiveTitle,
          negativeTitle: negativeTitle,
        ),
        contentPadding: const EdgeInsets.all(0.0),
        insetPadding: const EdgeInsets.all(0.0),
      ),
    );
    return;
  }

  static void showMessageAlert({
    required String title,
    required String buttonTitle,
    required VoidCallback onPressed,
    bool? barrierDismissible,
  }) async {
    await showDialog(
      useSafeArea: false,
      context: Get.context!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) => AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: MessageAlertWidget(
          title: title,
          buttonTitle: buttonTitle,
          onPressed: onPressed,
        ),
        contentPadding: const EdgeInsets.all(0.0),
        insetPadding: const EdgeInsets.all(0.0),
      ),
    );
    return;
  }

  static void showComnfirmReservationAlert({
    required String date,
    required String hour,
    required String location,
    required String price,
    required VoidCallback positiveAction,
    required VoidCallback negativeAction,
    bool? barrierDismissible,
  }) async {
    await showDialog(
      useSafeArea: false,
      context: Get.context!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) => AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: ConfirmReservationAlertWidget(
          date: date,
          hour: hour,
          location: location,
          price: price,
          positiveAction: positiveAction,
          negativeAction: negativeAction,
        ),
        contentPadding: const EdgeInsets.all(0.0),
        insetPadding: const EdgeInsets.all(0.0),
      ),
    );
    return;
  }

  static void showSingleMessageAlert({
    required String title,
    required String buttonTitle,
    required VoidCallback onPressed,
    bool? barrierDismissible,
  }) async {
    await showDialog(
      useSafeArea: false,
      context: Get.context!,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) => AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: MessageAlertWidget(
          title: title,
          buttonTitle: buttonTitle,
          onPressed: onPressed,
        ),
        contentPadding: const EdgeInsets.all(0.0),
        insetPadding: const EdgeInsets.all(0.0),
      ),
    );
  }
}


