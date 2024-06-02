import 'package:flutter/material.dart';


class Example01 extends StatefulWidget {
  const Example01({super.key});

  @override
  State<Example01> createState() => _Example01State();
}

class _Example01State extends State<Example01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Dropdown'),
      ),
      body: Column(
        children: [
          // Expanded(
          //   flex: 1,
          //   child: DropdownButtonFormField(
          //     onSaved: (section) => selectedValue,
          //     validator: (value) => value == null ? "Select a country" : null,
          //     items: menuItems,
          //     onChanged: (String? value) {
          //       setState(() {
          //         selectedValue = value!;
          //       });
          //     },
          //   ),
          // ),
          // Text('${selectedTime.hour} : ${selectedTime.minute}'),
          // ElevatedButton(
          //   onPressed: () async {
          //     final TimeOfDay? timeofday = await showTimePicker(
          //       context: context,
          //       initialTime: selectedTime,
          //       initialEntryMode: TimePickerEntryMode.dial,
          //     );
          //     if (timeofday != null) {
          //       setState(() {
          //         selectedTime = timeofday;
          //       });
          //     }
          //   },
          //   child: Text('Select Time'),
          // ),
        ],
      ),
    );
  }
}
