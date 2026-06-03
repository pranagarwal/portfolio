import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ExperienceSection extends StatelessWidget {
  final Key sectionKey;
  final List<Experience> items;
  const ExperienceSection({
    super.key,
    required this.sectionKey,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: sectionKey,
      index: '04',
      label: 'EXPERIENCE',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Where I’ve worked.', style: AppTheme.sectionTitle(context)),
          const SizedBox(height: Gap.lg),
          ...items.map((e) => _ExperienceTile(item: e)),
        ],
      ),
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  final Experience item;
  const _ExperienceTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final period = Text(item.period,
        style: AppTheme.mono(size: 12, color: AppColors.textMuted));

    final detail = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.role, style: AppTheme.cardTitle),
        Text(item.company,
            style: AppTheme.bodyStrong.copyWith(color: AppColors.accent)),
        const SizedBox(height: Gap.xs),
        Text(item.summary, style: AppTheme.body.copyWith(fontSize: 15)),
        if (item.highlights.isNotEmpty) ...[
          const SizedBox(height: Gap.xs),
          ...item.highlights.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('— ', style: AppTheme.mono(color: AppColors.accentDim)),
                    Expanded(
                        child: Text(h,
                            style: AppTheme.body.copyWith(fontSize: 14))),
                  ],
                ),
              )),
        ],
      ],
    );

    return Container(
      margin: const EdgeInsets.only(bottom: Gap.md),
      padding: const EdgeInsets.symmetric(vertical: Gap.md),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [period, const SizedBox(height: Gap.xs), detail],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 160, child: period),
                Expanded(child: detail),
              ],
            ),
    );
  }
}
