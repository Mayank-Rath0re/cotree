import 'dart:io';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/models/file_handling.dart';
import 'package:cotree_flutter/pages/authgate.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileSetupI extends StatefulWidget {
  const ProfileSetupI({super.key});

  @override
  State<ProfileSetupI> createState() => _ProfileSetupIState();
}

class _ProfileSetupIState extends State<ProfileSetupI> {
  DateTime? dob;
  TextEditingController headingController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int genderValue = 0;
  File? _selectedImage;
  bool isLoading = false;

  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Provider.of<ThemeProvider>(context).headColor,
                    width: 3,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color:
                                Provider.of<ThemeProvider>(context).mainColor,
                          ),
                          child: Icon(
                            Icons.person_add_rounded,
                            size: 50,
                            color:
                                Provider.of<ThemeProvider>(context).headColor,
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeProvider>(context).headColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      _selectedImage != null ? Icons.edit : Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_selectedImage != null) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _selectedImage = null;
                });
              },
              icon: const Icon(Icons.delete_outline, size: 18),
              label: const Text('Remove Photo'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return AbsMinimalBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Provider.of<ThemeProvider>(context).contrastColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildGenderOption(
                  value: 0,
                  label: 'Male',
                  icon: Icons.male,
                  isSelected: genderValue == 0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildGenderOption(
                  value: 1,
                  label: 'Female',
                  icon: Icons.female,
                  isSelected: genderValue == 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption({
    required int value,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          genderValue = value;
        });
      },
      child: AbsMinimalBox(
        layer: 2,
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return AbsMinimalBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of Birth',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Provider.of<ThemeProvider>(context).contrastColor,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _pickDate,
            child: AbsMinimalBox(
              layer: 2,
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Provider.of<ThemeProvider>(context).headColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  AbsText(
                    displayString: dob != null
                        ? DateFormat("MMMM dd, yyyy").format(dob!)
                        : 'Select your date of birth',
                    fontSize: 15,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return AbsMinimalBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Provider.of<ThemeProvider>(context).contrastColor,
            ),
          ),
          const SizedBox(height: 16),
          AbsTextfield(hintText: hint, controller: controller),
        ],
      ),
    );
  }

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
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
        dob = picked;
      });
    }
  }

  Future<void> _submitProfile() async {
    if (headingController.text.trim().isEmpty ||
        bioController.text.trim().isEmpty ||
        residenceController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        dob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserView user = await client.account.setupProfileI(
        headingController.text.trim(),
        bioController.text.trim(),
        sessionManager.signedInUser!.id,
        genderValue == 0 ? "M" : "F",
        residenceController.text.trim(),
        dob,
        phoneController.text.trim(),
      );

      if (_selectedImage != null) {
        String url = await FileHandling().uploadFile(
          'avatar/${user.userId}.png',
          _selectedImage!,
        );
        await client.account.updateAvatar(user, url);
      }

      if (mounted) {
        await Constants().getOrSetUserView(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthGate()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Provider.of<ThemeProvider>(context).contrastColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Complete Your Profile',
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).contrastColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildAvatarSection(),
                    const SizedBox(height: 32),
                    _buildGenderSelector(),
                    const SizedBox(height: 20),
                    _buildDatePicker(),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Phone Number',
                      hint: 'Enter your phone number',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Professional Headline',
                      hint: 'e.g., Software Engineer, Marketing Manager',
                      controller: headingController,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About You",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Provider.of<ThemeProvider>(context)
                                .contrastColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AbsMultilineTextfield(
                          hintText:
                              "Tell us about yourself, your experience, and what you're passionate about...",
                          controller: bioController,
                          minLines: 4,
                          maxLines: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Location',
                      hint: 'City, State, Country',
                      controller: residenceController,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            AbsMinimalBox(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await client.account.setupProfileI("", "",
                            sessionManager.signedInUser!.id, "", "", null, "");
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AuthGate()),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: Colors.grey[600],
                      ),
                      child: const Text(
                        'Skip for now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Provider.of<ThemeProvider>(context).headColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Complete Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
