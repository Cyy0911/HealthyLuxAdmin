import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

class BuildTextField {
  buildTextField(TextEditingController controller, String labelText,
      final multipleline, bool edit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: edit ? AppTheme.lightblueColor : AppTheme.bluegreenColor,
          border: Border.all(color: AppTheme.blueColor)),
      child: TextField(
        controller: controller,
        style: AppTheme.defaultTextStyle16White(false),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: AppTheme.defaultTextStyle16White(false),
            border: InputBorder.none),
        maxLines: multipleline ? 7 : null,
      ),
    );
  }
}
