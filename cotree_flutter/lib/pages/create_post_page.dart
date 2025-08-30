import 'dart:io';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/models/file_handling.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late UserView userview;
  bool isLoading = true;
  bool isSubmitting = false;
  TextEditingController content = TextEditingController();
  List<String> filePaths = [];
  List<String> media = [];
  List<File?> _selectedFile = [];

  void getBuildData() async {
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);
    setState(() {
      userview = user;
      isLoading = false;
    });
  }

  Future<void> uploadAllFiles() async {
    for (int i = 0; i < _selectedFile.length; i++) {
      String url = await FileHandling().uploadFile(
          "posts/${userview.userId}/${_selectedFile[i]!.path}",
          _selectedFile[i]!);
      media.add(url);
    }
  }

  void removeImage(int index) {
    setState(() {
      filePaths.removeAt(index);
      _selectedFile.removeAt(index);
    });
  }

  void _openMediaSlider(BuildContext context, int initialIndex) {
    final controller = CarouselSliderController();
    final items = filePaths.map((path) {
      return Image.file(
        File(path),
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey,
          child: const Icon(Icons.broken_image),
        ),
      );
    }).toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: CarouselSlider(
          items: items,
          carouselController: controller,
          options: CarouselOptions(
            initialPage: initialIndex,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            autoPlay: false,
            height: double.infinity,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => debugPrint('Page $index'),
          ),
        ),
      );
    }));
  }

  Widget _buildImageWithRemoveButton(String imagePath, int index) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _openMediaSlider(context, index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                File(imagePath),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => removeImage(index),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          ),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsText(
                      displayString: "Upload Post",
                      fontSize: 18,
                      headColor: true,
                      bold: true,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          AbsAvatar(radius: 22, avatarUrl: userview.avatar),
                          const SizedBox(width: 8),
                          AbsText(
                            displayString: userview.name,
                            fontSize: 15,
                            bold: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    AbsMinimalBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AbsMultilineTextfield(
                                  hintText: "write your post...",
                                  controller: content,
                                  maxLines: 10,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final List<XFile> images =
                                      await picker.pickMultiImage();
                                  if (images.isNotEmpty) {
                                    setState(() {
                                      for (var image in images) {
                                        filePaths.add(image.path);
                                        _selectedFile.add(File(image.path));
                                      }
                                    });
                                  }
                                },
                                icon: const Icon(Icons.image_outlined),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    if (filePaths.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      AbsMinimalBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AbsText(
                              displayString: "Selected Images",
                              fontSize: 14,
                              bold: true,
                            ),
                            const SizedBox(height: 8),
                            ReorderableWrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              needsLongPressDraggable:
                                  true, // drag on long press
                              onReorder: (oldIndex, newIndex) {
                                setState(() {
                                  final file = filePaths.removeAt(oldIndex);
                                  final selFile =
                                      _selectedFile.removeAt(oldIndex);

                                  filePaths.insert(newIndex, file);
                                  _selectedFile.insert(newIndex, selFile);
                                });
                              },
                              children: List.generate(
                                filePaths.length,
                                (index) => _buildImageWithRemoveButton(
                                    filePaths[index], index),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: AbsButtonPrimary(
                            onPressed: () async {
                              if (!isSubmitting) {
                                setState(() {
                                  isSubmitting = true;
                                });
                                if (content.text.isEmpty) {
                                  setState(() {
                                    isSubmitting = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const AbsText(
                                      displayString: "Post cannot be empty!",
                                      fontSize: 15,
                                      headColor: true,
                                      bold: true,
                                    ),
                                  ));
                                  return;
                                }
                                if (_selectedFile.isNotEmpty) {
                                  await uploadAllFiles();
                                }
                                await client.post.createPost(
                                  sessionManager.signedInUser!.id,
                                  content.text,
                                  media,
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const AbsText(
                                    displayString:
                                        "Post Uploaded Successfully!",
                                    fontSize: 15,
                                    headColor: true,
                                    bold: true,
                                  ),
                                ));
                              }
                            },
                            text: "Upload",
                            isLoading: isSubmitting,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
