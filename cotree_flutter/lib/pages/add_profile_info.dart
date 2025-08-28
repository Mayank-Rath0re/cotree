import 'dart:typed_data';

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_datepicker.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddProfileInfo extends StatefulWidget {
  final int profileId;
  final ProfessionalData? profData;
  const AddProfileInfo({super.key, required this.profileId, this.profData});

  @override
  State<AddProfileInfo> createState() => _AddProfileInfoState();
}

class _AddProfileInfoState extends State<AddProfileInfo> {
  List<String> indivOptions = [
    "Education",
    "Experience",
    "Project",
    "Certification"
  ];
  List<IconData> indivIcons = [
    Icons.school_rounded,
    Icons.work,
    Icons.widgets,
    Icons.military_tech
  ];
  int activeIndex = 0;
  int selectedCategoryIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  DateTime? startDate;
  bool currentlyPursuing = false;
  DateTime? endDate;
  TextEditingController urlController = TextEditingController();
  final controller = MultiImagePickerController(
    maxImages: 3,
    picker: (int pickCount, Object? params) async {
      final picker = ImagePicker();
      final picked = await picker.pickMultiImage();
      if (picked.isEmpty) return <ImageFile>[];

      return picked.take(pickCount).map((file) {
        final name = basename(file.path); // import 'package:path/path.dart';
        final ext = name.split('.').last;
        return ImageFile(
          UniqueKey().toString(),
          name: name,
          extension: ext,
          path: file.path,
        );
      }).toList();
    },
  );

  Widget buildOption(
      BuildContext context, Icon icon, String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Provider.of<ThemeProvider>(context).contrastColor,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            AbsText(
              displayString: text,
              fontSize: 17,
            ),
          ],
        ),
      ),
    );
  }

  void clearControllers() {
    setState(() {
      titleController.text = "";
      instituteController.text = "";
      startDate = null;
      endDate = null;
      urlController.text = "";
    });
  }

  void onSubmit(BuildContext context) async {
    if (titleController.text.isNotEmpty &&
        instituteController.text.isNotEmpty &&
        startDate != null &&
        (currentlyPursuing || endDate != null)) {
      // uploading images
      List<String> urls = [];
      var images = controller.images.toList();
      for (int i = 0; i < images.length; i++) {
        var bytes = images[i].bytes;
        ByteData byteData = ByteData.view(bytes!.buffer);
        String url = await client.account.uploadImage(byteData, images[i].name);
        urls.add(url);
      }
      if (widget.profData != null) {
        widget.profData!.title = titleController.text;
        widget.profData!.institute = instituteController.text;
        widget.profData!.startDate = startDate!;
        widget.profData!.endData = endDate;
        widget.profData!.supportingLink = urlController.text;
        widget.profData!.images = urls;
        await client.account.editProfessionalData(widget.profData!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: AbsMinimalBox(
                child: AbsText(
                    displayString: "Information Edited!",
                    fontSize: 16,
                    bold: true))));
        setState(() {
          activeIndex = 0;
        });
      } else {
        await client.account.addProfessionalInfo(
            widget.profileId,
            indivOptions[selectedCategoryIndex],
            titleController.text,
            instituteController.text,
            startDate,
            endDate,
            urlController.text,
            urls);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: AbsText(
                displayString: "Information Added Successfully!",
                fontSize: 16,
                bold: true)));
        setState(() {
          activeIndex = 0;
        });
        clearControllers();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: AbsText(
              displayString: "Please fill all the required details",
              fontSize: 16,
              bold: true)));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.profData != null) {
      activeIndex = 1;
      titleController.text = widget.profData!.title;
      instituteController.text = widget.profData!.institute;
      startDate = widget.profData!.startDate;
      endDate = widget.profData!.endData;
      urlController.text = widget.profData!.supportingLink;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (activeIndex == 0) {
                Navigator.pop(context);
              } else {
                setState(() {
                  activeIndex = 0;
                });
              }
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const AbsText(
            displayString: "Add Profile Info", fontSize: 16, bold: true),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (activeIndex == 0) ...[
              const AbsText(
                displayString: "Add Professional Details",
                fontSize: 16,
                headColor: true,
                bold: true,
              ),
              const SizedBox(height: 20),
              for (int i = 0; i < indivOptions.length; i++) ...[
                buildOption(
                    context,
                    Icon(
                      indivIcons[i],
                      color: Provider.of<ThemeProvider>(context).headColor,
                    ),
                    indivOptions[i], () {
                  setState(() {
                    selectedCategoryIndex = i;
                    activeIndex = 1;
                  });
                }),
                const SizedBox(height: 10),
              ],
            ] else ...[
              Row(
                children: [
                  Icon(
                    indivIcons[selectedCategoryIndex],
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  const SizedBox(width: 10),
                  AbsText(
                    displayString: "Add ${indivOptions[selectedCategoryIndex]}",
                    fontSize: 16,
                    bold: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const AbsText(displayString: "Title", fontSize: 14, bold: true),
              const SizedBox(height: 8),
              AbsTextfield(hintText: "title", controller: titleController),
              const SizedBox(height: 20),
              const AbsText(
                  displayString: "Institute", fontSize: 14, bold: true),
              const SizedBox(height: 8),
              AbsTextfield(
                  hintText: "institute", controller: instituteController),
              const SizedBox(height: 20),
              const AbsText(
                  displayString: "Start Date", fontSize: 14, bold: true),
              const SizedBox(height: 8),
              AbsDatepicker(onDatePicked: (date) {
                setState(() {
                  startDate = date;
                });
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AbsText(
                      displayString: "Currently Active",
                      fontSize: 16,
                      bold: true),
                  Switch(
                      value: currentlyPursuing,
                      onChanged: (val) {
                        setState(() {
                          currentlyPursuing = !currentlyPursuing;
                          endDate = null;
                        });
                      })
                ],
              ),
              const SizedBox(height: 10),
              if (!currentlyPursuing) ...[
                const AbsText(
                    displayString: "End Date", fontSize: 14, bold: true),
                const SizedBox(height: 8),
                AbsDatepicker(onDatePicked: (value) {
                  setState(() {
                    endDate = value;
                  });
                }),
                const SizedBox(height: 20),
              ],
              const AbsText(
                  displayString: "Supporting URL", fontSize: 14, bold: true),
              const SizedBox(height: 8),
              AbsTextfield(hintText: "url", controller: urlController),
              /*
              const SizedBox(height: 20),
              const AbsText(displayString: "Images", fontSize: 14, bold: true),
              const SizedBox(height: 8),
              MultiImagePickerView(
                controller: controller,
                padding: const EdgeInsets.all(5),
                builder: (context, image) {
                  return Image.memory(
                    image.bytes!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  );
                },
              ),
              */
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AbsButtonPrimary(
                        onPressed: () {
                          onSubmit(context);
                        },
                        text: "Submit"),
                  )
                ],
              )
            ]
          ]),
        ),
      ),
    );
  }
}
