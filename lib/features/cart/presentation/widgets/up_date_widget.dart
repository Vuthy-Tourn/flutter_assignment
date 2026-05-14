import 'package:flutter/material.dart';

class UpDateWidget extends StatefulWidget {
  final Function(DateTime selectedDate, String selectedTime) onDateTimeSelected;

  const UpDateWidget({super.key, required this.onDateTimeSelected});

  @override
  State<UpDateWidget> createState() => _UpDateWidgetState();
}

class _UpDateWidgetState extends State<UpDateWidget> {
  DateTime _focusedDay = DateTime(2025, 1, 4);
  DateTime? _selectedDay = DateTime(2025, 1, 4);
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month and Year Selector
          Row(
            children: [
              Text(
                "January",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_drop_down),
              const SizedBox(width: 10),
              Text(
                "2025",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          const SizedBox(height: 10),

          // Simple Calendar Grid Placeholder
          // For a production app, use 'table_calendar' package here
          CalendarDatePicker(
            initialDate: _focusedDay,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            onDateChanged: (date) {
              setState(() => _selectedDay = date);
            },
          ),

          const Divider(),
          const Text("Select Time", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),

          // Time Input field
          TextField(
            controller: _timeController,
            decoration: InputDecoration(
              hintText: "hh:mm",
              prefixIcon: const Icon(Icons.access_time),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel", style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (_selectedDay != null) {
                    widget.onDateTimeSelected(_selectedDay!, _timeController.text);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                child: const Text("Select", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}