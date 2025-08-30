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
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  final UserView userView;
  const ProfileEditPage({super.key, required this.userView});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? _selectedImage;
  late Individual indivData;
  TextEditingController nameController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  String avatarUrl = "";
  bool isLoading = true;

  Future<String?> _uploadAvatarIfNeeded() async {
    if (_selectedImage == null) return null;
    String url = await FileHandling()
        .uploadFile("avatar/${widget.userView.userId}.png", _selectedImage!);
    return url;
  }

  void getBuildData() async {
    var indiv = await client.account.getIndividualData(widget.userView.userId);
    setState(() {
      indivData = indiv;
      nameController.text = widget.userView.name;
      headlineController.text = widget.userView.headline;
      aboutController.text = indiv.bio;
      avatarUrl = widget.userView.avatar; // always work with local avatarUrl
      if (indiv.residence != null) {
        residenceController.text = indiv.residence!;
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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

                    // Avatar section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: _selectedImage != null
                                  ? FileImage(_selectedImage!)
                                  : (avatarUrl.isNotEmpty
                                      ? NetworkImage(avatarUrl)
                                      : null) as ImageProvider<Object>?,
                              child:
                                  (_selectedImage == null && avatarUrl.isEmpty)
                                      ? const Icon(Icons.person, size: 40)
                                      : null,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                AbsButtonSecondary(
                                    roundedBorder: true,
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform
                                              .pickFiles(type: FileType.image);
                                      if (result != null &&
                                          result.files.single.path != null) {
                                        setState(() {
                                          _selectedImage =
                                              File(result.files.single.path!);
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.change_circle),
                                    text: "Change Profile"),
                                if (avatarUrl.isNotEmpty ||
                                    _selectedImage != null) ...[
                                  const SizedBox(width: 10),
                                  AbsButtonSecondary(
                                      roundedBorder: true,
                                      onPressed: () {
                                        setState(() {
                                          avatarUrl = "";
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

                    const SizedBox(height: 20),

                    // Form fields
                    const AbsText(
                        displayString: "Name", fontSize: 16, headColor: true),
                    AbsTextfield(hintText: "name", controller: nameController),
                    const SizedBox(height: 10),

                    const AbsText(
                        displayString: "Headline",
                        fontSize: 16,
                        headColor: true),
                    AbsMultilineTextfield(
                        hintText: "headline",
                        controller: headlineController,
                        minLines: 2,
                        maxLines: 4),
                    const SizedBox(height: 10),

                    const AbsText(
                        displayString: "About", fontSize: 16, headColor: true),
                    AbsMultilineTextfield(
                        hintText: "about",
                        controller: aboutController,
                        minLines: 3,
                        maxLines: 7),
                    const SizedBox(height: 10),

                    const AbsText(
                        displayString: "Residence",
                        fontSize: 16,
                        headColor: true),
                    AbsMultilineTextfield(
                        hintText: "residence",
                        controller: residenceController,
                        minLines: 3,
                        maxLines: 7),
                    const SizedBox(height: 20),

                    // Save button
                    Row(
                      children: [
                        Expanded(
                          child: AbsButtonPrimary(
                            onPressed: () async {
                              // upload avatar if needed
                              String? newAvatarUrl =
                                  await _uploadAvatarIfNeeded();
                              if (newAvatarUrl != null) {
                                avatarUrl = newAvatarUrl;
                              }

                              UserView updated = UserView(
                                id: widget.userView.id,
                                userId: widget.userView.userId,
                                name: nameController.text,
                                headline: headlineController.text,
                                avatar: avatarUrl,
                                accountType: widget.userView.accountType,
                              );

                              // Update server
                              await client.account.updateIndivAccount(
                                  updated,
                                  aboutController.text,
                                  residenceController.text,
                                  indivData.gender,
                                  indivData.dob,
                                  indivData.contact);
                              final userCache =
                                  context.read<UserCacheService>();
                              await userCache.updateUserView(updated);

                              Navigator.pop(context, 'saved');
                            },
                            text: "Save Changes",
                          ),
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
