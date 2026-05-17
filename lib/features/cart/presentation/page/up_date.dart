import 'package:flutter/material.dart';
import '../widgets/up_date_widget.dart';

class UpDate {
  static void showPicker(BuildContext context, Function(DateTime, String) onSelected) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: UpDateWidget(onDateTimeSelected: onSelected),
        );
      },
    );
  }
}