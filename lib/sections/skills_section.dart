import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  final Key sectionKey;
  final List<SkillGroup> groups;
  const SkillsSection({
    super.key,
    required this.sectionKey,
    required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossAxisCount = isMobile ? 1 : 2;

    return SectionWrapper(
      sectionKey: sectionKey,
      index: '02',
      label: 'SKILLS',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('The full stack, end to end.',
              style: AppTheme.sectionTitle(context)),
          const SizedBox(height: Gap.lg),
          GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: Gap.sm,
            crossAxisSpacing: Gap.sm,
            childAspectRatio: isMobile ? 2.6 : 2.4,
            children: groups.map((g) => _SkillCard(group: g)).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillGroup group;
  const _SkillCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.label.toUpperCase(),
              style: AppTheme.mono(color: AppColors.accent)),
          const SizedBox(height: Gap.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: group.skills.map((s) => TechTag(s)).toList(),
          ),
        ],
      ),
    );
  }
}
