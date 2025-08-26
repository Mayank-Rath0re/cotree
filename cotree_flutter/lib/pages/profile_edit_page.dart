import 'dart:io';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/models/file_handling.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final UserView userView;
  final Individual individualData;
  const ProfileEditPage(
      {super.key, required this.userView, required this.individualData});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? _selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  String avatarUrl = "";

  Future<void> updateProfile() async {
    if (_selectedImage == null) return;
    String url = await FileHandling()
        .uploadFile("avatar/${widget.userView.userId}.png", _selectedImage!);
    await client.account.updateAvatar(widget.userView, url);
    setState(() {
      widget.userView.avatar = url;
      avatarUrl = url;
      // After upload, clear the local file so network image is shown
      _selectedImage = null;
    });
  }

  @override
  void initState() {
    nameController.text = widget.userView.name;
    headlineController.text = widget.userView.headline;
    aboutController.text = widget.individualData.bio;
    avatarUrl = widget.userView.avatar;
    if (widget.individualData.residence != null) {
      residenceController.text = widget.individualData.residence!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AbsText(
                  displayString: "Edit Profile",
                  fontSize: 22,
                  bold: true,
                  headColor: true),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      // Show local image if selected, else show network image
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : (widget.userView.avatar.isNotEmpty
                                ? NetworkImage(widget.userView.avatar)
                                : null) as ImageProvider<Object>?,
                        child: (_selectedImage == null &&
                                widget.userView.avatar.isEmpty)
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          AbsButtonSecondary(
                              roundedBorder: true,
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(type: FileType.image);
                                if (result != null) {
                                  String? filePath = result.files.single.path;
                                  if (filePath != null) {
                                    setState(() {
                                      _selectedImage = File(filePath);
                                    });
                                    // Start upload in background
                                    await updateProfile();
                                  }
                                }
                              },
                              icon: const Icon(Icons.change_circle),
                              text: "Change Profile"),
                          if (widget.userView.avatar.isNotEmpty) ...[
                            const SizedBox(width: 10),
                            AbsButtonSecondary(
                                roundedBorder: true,
                                onPressed: () async {
                                  await client.account
                                      .removeAvatar(widget.userView);
                                  setState(() {
                                    widget.userView.avatar = "";
                                    _selectedImage = null;
                                  });
                                },
                                icon: const Icon(Icons.delete),
                                text: "Remove")
                          ],
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const AbsText(
                  displayString: "Name", fontSize: 16, headColor: true),
              const SizedBox(height: 6),
              AbsTextfield(hintText: "name", controller: nameController),
              const SizedBox(height: 10),
              const AbsText(
                  displayString: "Headline", fontSize: 16, headColor: true),
              const SizedBox(height: 6),
              AbsMultilineTextfield(
                  hintText: "headline",
                  controller: headlineController,
                  minLines: 2,
                  maxLines: 4),
              const SizedBox(height: 10),
              const AbsText(
                  displayString: "About", fontSize: 16, headColor: true),
              const SizedBox(height: 6),
              AbsMultilineTextfield(
                  hintText: "about",
                  controller: aboutController,
                  minLines: 3,
                  maxLines: 7),
              const SizedBox(height: 10),
              const AbsText(
                  displayString: "Residence", fontSize: 16, headColor: true),
              const SizedBox(height: 6),
              AbsMultilineTextfield(
                  hintText: "residence",
                  controller: residenceController,
                  minLines: 3,
                  maxLines: 7),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: AbsButtonPrimary(
                          onPressed: () {
                            UserView updated = UserView(
                                id: widget.userView.id,
                                userId: widget.userView.userId,
                                name: nameController.text,
                                headline: headlineController.text,
                                avatar: widget.userView.avatar,
                                accountType: widget.userView.accountType);

                            client.account.updateIndivAccount(updated);
                            Constants().updateUserView(context, updated);
                            Navigator.pop(context, 'saved');
                          },
                          text: "Save Changes")),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
