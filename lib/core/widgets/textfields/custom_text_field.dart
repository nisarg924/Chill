import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/dimensions.dart';
import '../../utils/style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText, required this.controller, required this.autofillHints, this.keyboardType, this.isNotification, this.focusNode});
  final String hintText;
  final TextEditingController controller;
  final List<String>? autofillHints;
  final TextInputType? keyboardType;
  final bool? isNotification;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimensions.h60,
      width: Dimensions.w293,
      child: TextField(
         onTap: isNotification==true?() async {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (picked != null) {
            controller.text = picked.format(context);
          }
        }:null,
        style: fontStyleBold40,
        keyboardType: keyboardType?? TextInputType.text,
        readOnly: isNotification??false,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
        autofillHints: autofillHints??[AutofillHints.name],
        cursorHeight: Dimensions.h32,
        controller: controller,
        cursorColor: AppColors.textColorBlack,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textFieldBorderColor)),
          border: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textFieldBorderColor)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textFieldBorderColor)),
          hintText: hintText,
          isDense: true,
          hintStyle: fontStyleBold40,
          contentPadding: EdgeInsets.only(bottom: Dimensions.h10)
        ),
      ),
    );
  }
}
