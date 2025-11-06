import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog showCustomDialog({
  required String title,
  required String desc,
  required DialogType type,
  required BuildContext context,
  required Function() onOkPress,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: type,
    animType: AnimType.leftSlide,
    title: title,
    desc: desc,
    btnOkOnPress: onOkPress,
    btnCancelOnPress: () {},
  );
}
