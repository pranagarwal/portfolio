import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  final Key sectionKey;
  final Profile profile;
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.profile,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: sectionKey,
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 620),
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: Gap.xxl),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                delay: const Duration(milliseconds: 80),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: AppColors.accent, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: Gap.xs),
                    Text('AVAILABLE FOR WORK · ${profile.location}',
                        style: AppTheme.mono(
                            size: 12, color: AppColors.textMuted)),
                  ],
                ),
              ),
              const SizedBox(height: Gap.md),
              FadeInUp(
                delay: const Duration(milliseconds: 160),
                child: Text(profile.name, style: AppTheme.display(context)),
              ),
              const SizedBox(height: Gap.xs),
              FadeInUp(
                delay: const Duration(milliseconds: 240),
                child: RichText(
                  text: TextSpan(
                    style: AppTheme.display(context).copyWith(
                      color: AppColors.textMuted,
                      fontSize: isMobile ? 28 : 44,
                    ),
                    children: [
                      const TextSpan(text: 'a '),
                      TextSpan(
                          text: profile.role,
                          style: const TextStyle(color: AppColors.accent)),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Gap.lg),
              FadeInUp(
                delay: const Duration(milliseconds: 320),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(profile.tagline,
                      style: AppTheme.body.copyWith(fontSize: 18)),
                ),
              ),
              const SizedBox(height: Gap.lg),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Wrap(
                  spacing: Gap.sm,
                  runSpacing: Gap.sm,
                  children: [
                    PrimaryButton(
                      label: 'VIEW WORK',
                      icon: Icons.arrow_downward,
                      onTap: onViewWork,
                    ),
                    GhostButton(
                      label: 'GET IN TOUCH',
                      onTap: onContact,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Gap.lg),
              FadeInUp(
                delay: const Duration(milliseconds: 480),
                child: Wrap(
                  spacing: Gap.xs,
                  runSpacing: Gap.xs,
                  children: [
                    if (profile.social.github != null)
                      SocialButton(
                        label: 'GitHub',
                        url: profile.social.github!,
                      ),
                    if (profile.social.linkedin != null)
                      SocialButton(
                        label: 'LinkedIn',
                        url: profile.social.linkedin!,
                      ),
                    if (profile.social.twitter != null)
                      SocialButton(
                        label: 'X / Twitter',
                        url: profile.social.twitter!,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
