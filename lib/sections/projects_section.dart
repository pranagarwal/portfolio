import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  final Key sectionKey;
  final List<Project> projects;
  const ProjectsSection({
    super.key,
    required this.sectionKey,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    // 1 column on phones, 2 on wider screens.
    final columns = width < 900 ? 1 : 2;

    return SectionWrapper(
      sectionKey: sectionKey,
      index: '03',
      label: 'SELECTED WORK',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Things I’ve built.', style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 6),
          Text('Each one written up as a case study — problem, build, outcome.',
              style: AppTheme.body),
          const SizedBox(height: Gap.lg),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = Gap.md;
              final cardWidth = columns == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - spacing) / 2;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: projects
                    .map((p) => SizedBox(
                          width: cardWidth,
                          child: ProjectCard(project: p),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
