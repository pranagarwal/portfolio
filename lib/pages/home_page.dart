import 'package:flutter/material.dart';

import '../data/portfolio_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/experience_section.dart';
import '../sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Swap PortfolioRepository for an API-backed version later — nothing here changes.
  final _repo = const PortfolioRepository();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // One key per scroll target.
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0, // align section top to top of the scroll viewport
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = _repo.getProfile();

    final navItems = [
      NavItem('ABOUT', () => _scrollTo(_aboutKey)),
      NavItem('SKILLS', () => _scrollTo(_skillsKey)),
      NavItem('WORK', () => _scrollTo(_projectsKey)),
      NavItem('EXPERIENCE', () => _scrollTo(_experienceKey)),
      NavItem('CONTACT', () => _scrollTo(_contactKey)),
    ];

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: NavDrawer(items: navItems),
      appBar: NavBar(
        brand: _shortName(profile.name),
        items: navItems,
        onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              sectionKey: _heroKey,
              profile: profile,
              onViewWork: () => _scrollTo(_projectsKey),
              onContact: () => _scrollTo(_contactKey),
            ),
            AboutSection(sectionKey: _aboutKey, profile: profile),
            SkillsSection(sectionKey: _skillsKey, groups: _repo.getSkills()),
            ProjectsSection(
                sectionKey: _projectsKey, projects: _repo.getProjects()),
            ExperienceSection(
                sectionKey: _experienceKey, items: _repo.getExperience()),
            ContactSection(sectionKey: _contactKey, profile: profile),
            _Footer(name: profile.name),
          ],
        ),
      ),
    );
  }

  String _shortName(String full) {
    final parts = full.trim().split(' ');
    if (parts.length == 1) return parts.first;
    return '${parts.first} ${parts.last[0]}.';
  }
}

class _Footer extends StatelessWidget {
  final String name;
  const _Footer({required this.name});

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.pagePadding(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: Gap.lg),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: Gap.xs,
            children: [
              Text('© ${DateTime.now().year} $name',
                  style: AppTheme.mono(size: 12, color: AppColors.textMuted)),
              Text('Built with Flutter Web',
                  style: AppTheme.mono(size: 12, color: AppColors.textFaint)),
            ],
          ),
        ),
      ),
    );
  }
}
