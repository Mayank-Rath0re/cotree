import 'dart:io';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/models/file_handling.dart';
import 'package:cotree_flutter/pages/main_space_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSpacePage extends StatefulWidget {
  const CreateSpacePage({super.key});

  @override
  State<CreateSpacePage> createState() => _CreateSpacePageState();
}

class _CreateSpacePageState extends State<CreateSpacePage> {
  late UserView userview;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController credentialController = TextEditingController();

  File? _selectedImage;

  bool isSubmitting = false;
  String submitMessage = "";

  void getBuildData() async {
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);
    setState(() {
      userview = user;
    });
  }

  String submissionCheck() {
    if (titleController.text.isEmpty) {
      return "Space Title not defined!";
    } else if (descController.text.isEmpty) {
      return "Space description not provided";
    } else {
      setState(() {
        isSubmitting = true;
      });
      return "";
    }
  }

  Scaffold _scaffoldBuild() {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsText(
                      displayString: "Create New Space",
                      fontSize: 20,
                      bold: true,
                      headColor: true,
                    ),
                    const SizedBox(height: 3),
                    const AbsText(
                        displayString: "Enter details for your workspace",
                        fontSize: 14),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);
                              if (result != null) {
                                String? filePath = result.files.single.path;
                                if (filePath != null) {
                                  setState(() {
                                    _selectedImage = File(filePath);
                                  });
                                }
                              }
                            },
                            child: _selectedImage == null
                                ? const AbsOrgAvatar(radius: 45, avatarUrl: "")
                                : Image.file(_selectedImage!,
                                    height: 90, width: 90, fit: BoxFit.cover))
                      ],
                    ),
                    const AbsText(displayString: "Title", fontSize: 16),
                    const SizedBox(height: 5),
                    AbsTextfield(
                        hintText: "Title", controller: titleController),
                    const SizedBox(height: 20),
                    const AbsText(displayString: "Description", fontSize: 16),
                    const SizedBox(height: 5),
                    AbsMultilineTextfield(
                      hintText: "describe about the space...",
                      border: true,
                      controller: descController,
                      minLines: 3,
                      maxLines: 6,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsText(
                        displayString: "Credentials (Optional)",
                        fontSize: 18,
                        bold: true,
                        headColor: true),
                    const SizedBox(height: 3),
                    const AbsText(
                        displayString:
                            "Members would need to enter credentials before accessing the workspace",
                        fontSize: 14),
                    const SizedBox(height: 20),
                    AbsTextfield(
                      controller: credentialController,
                      hintText: "password/key",
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: AbsButtonPrimary(
                        onPressed: () async {
                          var check = submissionCheck();
                          if (check != "") {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            children: [
                                              const Icon(Icons.cancel_outlined,
                                                  size: 34),
                                              const SizedBox(height: 10),
                                              AbsText(
                                                  displayString: check,
                                                  fontSize: 18)
                                            ],
                                          )),
                                    ));
                          } else {
                            int space;
                            String url = '';
                            if (_selectedImage != null) {
                              url = await FileHandling().uploadFile(
                                  'space/${userview.userId}', _selectedImage!);
                            }
                            space = await client.space.createSpace(
                                sessionManager.signedInUser!.id!,
                                titleController.text,
                                descController.text,
                                url,
                                credentialController.text);

                            // PENDING
                            // create owner member after creating space for creator
                            await client.space
                                .addOwner(userview.userId, space, userview);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainSpacePage(
                                          spaceId: space,
                                          userId: userview.userId,
                                        )));
                          }
                        },
                        text: isSubmitting ? "..." : "Create Workspace"),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffoldBuild();
  }
}
