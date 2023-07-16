import 'package:flutter/material.dart';

class CalendarioDialog extends StatelessWidget {
  const CalendarioDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final diaPosterior = DateTime.now().add(const Duration(days: 1));

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      DatePickerDialog(
          initialEntryMode: DatePickerEntryMode.calendar,
          firstDate: diaPosterior,
          initialDate: diaPosterior,
          lastDate: DateTime(2025)),
      const SizedBox(height: 40)
    ]);
  }
}
