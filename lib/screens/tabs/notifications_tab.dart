import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  final List<_Notification> _notifications = [
    _Notification(
      icon: LucideIcons.triangleAlert,
      title: 'Incident Reported',
      body: 'New incident at Block 5, Zone A requires immediate attention.',
      time: '5 min ago',
      color: Color(0xFFF97316),
      isRead: false,
    ),
    _Notification(
      icon: LucideIcons.userCheck,
      title: 'Officer Check-in',
      body: 'Officer Martinez has checked in for the morning shift.',
      time: '20 min ago',
      color: Color(0xFF22C55E),
      isRead: false,
    ),
    _Notification(
      icon: LucideIcons.mapPin,
      title: 'Patrol Complete',
      body: 'Zone Bravo patrol has been successfully completed.',
      time: '1 hour ago',
      color: Color(0xFF3B82F6),
      isRead: false,
    ),
    _Notification(
      icon: LucideIcons.shield,
      title: 'Shift Update',
      body: 'Evening shift schedule has been updated. Please review.',
      time: '3 hours ago',
      color: Color(0xFFA855F7),
      isRead: true,
    ),
    _Notification(
      icon: LucideIcons.fileText,
      title: 'Report Submitted',
      body: 'Incident report #101 has been submitted for review.',
      time: '5 hours ago',
      color: Color(0xFF14B8A6),
      isRead: true,
    ),
    _Notification(
      icon: LucideIcons.bell,
      title: 'System Maintenance',
      body: 'Scheduled maintenance tonight from 2:00 AM to 4:00 AM.',
      time: 'Yesterday',
      color: Color(0xFF6B7280),
      isRead: true,
    ),
  ];

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Notifications', style: theme.textTheme.h3),
                      if (_unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        ShadBadge(
                          child: Text('$_unreadCount new'),
                        ),
                      ],
                    ],
                  ),
                  Text('Stay updated on patrol activities',
                      style: theme.textTheme.muted),
                ],
              ),
              if (_unreadCount > 0)
                ShadButton.ghost(
                  size: ShadButtonSize.sm,
                  onPressed: _markAllRead,
                  child: const Text('Mark all read'),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _notifications.length,
            itemBuilder: (context, index) {
              final notif = _notifications[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () => setState(() => notif.isRead = true),
                  child: ShadCard(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: notif.color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(notif.icon,
                                size: 18, color: notif.color),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notif.title,
                                        style: theme.textTheme.p.copyWith(
                                          fontWeight: notif.isRead
                                              ? FontWeight.w500
                                              : FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    if (!notif.isRead)
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(notif.body,
                                    style: theme.textTheme.muted
                                        .copyWith(fontSize: 13)),
                                const SizedBox(height: 4),
                                Text(notif.time,
                                    style: theme.textTheme.muted
                                        .copyWith(fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Notification {
  final IconData icon;
  final String title;
  final String body;
  final String time;
  final Color color;
  bool isRead;

  _Notification({
    required this.icon,
    required this.title,
    required this.body,
    required this.time,
    required this.color,
    required this.isRead,
  });
}
