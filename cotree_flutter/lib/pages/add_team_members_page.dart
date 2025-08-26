import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTeamMembersPage extends StatefulWidget {
  final Teams teamData;

  const AddTeamMembersPage({super.key, required this.teamData});

  @override
  State<AddTeamMembersPage> createState() => _AddTeamMembersPageState();
}

class _AddTeamMembersPageState extends State<AddTeamMembersPage> {
  List<Member> nonTeamMembers = [];
  List<Member> selectedMembers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNonTeamMembers();
  }

  Future<void> _loadNonTeamMembers() async {
    try {
      final members =
          await client.team.fetchNonTeamMembers(widget.teamData.id!);
      setState(() {
        nonTeamMembers = members;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              AbsText(displayString: "Failed to load members", fontSize: 14)));
    }
  }

  void _toggleMemberSelection(Member member) {
    setState(() {
      if (selectedMembers.contains(member)) {
        selectedMembers.remove(member);
      } else {
        selectedMembers.add(member);
      }
    });
  }

  Future<void> _addSelectedMembers() async {
    if (selectedMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: AbsText(
              displayString: "Please select members to add", fontSize: 14)));
      return;
    }

    try {
      // Create TeamMember objects for each selected member
      final teamMembers = selectedMembers
          .map((member) => TeamMember(
                memberId: member.id!,
                teamId: widget.teamData.id!,
                role: "Contributor", // Default role for new members
              ))
          .toList();

      await client.team.addTeamMember(teamMembers);

      Navigator.pop(context, true); // Return true to indicate success
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: AbsText(
              displayString: "Added ${selectedMembers.length} members to team",
              fontSize: 14)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              AbsText(displayString: "Failed to add members", fontSize: 14)));
    }
  }

  Widget _buildMemberTile(Member member) {
    bool isSelected = selectedMembers.contains(member);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue.withValues(alpha: 0.1) : null,
      ),
      child: ListTile(
        leading: AbsAvatar(radius: 20, avatarUrl: member.avatar),
        title: AbsText(displayString: member.name, fontSize: 16, bold: true),
        subtitle: AbsText(displayString: member.designation, fontSize: 14),
        trailing: Checkbox(
          checkColor: Provider.of<ThemeProvider>(context).headColor,
          value: isSelected,
          onChanged: (_) => _toggleMemberSelection(member),
        ),
        onTap: () => _toggleMemberSelection(member),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
            displayString: "Add Team Members", fontSize: 16, bold: true),
        centerTitle: true,
        actions: [
          if (selectedMembers.isNotEmpty)
            TextButton(
              onPressed: _addSelectedMembers,
              child:
                  const AbsText(displayString: "Add", fontSize: 16, bold: true),
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const AbsText(
                        displayString: "Select members to add:",
                        fontSize: 16,
                        bold: true,
                      ),
                      const Spacer(),
                      AbsText(
                        displayString: "${selectedMembers.length} selected",
                        fontSize: 14,
                        headColor: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: selectedMembers.isEmpty && nonTeamMembers.isEmpty
                      ? const Center(
                          child: AbsText(
                            displayString: "No members available to add",
                            fontSize: 16,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: nonTeamMembers.length,
                          itemBuilder: (context, index) {
                            return _buildMemberTile(nonTeamMembers[index]);
                          },
                        ),
                ),
                if (selectedMembers.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: AbsButtonPrimary(
                      onPressed: _addSelectedMembers,
                      text:
                          "Add ${selectedMembers.length} Member${selectedMembers.length > 1 ? 's' : ''}",
                      icon: const Icon(Icons.person_add_alt),
                    ),
                  ),
              ],
            ),
    );
  }
}
