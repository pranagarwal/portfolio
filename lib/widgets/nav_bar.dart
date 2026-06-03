import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'common.dart';

class NavItem {
  final String label;
  final VoidCallback onTap;
  const NavItem(this.label, this.onTap);
}

/// Translucent, blurred sticky nav. Use as a Scaffold `appBar`.
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String brand;
  final List<NavItem> items;
  final VoidCallback onMenuTap;

  const NavBar({
    super.key,
    required this.brand,
    required this.items,
    required this.onMenuTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kNavHeight);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.pagePadding(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: kNavHeight,
          padding: EdgeInsets.symmetric(horizontal: pad),
          decoration: const BoxDecoration(
            color: Color(0xCC0B0C0E),
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand / logo mark
                  Row(
                    children: [
                      Text('{ ', style: AppTheme.mono(color: AppColors.accent, size: 18)),
                      Text(brand, style: AppTheme.mono(color: AppColors.text, size: 16, weight: FontWeight.w700)),
                      Text(' }', style: AppTheme.mono(color: AppColors.accent, size: 18)),
                    ],
                  ),
                  if (isMobile)
                    IconButton(
                      onPressed: onMenuTap,
                      icon: const Icon(Icons.menu, color: AppColors.text),
                    )
                  else
                    Row(
                      children: [
                        for (final item in items) ...[
                          _NavLink(item: item),
                          const SizedBox(width: Gap.md),
                        ],
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final NavItem item;
  const _NavLink({required this.item});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      builder: (hovering) => GestureDetector(
        onTap: item.onTap,
        child: Text(
          item.label,
          style: AppTheme.mono(
            size: 13,
            color: hovering ? AppColors.accent : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Mobile slide-out menu contents.
class NavDrawer extends StatelessWidget {
  final List<NavItem> items;
  const NavDrawer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Gap.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MENU', style: AppTheme.mono(color: AppColors.textFaint)),
              const SizedBox(height: Gap.lg),
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      item.onTap();
                    },
                    child: Text(item.label,
                        style: AppTheme.sectionTitle(context)
                            .copyWith(fontSize: 26)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
