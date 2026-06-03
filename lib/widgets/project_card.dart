import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// A project rendered as a case-study card: problem → solution → role →
/// outcome, with tech tags and links. This format communicates full-stack
/// depth far better than a bare screenshot.
class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      builder: (hovering) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, hovering ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hovering ? AppColors.accentDim : AppColors.border,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Preview(project: project),
            Padding(
              padding: const EdgeInsets.all(Gap.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (project.featured) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0x22D7FF3E),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('FEATURED',
                              style: AppTheme.mono(size: 10)),
                        ),
                        const SizedBox(width: Gap.xs),
                      ],
                      Expanded(
                        child: Text(project.title, style: AppTheme.cardTitle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(project.tagline, style: AppTheme.body),
                  const SizedBox(height: Gap.md),
                  _Field(label: 'PROBLEM', value: project.problem),
                  _Field(label: 'SOLUTION', value: project.solution),
                  _Field(label: 'MY ROLE', value: project.role),
                  _Field(label: 'OUTCOME', value: project.outcome, accent: true),
                  if (project.highlights.isNotEmpty) ...[
                    const SizedBox(height: Gap.sm),
                    ...project.highlights.map(
                      (h) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7, right: 10),
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(h,
                                  style: AppTheme.body.copyWith(fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: Gap.md),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tech.map((t) => TechTag(t)).toList(),
                  ),
                  if (project.githubUrl != null || project.liveUrl != null) ...[
                    const SizedBox(height: Gap.md),
                    Row(
                      children: [
                        if (project.githubUrl != null)
                          GestureDetector(
                            onTap: () => openUrl(project.githubUrl!),
                            child: Row(
                              children: [
                                const FaIcon(FontAwesomeIcons.github,
                                    size: 16, color: AppColors.textMuted),
                                const SizedBox(width: 8),
                                Text('Code',
                                    style: AppTheme.mono(
                                        color: AppColors.textMuted)),
                              ],
                            ),
                          ),
                        if (project.githubUrl != null && project.liveUrl != null)
                          const SizedBox(width: Gap.md),
                        if (project.liveUrl != null)
                          GestureDetector(
                            onTap: () => openUrl(project.liveUrl!),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_outward,
                                    size: 16, color: AppColors.accent),
                                const SizedBox(width: 8),
                                Text('Live',
                                    style: AppTheme.mono(color: AppColors.accent)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;
  final bool accent;
  const _Field({required this.label, required this.value, this.accent = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTheme.mono(
                  size: 11,
                  color: accent ? AppColors.accent : AppColors.textFaint)),
          const SizedBox(height: 4),
          Text(value,
              style: AppTheme.body.copyWith(
                fontSize: 14.5,
                color: accent ? AppColors.text : AppColors.textMuted,
              )),
        ],
      ),
    );
  }
}

/// Top preview area: a network image if provided, otherwise a generated
/// "architecture" placeholder so cards never look broken before you add art.
class _Preview extends StatelessWidget {
  final Project project;
  const _Preview({required this.project});

  @override
  Widget build(BuildContext context) {
    if (project.imageUrl != null) {
      return Image.network(
        project.imageUrl!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _PlaceholderArt(),
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : const _PlaceholderArt(),
      );
    }
    return const _PlaceholderArt();
  }
}

class _PlaceholderArt extends StatelessWidget {
  const _PlaceholderArt();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF15181C), Color(0xFF101316)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: CustomPaint(
          size: const Size(160, 60),
          painter: _StackDiagramPainter(),
        ),
      ),
    );
  }
}

/// Tiny "Flutter → API → DB" diagram drawn in code (no asset needed).
class _StackDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final box = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final line = Paint()
      ..color = AppColors.accentDim
      ..strokeWidth = 1.4;

    const w = 42.0, h = 26.0;
    final y = size.height / 2 - h / 2;
    final xs = [0.0, (size.width - w) / 2, size.width - w];

    for (var i = 0; i < xs.length; i++) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(xs[i], y, w, h),
        const Radius.circular(5),
      );
      canvas.drawRRect(rect, box);
      if (i < xs.length - 1) {
        canvas.drawLine(
          Offset(xs[i] + w, y + h / 2),
          Offset(xs[i + 1], y + h / 2),
          line,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
