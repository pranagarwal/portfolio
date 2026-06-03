import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  final Key sectionKey;
  final Profile profile;
  const AboutSection({
    super.key,
    required this.sectionKey,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('I own features from\nthe pixel to the database.',
            style: AppTheme.sectionTitle(context)),
        const SizedBox(height: Gap.md),
        Text(profile.bio, style: AppTheme.body.copyWith(fontSize: 17)),
      ],
    );

    final stats = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _Stat(value: '3+', label: 'YEARS BUILDING FULL-STACK'),
        _Stat(value: '10+', label: 'PROJECTS SHIPPED'),
        _Stat(value: '∞', label: 'COFFEES DEBUGGED OVER'),
      ],
    );

    return SectionWrapper(
      sectionKey: sectionKey,
      index: '01',
      label: 'ABOUT',
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [text, const SizedBox(height: Gap.lg), stats],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: text),
                const SizedBox(width: Gap.xl),
                Expanded(flex: 2, child: stats),
              ],
            ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: AppTheme.display(context)
                  .copyWith(fontSize: 48, color: AppColors.accent)),
          Text(label, style: AppTheme.mono(size: 11, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
