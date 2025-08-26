import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_searchbar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTeamPage extends StatefulWidget {
  final int spaceId;
  final List<Member> spaceMembers;

  const CreateTeamPage({
    super.key,
    required this.spaceId,
    required this.spaceMembers,
  });

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final TextEditingController _teamTitleController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Member> _selectedMembers = [];
  List<Member> _searchResults = [];
  bool _isLoading = false;

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchResults = widget.spaceMembers
          .where((member) =>
              member.name.toLowerCase().contains(query.toLowerCase()) &&
              !_selectedMembers.contains(member))
          .toList();
    });
  }

  void _addMember(Member member) {
    setState(() {
      _selectedMembers.add(member);
      _searchResults.remove(member);
    });
  }

  void _removeMember(Member member) {
    setState(() {
      _selectedMembers.remove(member);
    });
  }

  Future<void> _createTeam() async {
    if (_teamTitleController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a team title');
      return;
    }

    if (_selectedMembers.isEmpty) {
      _showErrorDialog('Please select at least one team member');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await client.space.createTeam(
        widget.spaceId,
        _teamTitleController.text.trim(),
        _selectedMembers.map((member) => member.id!).toList(),
        List.filled(_selectedMembers.length, "Contributor"),
      );

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to create team: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
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
            'Team "${_teamTitleController.text.trim()}" created successfully!'),
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
    _teamTitleController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
          displayString: "Create New Team",
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
            // Team Title Section
            const AbsText(
              displayString: "Team Title",
              fontSize: 16,
              bold: true,
            ),
            const SizedBox(height: 8),
            AbsTextfield(
              hintText: "Enter team name",
              controller: _teamTitleController,
            ),
            const SizedBox(height: 24),

            // Team Members Section
            const AbsText(
              displayString: "Team Members",
              fontSize: 16,
              bold: true,
            ),
            const SizedBox(height: 8),

            // Search Bar
            AbsSearchbar(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 16),

            // Selected Members
            if (_selectedMembers.isNotEmpty) ...[
              const AbsText(
                displayString: "Selected Members",
                fontSize: 14,
                bold: true,
              ),
              const SizedBox(height: 8),
              ...(_selectedMembers.map((member) => AbsMinimalBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AbsAvatar(
                            radius: 20,
                            avatarUrl: member.avatar,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AbsText(
                              displayString: member.name,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeMember(member),
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red[400],
                            ),
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),
                  ))),
              const SizedBox(height: 16),
            ],

            // Search Results
            if (_searchResults.isNotEmpty) ...[
              const AbsText(
                displayString: "Available Members",
                fontSize: 14,
                bold: true,
              ),
              const SizedBox(height: 8),
              ...(_searchResults.map((member) => GestureDetector(
                    onTap: () => _addMember(member),
                    child: AbsMinimalBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            AbsAvatar(
                              radius: 20,
                              avatarUrl: member.avatar,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AbsText(
                                displayString: member.name,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              color: themeProvider.headColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))),
              const SizedBox(height: 16),
            ],

            // Create Button
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: AbsButtonPrimary(
                onPressed: _isLoading ? null : _createTeam,
                text: _isLoading ? "Creating..." : "Create Team",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
