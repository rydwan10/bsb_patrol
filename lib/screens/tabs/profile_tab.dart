import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../login_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfileHeader(theme),
          const SizedBox(height: 24),
          _buildStatsRow(theme),
          const SizedBox(height: 24),
          _buildMenuSection(theme, 'Account', [
            _MenuItem(LucideIcons.user, 'Edit Profile', 'Update your details'),
            _MenuItem(LucideIcons.bell, 'Notification Settings',
                'Manage alerts'),
            _MenuItem(
                LucideIcons.lock, 'Change Password', 'Update credentials'),
          ]),
          const SizedBox(height: 16),
          _buildMenuSection(theme, 'Patrol', [
            _MenuItem(
                LucideIcons.calendar, 'My Schedule', 'View shift calendar'),
            _MenuItem(LucideIcons.fileText, 'My Reports',
                'All submitted reports'),
            _MenuItem(LucideIcons.award, 'Achievements', 'Badges & milestones'),
          ]),
          const SizedBox(height: 16),
          _buildMenuSection(theme, 'Support', [
            _MenuItem(LucideIcons.info, 'Help Center', 'FAQs & guides'),
            _MenuItem(LucideIcons.messageSquare, 'Contact Support',
                'Get assistance'),
          ]),
          const SizedBox(height: 24),
          ShadButton.destructive(
            key: const Key('logoutButton'),
            width: double.infinity,
            onPressed: () => _showLogoutDialog(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(LucideIcons.logOut, size: 16),
                SizedBox(width: 8),
                Text('Sign Out'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('BSB Patrol v1.0.0', style: theme.textTheme.muted),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ShadThemeData theme) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'JD',
                  style: theme.textTheme.h3.copyWith(
                    color: theme.colorScheme.primaryForeground,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('John Doe', style: theme.textTheme.h4),
            const SizedBox(height: 4),
            Text('@johndoe', style: theme.textTheme.muted),
            const SizedBox(height: 8),
            ShadBadge(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(LucideIcons.shield, size: 12),
                  SizedBox(width: 4),
                  Text('Senior Officer'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(ShadThemeData theme) {
    return Row(
      children: [
        Expanded(child: _buildStatItem(theme, '142', 'Patrols')),
        const SizedBox(width: 8),
        Expanded(child: _buildStatItem(theme, '38', 'Reports')),
        const SizedBox(width: 8),
        Expanded(child: _buildStatItem(theme, '5', 'Incidents')),
        const SizedBox(width: 8),
        Expanded(child: _buildStatItem(theme, '4.9', 'Rating')),
      ],
    );
  }

  Widget _buildStatItem(ShadThemeData theme, String value, String label) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(value,
                style:
                    theme.textTheme.h4.copyWith(fontWeight: FontWeight.bold)),
            Text(label,
                style: theme.textTheme.muted.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(
      ShadThemeData theme, String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title,
              style:
                  theme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
        ),
        ShadCard(
          child: Column(
            children: items.map((item) {
              final isLast = item == items.last;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.muted
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(item.icon, size: 16),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title,
                                  style: theme.textTheme.p.copyWith(
                                      fontWeight: FontWeight.w500)),
                              Text(item.subtitle,
                                  style: theme.textTheme.muted
                                      .copyWith(fontSize: 12)),
                            ],
                          ),
                        ),
                        Icon(LucideIcons.chevronRight,
                            size: 16,
                            color: theme.colorScheme.mutedForeground),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: theme.colorScheme.border,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Sign Out'),
        description:
            const Text('Are you sure you want to sign out of BSB Patrol?'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ShadButton.destructive(
            key: const Key('confirmLogoutButton'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MenuItem(this.icon, this.title, this.subtitle);
}
