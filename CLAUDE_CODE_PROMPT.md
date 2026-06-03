# Claude Code Prompt — Full-Stack Developer Portfolio (Flutter Web)

Paste everything below into Claude Code (in VS Code) to generate or extend the project.
You can also use it to ask Claude Code to modify the version you already have.

---

## PROMPT

Build a **static Flutter Web portfolio** for a full-stack developer. It must run with
no backend, but be structured so a reactive Spring Boot backend can be added later by
editing one file. Produce production-quality, idiomatic Flutter 3.4+ code with null safety.

### Tech & dependencies
- Flutter Web, Material 3, dark theme.
- Packages: `google_fonts`, `url_launcher`, `http`, `font_awesome_flutter`, and
  `flutter_lints` (dev).

### Aesthetic direction ("editorial-technical")
- Near-black background (`#0B0C0E`), warm off-white text (`#ECEAE4`), muted gray
  (`#8A8F98`), and ONE sharp accent: electric lime (`#D7FF3E`) used sparingly.
- Fonts via google_fonts: **Fraunces** (serif) for display/headings, **Manrope** for
  body, **JetBrains Mono** for labels/tech tags/nav. Do NOT use Inter/Roboto/Arial.
- Generous spacing, an 8pt spacing scale, max content width ~1100px, subtle hover
  micro-interactions (lift + accent glow), and a staggered fade-in-up on the hero.

### Architecture (the important part)
Create a **data seam**: a `PortfolioRepository` class that is the only place data comes
from. For now its methods return hardcoded example data. Add a comment block explaining
that later these methods become `async` and fetch from a Spring Boot WebFlux + R2DBC +
Postgres API, with no UI changes. Define plain models (`Profile`, `SocialLinks`,
`Project`, `SkillGroup`, `Experience`) that mirror what a JSON API would return.

`Project` should be a **case study**: title, tagline, problem, solution, role, outcome,
`List<String> tech`, `List<String> highlights`, optional githubUrl/liveUrl/imageUrl,
and a `featured` flag. This case-study format is deliberate — it signals full-stack depth.

### Structure
```
lib/main.dart
lib/theme/app_theme.dart      (AppColors, AppTheme text styles, Gap spacing, Responsive)
lib/data/models.dart
lib/data/portfolio_repository.dart   (the seam, with example content)
lib/widgets/common.dart       (SectionWrapper with "01 / LABEL" eyebrow, Hoverable,
                               PrimaryButton, GhostButton, IconLinkButton, TechTag, FadeInUp, openUrl)
lib/widgets/nav_bar.dart      (sticky blurred nav as a PreferredSizeWidget + mobile NavDrawer)
lib/widgets/project_card.dart (case-study card; if imageUrl is null, draw a small
                               "Flutter → API → DB" diagram with CustomPainter as placeholder)
lib/sections/hero_section.dart / about_section.dart / skills_section.dart /
             projects_section.dart / experience_section.dart / contact_section.dart
lib/pages/home_page.dart      (assembles sections; nav links scroll to GlobalKey targets
                               via Scrollable.ensureVisible; footer at the bottom)
web/index.html  (custom dark loading screen + SEO/Open Graph meta)
web/manifest.json
.github/workflows/deploy.yml
```

### Sections
- **Hero**: availability pill, big name, "a <Role>." with the role in accent, tagline,
  "View Work" + "Get in Touch" buttons, social icon buttons. Staggered fade-in.
- **About**: short editorial heading + bio paragraph, plus a few stats (years, projects).
- **Skills**: grouped cards (Frontend / Backend / Data / Tooling) of monospace tag pills.
- **Selected Work**: responsive grid (1 col mobile, 2 col desktop) of project case-study cards.
- **Experience**: timeline-style list with period on the left, role/company/highlights on the right.
- **Contact**: left column with email/location; right column a form (name, email, message)
  that POSTs JSON to `https://api.web3forms.com/submit` with an `access_key` constant
  (placeholder `YOUR-WEB3FORMS-ACCESS-KEY`). Validate fields; show sending/success/error states.
- **Footer**: copyright + "Built with Flutter Web".

### Navigation
Sticky translucent nav (BackdropFilter blur). Desktop shows inline monospace links;
mobile shows a hamburger that opens an end drawer. Each link scrolls smoothly to its
section using a `GlobalKey` and `Scrollable.ensureVisible`. Use the Scaffold `appBar`
slot so scroll targets land just below the nav.

### Responsiveness
A `Responsive` helper with mobile (<760), tablet, desktop (>=1100) breakpoints; page
padding grows on larger screens; sections reflow from row→column on mobile.

### Deploy
Add a GitHub Actions workflow that, on push to `main`, sets up Flutter
(`subosito/flutter-action@v2`), runs `flutter pub get`, builds with
`flutter build web --release --base-href "/${{ github.event.repository.name }}/"`, and
deploys to GitHub Pages using `actions/upload-pages-artifact@v3` +
`actions/deploy-pages@v4` with the correct `pages`/`id-token` permissions. Comment that
user/org pages or custom domains should use `--base-href "/"`.

### Content
Fill every section with realistic EXAMPLE content for a full-stack dev who does Flutter +
reactive Spring Boot (WebFlux, Project Reactor, R2DBC) + Postgres. Mark with comments
exactly which fields the owner must replace.

Also write a `README.md` documenting local run, customization (which file holds what),
the Web3Forms setup, deployment steps, and how to swap in the backend later.
```
```
