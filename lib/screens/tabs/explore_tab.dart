import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  String _selectedCategory = 'All';

  static const _kGray = Color(0xFF6B7280);
  static const _kBlue = Color(0xFF3B82F6);
  static const _kGreen = Color(0xFF22C55E);
  static const _kOrange = Color(0xFFF97316);
  static const _kPurple = Color(0xFFA855F7);

  final _categories = ['All', 'Zones', 'Officers', 'Reports', 'Equipment'];

  final _items = const [
    _ExploreItem(LucideIcons.mapPin, 'Zone Alpha', 'North District',
        'High Priority', Color(0xFFEF4444)),
    _ExploreItem(
        LucideIcons.mapPin, 'Zone Bravo', 'East District', 'Active', _kGreen),
    _ExploreItem(LucideIcons.mapPin, 'Zone Charlie', 'South District',
        'Active', _kGreen),
    _ExploreItem(
        LucideIcons.user, 'Officer Martinez', 'Badge #2201', 'On Duty', _kBlue),
    _ExploreItem(LucideIcons.user, 'Officer Chen', 'Badge #2202', 'Off Duty',
        _kGray),
    _ExploreItem(LucideIcons.fileText, 'Incident Report #101', 'Block 5, Zone A',
        'Pending', _kOrange),
    _ExploreItem(LucideIcons.fileText, 'Shift Report #88', 'Night Shift',
        'Resolved', _kGreen),
    _ExploreItem(LucideIcons.package, 'Radio Set Alpha', 'Equipment Room 1',
        'Available', _kPurple),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Explore', style: theme.textTheme.h3),
              const SizedBox(height: 4),
              Text('Browse patrol zones, officers & reports',
                  style: theme.textTheme.muted),
              const SizedBox(height: 16),
              ShadInput(
                key: const Key('exploreSearchField'),
                placeholder: const Text('Search...'),
                leading: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(LucideIcons.search, size: 16),
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories
                      .map((cat) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _selectedCategory == cat
                                ? ShadButton(
                                    size: ShadButtonSize.sm,
                                    onPressed: () =>
                                        setState(() => _selectedCategory = cat),
                                    child: Text(cat),
                                  )
                                : ShadButton.outline(
                                    size: ShadButtonSize.sm,
                                    onPressed: () =>
                                        setState(() => _selectedCategory = cat),
                                    child: Text(cat),
                                  ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ShadCard(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: item.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(item.icon, size: 20, color: item.color),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title,
                                  style: theme.textTheme.p.copyWith(
                                      fontWeight: FontWeight.w600)),
                              Text(item.subtitle,
                                  style: theme.textTheme.muted),
                            ],
                          ),
                        ),
                        ShadBadge(
                          backgroundColor: item.color.withValues(alpha: 0.1),
                          child: Text(
                            item.status,
                            style: TextStyle(
                                color: item.color, fontSize: 11),
                          ),
                        ),
                      ],
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

class _ExploreItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color color;

  const _ExploreItem(
      this.icon, this.title, this.subtitle, this.status, this.color);
}
