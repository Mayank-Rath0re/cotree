import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class CreateProjectPage extends StatefulWidget {
  final int spaceId;

  const CreateProjectPage({
    super.key,
    required this.spaceId,
  });

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final TextEditingController _projectTitleController = TextEditingController();
  final TextEditingController _projectOverviewController =
      TextEditingController();
  List<Teams> _availableTeams = [];
  List<int> _selectedTeamIds = [];
  bool _isLoadingTeams = true;
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _fetchTeams();
  }

  Future<void> _fetchTeams() async {
    try {
      final teams = await client.space.fetchSpaceTeams(widget.spaceId);
      setState(() {
        _availableTeams = teams;
        _isLoadingTeams = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingTeams = false;
      });
      if (mounted) {
        _showErrorDialog('Failed to fetch teams: $e');
      }
    }
  }

  Future<void> _createProject() async {
    if (_projectTitleController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a project title');
      return;
    }

    if (_projectOverviewController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a project overview');
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      await client.space.createProject(
        widget.spaceId,
        _projectTitleController.text.trim(),
        _projectOverviewController.text.trim(),
        _selectedTeamIds,
      );

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to create project: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(
            'Project "${_projectTitleController.text.trim()}" created successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _projectTitleController.dispose();
    _projectOverviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
          displayString: "Create New Project",
          fontSize: 18,
          bold: true,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Title Section
            const AbsText(
              displayString: "Project Title",
              fontSize: 16,
              bold: true,
            ),
            const SizedBox(height: 8),
            AbsTextfield(
              hintText: "Enter project name",
              controller: _projectTitleController,
            ),
            const SizedBox(height: 24),

            // Project Overview Section
            const AbsText(
              displayString: "Project Overview",
              fontSize: 16,
              bold: true,
            ),
            const SizedBox(height: 8),
            AbsMultilineTextfield(
              hintText: "Describe your project...",
              controller: _projectOverviewController,
            ),
            const SizedBox(height: 24),

            // Teams Selection Section
            const AbsText(
              displayString: "Assign Teams",
              fontSize: 16,
              bold: true,
            ),
            const SizedBox(height: 8),

            if (_isLoadingTeams) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ] else if (_availableTeams.isEmpty) ...[
              AbsMinimalBox(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: AbsText(
                      displayString: "No teams available in this space",
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ] else ...[
              MultiSelectDialogField<Teams>(
                items: _availableTeams
                    .map((team) => MultiSelectItem<Teams>(team, team.teamTitle))
                    .toList(),
                itemsTextStyle: TextStyle(
                  color: themeProvider.contrastColor,
                ),
                title: const Text("Select Teams"),
                selectedColor: themeProvider.headColor,
                buttonText: const Text(
                  "Select teams...",
                  style: TextStyle(fontSize: 16),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                searchable: true,
                listType: MultiSelectListType.LIST,
                onConfirm: (values) {
                  setState(() {
                    _selectedTeamIds = values.map((team) => team.id!).toList();
                  });
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    setState(() {
                      _selectedTeamIds.remove(value.id);
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_selectedTeamIds.isNotEmpty) ...[
                const AbsText(
                  displayString: "Selected Teams",
                  fontSize: 14,
                  bold: true,
                ),
                const SizedBox(height: 8),
                ...(_availableTeams
                    .where((team) => _selectedTeamIds.contains(team.id))
                    .map((team) => AbsMinimalBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.group,
                                  color: themeProvider.headColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: AbsText(
                                    displayString: team.teamTitle,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))),
              ],
            ],

            // Create Button
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: AbsButtonPrimary(
                onPressed: _isCreating ? null : _createProject,
                text: _isCreating ? "Creating..." : "Create Project",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
