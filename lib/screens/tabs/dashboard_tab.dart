import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: theme.textTheme.h2,
          ),
          const SizedBox(height: 16),
          _buildWelcomeCard(theme),
          const SizedBox(height: 20),
          Text('Overview', style: theme.textTheme.h4),
          const SizedBox(height: 12),
          _buildStatsGrid(theme),
          const SizedBox(height: 20),
          Text('Recent Activity', style: theme.textTheme.h4),
          const SizedBox(height: 12),
          _buildRecentActivity(theme),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(ShadThemeData theme) {
    return ShadCard(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning, Officer!',
                    style: theme.textTheme.h4.copyWith(
                      color: theme.colorScheme.primaryForeground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You have 3 pending patrols today',
                    style: theme.textTheme.muted.copyWith(
                      color: theme.colorScheme.primaryForeground
                          .withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ShadButton.outline(
                    size: ShadButtonSize.sm,
                    backgroundColor: theme.colorScheme.primaryForeground
                        .withValues(alpha: 0.15),
                    onPressed: () {},
                    child: Text(
                      'View Schedule',
                      style: TextStyle(
                        color: theme.colorScheme.primaryForeground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.shieldCheck,
              size: 64,
              color: theme.colorScheme.primaryForeground.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(ShadThemeData theme) {
    final stats = [
      (LucideIcons.mapPin, 'Active Zones', '12', const Color(0xFF3B82F6)),
      (LucideIcons.users, 'Officers On Duty', '8', const Color(0xFF22C55E)),
      (LucideIcons.triangleAlert, 'Incidents', '2', const Color(0xFFF97316)),
      (LucideIcons.circleCheck, 'Resolved', '47', const Color(0xFFA855F7)),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: stats
          .map((s) => _buildStatCard(theme, s.$1, s.$2, s.$3, s.$4))
          .toList(),
    );
  }

  Widget _buildStatCard(ShadThemeData theme, IconData icon, String label,
      String value, Color color) {
    return ShadCard(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 18, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: theme.textTheme.h3
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(label,
                    style: theme.textTheme.muted.copyWith(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(ShadThemeData theme) {
    final activities = [
      (
        LucideIcons.mapPin,
        'Zone A patrol completed',
        '10 mins ago',
        const Color(0xFF22C55E)
      ),
      (
        LucideIcons.triangleAlert,
        'Incident reported at Block 5',
        '25 mins ago',
        const Color(0xFFF97316)
      ),
      (
        LucideIcons.users,
        'Officer Kim checked in',
        '1 hour ago',
        const Color(0xFF3B82F6)
      ),
      (
        LucideIcons.circleCheck,
        'Night shift handover done',
        '2 hours ago',
        const Color(0xFFA855F7)
      ),
    ];

    return Column(
      children: activities
          .map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ShadCard(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: a.$4.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(a.$1, size: 16, color: a.$4),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.$2,
                                  style: theme.textTheme.p
                                      .copyWith(fontWeight: FontWeight.w500)),
                              Text(a.$3, style: theme.textTheme.muted),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
