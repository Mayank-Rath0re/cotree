import 'dart:io';
import 'dart:typed_data';

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_document_box.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/file_handling.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DocumentPage extends StatefulWidget {
  final int spaceId;
  final int projectId;
  final Member memberData;
  const DocumentPage(
      {super.key,
      required this.spaceId,
      required this.projectId,
      required this.memberData});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  bool filePicked = false;
  List<Documents> documents = [];
  List<Member> memberViews = [];
  bool isLoading = true;
  PlatformFile? file;
  String? fileName;
  ByteData? byteData;

  void buildData() async {
    var docs = await client.project.fetchDocuments(widget.projectId);
    var memViews =
        await client.space.fetchMemberByMemberIds(docs.map((document) {
      return document.uploadedBy;
    }).toList());

    setState(() {
      documents = docs;
      memberViews = memViews;
      isLoading = false;
    });
  }

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true, // ensure bytes are available for web
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        file = result.files.first;
        fileName = file!.name;
        byteData = file!.bytes!.buffer.asByteData();
        filePicked = true;
      });
    } else {
      print('File picking cancelled');
    }
  }

  Future<void> uploadFile() async {
    try {
      await FileHandling().uploadFile(
          "${widget.spaceId}/${widget.projectId}/${file!.name}",
          File(file!.path!));
    } catch (e) {
      print('Upload failed: $e');
    }
  }

  @override
  void initState() {
    buildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AbsText(
                      displayString: "Documents",
                      fontSize: 22,
                      headColor: true,
                      bold: true),
                  AbsButtonSecondary(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: filePicked
                                          ? [
                                              AbsDocumentBox(
                                                  fileName: fileName!,
                                                  memberView: widget.memberData,
                                                  time: DateTime.now())
                                            ]
                                          : [
                                              AbsButtonPrimary(
                                                  onPressed: pickFile,
                                                  text: "Select File")
                                            ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          if (filePicked) {
                                            setState(() {
                                              filePicked = false;
                                            });
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: const AbsText(
                                            displayString: "Dismiss",
                                            fontSize: 17)),
                                    AbsButtonPrimary(
                                        onPressed: () {
                                          if (filePicked) {
                                            uploadFile();
                                            setState(() {
                                              filePicked = false;
                                              file = null;
                                              fileName = null;
                                              byteData = null;
                                            });
                                            Navigator.pop(context);
                                          }
                                        },
                                        text: "Upload")
                                  ],
                                ));
                      },
                      text: "Upload",
                      icon: const Icon(Icons.file_upload_outlined, size: 30))
                ],
              ),
              const SizedBox(height: 20),
              if (isLoading) ...const [
                CircularProgressIndicator()
              ] else ...[
                if (documents.isEmpty) ...[
                  const AbsMinimalBox(
                      child: SizedBox(
                    height: 80,
                    child: Center(
                      child: AbsText(
                          displayString: "No Documents Uploaded Right Now",
                          fontSize: 18),
                    ),
                  )),
                ] else ...[
                  for (int i = 0; i < documents.length; i++) ...[
                    AbsDocumentBox(
                        fileName: documents[i].title,
                        memberView: memberViews[i],
                        time: documents[i].uploadedAt),
                    const SizedBox(height: 10),
                  ]
                ]
              ]
            ],
          ),
        ));
  }
}
