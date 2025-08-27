import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/pages/profile_edit_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final UserView userview;
  const SettingsPage({super.key, required this.userview});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<IconData> modeIcon = [Icons.sunny, Icons.nights_stay];

  Widget settingsTile(Function()? onTap, Icon icon, String text,
      {bool isDestructive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: AbsMinimalBox(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 10),
                Expanded(
                  child: AbsText(
                    displayString: text,
                    fontSize: 15,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDestructive ? Colors.red : Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = Provider.of<ThemeProvider>(context).isDarkMode ? 0 : 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const AbsText(
          displayString: "Settings",
          fontSize: 20,
          bold: true,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              const AbsText(displayString: "Profile", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(() {
                // Navigate to profile edit page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileEditPage(userView: widget.userview)));
              },
                  Icon(
                    Icons.person_outline,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Edit Profile"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to privacy settings
              },
                  Icon(
                    Icons.privacy_tip_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Privacy Settings"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),

              // Account Section
              const AbsText(displayString: "Account", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(() {
                // Navigate to change password page
              },
                  Icon(
                    Icons.lock_outline,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Change Password"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to change email page
              },
                  Icon(
                    Icons.email_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Change Email"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to two-factor authentication
              },
                  Icon(
                    Icons.security_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Two-Factor Authentication"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),

              // Appearance Section
              const AbsText(
                  displayString: "Appearance", fontSize: 18, bold: true),
              const SizedBox(height: 8),

              GestureDetector(
                  onTap: () => setState(() {
                        _selectedIndex = (_selectedIndex + 1) % 2;
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      }),
                  child: AbsMinimalBox(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.dark_mode_outlined,
                            color:
                                Provider.of<ThemeProvider>(context).headColor,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: AbsText(
                                displayString: "Dark Mode", fontSize: 15),
                          ),
                          Icon(
                            modeIcon[_selectedIndex],
                            size: 24,
                            color: Provider.of<ThemeProvider>(context)
                                .contrastColor,
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),

              // Notifications Section
              const AbsText(
                  displayString: "Notifications", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(() {
                // Navigate to push notification settings
              },
                  Icon(
                    Icons.notifications_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Push Notifications"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to email notification settings
              },
                  Icon(
                    Icons.mail_outline,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Email Notifications"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to notification preferences
              },
                  Icon(
                    Icons.settings_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Notification Preferences"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),
              /*
              // Workspace Section
              const AbsText(
                  displayString: "Workspace", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(() {
                // Navigate to workspace settings
              },
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Workspace Settings"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to team management
              },
                  Icon(
                    Icons.groups_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Team Management"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to project settings
              },
                  Icon(
                    Icons.folder_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Project Settings"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),
              
              // Data & Storage Section
              const AbsText(
                  displayString: "Data & Storage", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(() {
                // Navigate to data usage
              },
                  Icon(
                    Icons.data_usage_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Data Usage"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to storage settings
              },
                  Icon(
                    Icons.storage_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Storage Settings"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to backup settings
              },
                  Icon(
                    Icons.backup_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Backup & Restore"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),
              */
              // Help & Support Section
              const AbsText(
                  displayString: "Help & Support", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(() {
                // Navigate to help center
              },
                  Icon(
                    Icons.help_outline,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Help Center"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to contact support
              },
                  Icon(
                    Icons.support_agent_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Contact Support"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to feedback page
              },
                  Icon(
                    Icons.feedback_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Send Feedback"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to about page
              },
                  Icon(
                    Icons.info_outline,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "About"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),

              // Legal Section
              const AbsText(displayString: "Legal", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(() {
                // Navigate to terms of service
              },
                  Icon(
                    Icons.description_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Terms of Service"),
              const SizedBox(height: 5),
              settingsTile(() {
                // Navigate to privacy policy
              },
                  Icon(
                    Icons.privacy_tip_outlined,
                    color: Provider.of<ThemeProvider>(context).headColor,
                  ),
                  "Privacy Policy"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 6),

              // Account Actions Section
              const AbsText(
                  displayString: "Account Actions", fontSize: 18, bold: true),
              const SizedBox(height: 8),
              settingsTile(
                () {
                  // Navigate to delete account
                },
                const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
                "Delete Account",
                isDestructive: true,
              ),
              const SizedBox(height: 20),

              // Logout Button
              Row(children: [
                Expanded(
                    child: AbsButtonPrimary(
                        onPressed: () {
                          // Handle logout
                        },
                        fontSize: 18,
                        text: "Logout"))
              ]),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
