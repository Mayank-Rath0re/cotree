import 'dart:io';
import 'dart:typed_data';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/authgate.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetupB extends StatefulWidget {
  const ProfileSetupB({super.key});

  @override
  State<ProfileSetupB> createState() => _ProfileSetupBState();
}

class _ProfileSetupBState extends State<ProfileSetupB> {
  int activeCustomTextField = -1;
  File? _selectedImage;
  DateTime? originDate;
  List<CustomDetails> customDescription = [];
  TextEditingController aboutController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController customTitleController = TextEditingController();
  TextEditingController customDescController = TextEditingController();

  Widget avatarImage() {
    if (_selectedImage == null) {
      return const AbsOrgAvatar(radius: 50, avatarUrl: "");
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(_selectedImage!),
      );
    }
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Provider.of<ThemeProvider>(context).headColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        originDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            title: const AbsText(
              displayString: "Profile Setup",
              fontSize: 20,
              headColor: true,
              bold: true,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Avatar and Organization Name Section
                      _buildAvatarSection(),

                      const SizedBox(height: 24),

                      // Origin Date Section
                      _buildOriginDateSection(),

                      const SizedBox(height: 24),

                      // Headline Section
                      _buildHeadlineSection(),

                      const SizedBox(height: 24),

                      // About Section
                      _buildAboutSection(),

                      const SizedBox(height: 24),

                      // Custom Information Section
                      _buildCustomInformationSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ));
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null) {
              String? filePath = result.files.single.path;
              if (filePath != null) {
                setState(() {
                  _selectedImage = File(filePath);
                });
              }
            }
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              avatarImage(),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).headColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Provider.of<ThemeProvider>(context).mainColor,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const AbsText(
          displayString: "Organization Profile",
          fontSize: 16,
          headColor: true,
        ),
      ],
    );
  }

  Widget _buildOriginDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AbsText(
          displayString: "Origin Date",
          fontSize: 18,
          headColor: true,
          bold: true,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).mainColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (originDate != null) ...[
                AbsText(
                  displayString: "${originDate!.month} - ${originDate!.year}",
                  fontSize: 16,
                ),
              ] else ...[
                const AbsText(
                  displayString: "Select origin date",
                  fontSize: 16,
                ),
              ],
              ElevatedButton(
                onPressed: () async {
                  // This is in order to get the selected date.
                  _pickDate();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Provider.of<ThemeProvider>(context).headColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const AbsText(
                  displayString: "Select Date",
                  fontSize: 16,
                  headColor: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeadlineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AbsText(
          displayString: "Headline",
          fontSize: 18,
          headColor: true,
          bold: true,
        ),
        const SizedBox(height: 8),
        AbsTextfield(
          hintText: "Enter your organization headline...",
          controller: headlineController,
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AbsText(
          displayString: "About",
          fontSize: 18,
          headColor: true,
          bold: true,
        ),
        const SizedBox(height: 8),
        AbsMultilineTextfield(
          hintText: "Describe your organization...",
          controller: aboutController,
          maxLines: 6,
        ),
      ],
    );
  }

  Widget _buildCustomInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AbsText(
              displayString: "Custom Information",
              fontSize: 18,
              headColor: true,
              bold: true,
            ),
            AbsButtonPrimary(
              onPressed: () {
                setState(() {
                  activeCustomTextField = customDescription.length;
                  customDescription.add(CustomDetails(
                    title: "New Section",
                    description: "Add your custom information here...",
                    images: [],
                  ));
                });
              },
              text: "Add",
              fontSize: 14,
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (customDescription.isEmpty) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).mainColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const AbsText(
              displayString:
                  "No custom information added yet. Tap 'Add' to create a new section.",
              fontSize: 16,
            ),
          ),
        ] else ...[
          for (int i = 0; i < customDescription.length; i++) ...[
            if (i == activeCustomTextField) ...[
              _buildCustomInfoEditForm(i),
            ] else ...[
              _buildCustomInfoDisplay(i),
            ],
            const SizedBox(height: 16),
          ],
        ],
      ],
    );
  }

  Widget _buildCustomInfoEditForm(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).mainColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          AbsTextfield(
            hintText: "Title",
            controller: customTitleController,
          ),
          const SizedBox(height: 12),
          AbsMultilineTextfield(
            hintText: "Description",
            controller: customDescController,
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    activeCustomTextField = -1;
                  });
                },
                child: const AbsText(
                  displayString: "Cancel",
                  fontSize: 16,
                  headColor: true,
                ),
              ),
              const SizedBox(width: 8),
              AbsButtonPrimary(
                onPressed: () {
                  setState(() {
                    activeCustomTextField = -1;
                    customDescription[index].title = customTitleController.text;
                    customDescription[index].description =
                        customDescController.text;
                  });
                },
                text: "Save",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCustomInfoDisplay(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).mainColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AbsText(
                  displayString: customDescription[index].title,
                  fontSize: 18,
                  headColor: true,
                  bold: true,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    activeCustomTextField = index;
                    customTitleController.text = customDescription[index].title;
                    customDescController.text =
                        customDescription[index].description;
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: Provider.of<ThemeProvider>(context).headColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    customDescription.removeAt(index);
                    if (activeCustomTextField == index) {
                      activeCustomTextField = -1;
                    } else if (activeCustomTextField > index) {
                      activeCustomTextField--;
                    }
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Provider.of<ThemeProvider>(context).headColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AbsText(
            displayString: customDescription[index].description,
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).mainColor,
        border: Border(
          top: BorderSide(
            color: Provider.of<ThemeProvider>(context).secondaryColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () async {
              await client.account.setupProfileB(
                "",
                "",
                sessionManager.signedInUser!.id!,
                originDate ?? DateTime.now(),
                customDescription,
                null,
              );
              await Constants().getOrSetUserView(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            },
            child: const AbsText(
              displayString: "Skip",
              fontSize: 17,
              headColor: true,
            ),
          ),
          const Spacer(),
          AbsButtonPrimary(
            onPressed: () async {
              if (_selectedImage != null) {
                var bytes = await _selectedImage!.readAsBytes();
                ByteData byteData = ByteData.view(bytes.buffer);
                await client.account.setupProfileB(
                  headlineController.text,
                  aboutController.text,
                  sessionManager.signedInUser!.id!,
                  originDate ?? DateTime.now(),
                  customDescription,
                  byteData,
                );
              } else {
                await client.account.setupProfileB(
                  headlineController.text,
                  aboutController.text,
                  sessionManager.signedInUser!.id!,
                  originDate ?? DateTime.now(),
                  customDescription,
                  null,
                );
              }
              await Constants().getOrSetUserView(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            },
            text: "Finish Setup",
          ),
        ],
      ),
    );
  }
}
