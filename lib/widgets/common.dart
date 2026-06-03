import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

/// Open an external URL (or mailto:) safely.
Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// Wraps a section: constrains width, centers it, adds vertical rhythm, and
/// shows a monospace "01 / LABEL" eyebrow. Attach [sectionKey] for nav scrolling.
class SectionWrapper extends StatelessWidget {
  final Key sectionKey;
  final String index; // "01"
  final String label; // "ABOUT"
  final Widget child;
  final Color? background;

  const SectionWrapper({
    super.key,
    required this.sectionKey,
    required this.index,
    required this.label,
    required this.child,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.pagePadding(context);
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: background,
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: Gap.xxl),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('$index / ', style: AppTheme.mono(color: AppColors.accent)),
                  Text(label,
                      style: AppTheme.mono(color: AppColors.textMuted)),
                  const SizedBox(width: Gap.sm),
                  Expanded(child: Container(height: 1, color: AppColors.border)),
                ],
              ),
              const SizedBox(height: Gap.lg),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Scales + lifts a child slightly on hover. CSS-style micro-interaction.
class Hoverable extends StatefulWidget {
  final Widget Function(bool hovering) builder;
  const Hoverable({super.key, required this.builder});

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: widget.builder(_hovering),
    );
  }
}

/// Monospace pill used for tech tags.
class TechTag extends StatelessWidget {
  final String label;
  const TechTag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label, style: AppTheme.mono(size: 12, color: AppColors.textMuted)),
    );
  }
}

/// Primary call-to-action button (filled accent).
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      builder: (hovering) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          transform: Matrix4.translationValues(0, hovering ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: hovering
                ? [
                    const BoxShadow(
                      color: Color(0x55D7FF3E),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: AppColors.background),
                const SizedBox(width: Gap.xs),
              ],
              Text(
                label,
                style: AppTheme.mono(
                  color: AppColors.background,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined secondary button.
class GhostButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const GhostButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      builder: (hovering) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: hovering ? AppColors.surfaceAlt : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hovering ? AppColors.accent : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: AppColors.text),
                const SizedBox(width: Gap.xs),
              ],
              Text(label, style: AppTheme.mono(color: AppColors.text)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined text-pill link for social profiles (GitHub / LinkedIn / X).
/// Uses monospace text + a Material arrow icon — no brand-icon package needed,
/// which keeps the build compatible with current Flutter SDKs.
class SocialButton extends StatelessWidget {
  final String label;
  final String url;

  const SocialButton({super.key, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      builder: (hovering) => GestureDetector(
        onTap: () => openUrl(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: hovering ? AppColors.surfaceAlt : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hovering ? AppColors.accent : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTheme.mono(
                  size: 13,
                  color: hovering ? AppColors.accent : AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_outward,
                size: 14,
                color: hovering ? AppColors.accent : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fade + slide-up entrance animation, with optional delay for staggering.
class FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const FadeInUp({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<FadeInUp> createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) => Opacity(
        opacity: curved.value,
        child: Transform.translate(
          offset: Offset(0, (1 - curved.value) * 24),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
