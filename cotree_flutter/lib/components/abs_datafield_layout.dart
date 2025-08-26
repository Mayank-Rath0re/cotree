import 'package:cotree_flutter/components/abs_datepicker.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AbsDatafieldLayout extends StatefulWidget {
  const AbsDatafieldLayout({super.key});

  @override
  State<AbsDatafieldLayout> createState() => _AbsDatafieldLayoutState();
}

class _AbsDatafieldLayoutState extends State<AbsDatafieldLayout> {
  TextEditingController profTitle = TextEditingController();
  TextEditingController profInstitute = TextEditingController();
  String data = "";
  DateTime? date1;
  DateTime? date2;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Important: make it wrap content
            children: [
              const SizedBox(height: 20),
              const AbsText(
                displayString: "Upload Information",
                fontSize: 18,
                headColor: true,
                bold: true,
              ),
              const SizedBox(height: 20),
              const AbsText(
                  displayString: "Title", fontSize: 15, headColor: true),
              const SizedBox(height: 5),
              AbsTextfield(hintText: "Title", controller: profTitle),
              const SizedBox(height: 8),
              const AbsText(
                  displayString: "Institute", fontSize: 15, headColor: true),
              const SizedBox(height: 5),
              AbsTextfield(hintText: "Institute", controller: profInstitute),
              const SizedBox(height: 20),
              const AbsText(
                  displayString: "Start Date", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (date1 != null) ...[
                    AbsText(
                        displayString: DateFormat("MM / yyyy").format(date1!),
                        fontSize: 16,
                        bold: true)
                  ],
                  AbsDatepicker(onDatePicked: (date) {
                    setState(() {
                      date1 = date;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AbsText(
                      displayString: "Currently Ongoing",
                      fontSize: 18,
                      bold: true),
                  Switch(
                      activeColor:
                          Provider.of<ThemeProvider>(context).headColor,
                      value: isActive,
                      onChanged: (val) {
                        setState(() {
                          isActive = !isActive;
                        });
                      })
                ],
              ),
              if (!isActive) ...[
                const AbsText(
                    displayString: "End Date", fontSize: 18, bold: true),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (date2 != null) ...[
                      AbsText(
                          displayString: DateFormat("MM / yyyy").format(date2!),
                          fontSize: 16,
                          bold: true)
                    ],
                    AbsDatepicker(onDatePicked: (date) {
                      setState(() {
                        date2 = date;
                      });
                    }),
                  ],
                ),
              ],

              // Your date pickers and switches here...
              // Make sure to not use Spacer()

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (profTitle.text.isNotEmpty &&
                          profInstitute.text.isNotEmpty &&
                          date1 != null) {
                        if (!isActive && (date2 != null)) {
                          data =
                              "${profTitle.text}\n${profInstitute.text}\n${date1!.month}/${date1!.year}\n${date2!.month}/${date2!.year}";
                        } else {
                          data =
                              "${profTitle.text}\n${profInstitute.text}\n${date1!.month}/${date1!.year}\nPresent";
                        }
                        Navigator.pop(context, data);
                      }
                    },
                    child: const AbsText(displayString: "Submit", fontSize: 19),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const AbsText(displayString: "Cancel", fontSize: 19),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
