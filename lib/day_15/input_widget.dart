import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppkd_b6/constant/app_image.dart';
import 'package:ppkd_b6/utils/button.dart';

class InputWidgetDay15 extends StatefulWidget {
  const InputWidgetDay15({super.key});

  @override
  State<InputWidgetDay15> createState() => _InputWidgetDay15State();
}

class _InputWidgetDay15State extends State<InputWidgetDay15> {
  bool isCheck = false;
  bool isCheckMeja = false;
  bool isSwitch = false;
  String? selectedDropdown;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSwitch ? Colors.amber : Colors.blue,
      child: Column(
        children: [
          Text("CheckBox"),
          Checkbox(
            value: isCheck,
            onChanged: (bool? value) {
              setState(() {});
              isCheck = value ?? false;
              print(value);
              print(isCheck);
            },
          ),
          Text(isCheck ? "Sudah checklist" : "Belum Checklist"),
          CheckboxListTile(
            value: isCheck,
            title: Text("Bersihin Komputer"),
            onChanged: (bool? value) {
              setState(() {});
              isCheck = value ?? false;
              print(value);
              print(isCheck);
            },
          ),
          CheckboxListTile(
            value: isCheckMeja,
            title: Text(
              "Bersihin Meja, Bersihin Meja, Bersihin Meja, Bersihin Meja",
            ),
            activeColor: Colors.red,
            checkColor: Colors.black,
            onChanged: (bool? value) {
              setState(() {});
              isCheckMeja = value ?? false;
              print(value);
              print(isCheck);
            },
          ),

          Text("Switch"),
          Switch(
            value: isSwitch,
            onChanged: (bool? value) {
              setState(() {});
              isSwitch = value ?? false;
              print(value);
              print(isSwitch);
            },
          ),
          SwitchListTile(
            value: isCheckMeja,
            title: Text(
              "Bersihin Meja, Bersihin Meja, Bersihin Meja, Bersihin Meja",
            ),
            activeThumbColor: Colors.red,
            // checkColor: Colors.black,
            onChanged: (bool? value) {
              setState(() {});
              isCheckMeja = value ?? false;
              print(value);
              print(isCheck);
            },
          ),
          Text(isSwitch ? "Sudah Hidup" : "Belum Hidup"),
          Row(
            children: [
              isSwitch
                  ? Container(height: 100, width: 80, color: Colors.red)
                  : Container(height: 100, width: 80, color: Colors.white),
            ],
          ),
          Text("Dropdwon"),
          DropdownButton<String>(
            value: selectedDropdown,
            items: ["Merah", "Kuning", "Hijau"].map((String val) {
              return DropdownMenuItem(value: val, child: Text(val));
            }).toList(),
            onChanged: (String? value) {
              setState(() {});
              selectedDropdown = value;
            },
          ),
          // DropdownButtonFormField<String>(
          //   decoration: InputDecoration(
          //     fillColor: Colors.grey[300],
          //     filled: true,
          //   ),
          //   initialValue: selectedDropdown,
          //   items: ["Merah", "Kuning", "Hijau"].map((String val) {
          //     return DropdownMenuItem(
          //       value: val,
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Text(
          //             val,
          //             style: TextStyle(
          //               color: selectedDropdown == "Merah"
          //                   ? Colors.red
          //                   : Colors.black,
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   }).toList(),
          //   onChanged: (String? value) {
          //     setState(() {});
          //     selectedDropdown = value;
          //   },
          // ),
          // Row(
          //   children: [
          //     selectedDropdown == "Merah"
          //         ? Container(height: 100, width: 80, color: Colors.red)
          //         : selectedDropdown == "Kuning"
          //         ? Container(height: 100, width: 80, color: Colors.black)
          //         : Container(height: 100, width: 80, color: Colors.white),
          //   ],
          // ),
          Text("DateTime"),
          ButtonWithIcon(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },

            text: "Pilih Tanggal",
            image: AppImage.google,
          ),
          Text(
            DateFormat(
              'EEE, dd MMMM yyyy',
              'id_ID',
            ).format(selectedDate ?? DateTime.now()),
          ),

          Text("DateTime"),
          ButtonWithIcon(
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) {
                setState(() {
                  selectedTime = picked;
                });
              }
            },

            text: "Pilih Jam",
            image: AppImage.fb,
          ),
          Text(selectedTime == null ? "" : selectedTime!.format(context)),
        ],
      ),
    );
  }
}
