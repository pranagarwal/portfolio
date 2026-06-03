# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single-page **Flutter Web** developer portfolio. Static-only (no backend), built to a
deliberate "editorial-technical" aesthetic. `CLAUDE_CODE_PROMPT.md` is the original
generation spec — useful context for *why* the structure is the way it is.

## Commands

```bash
flutter pub get               # install deps
flutter run -d chrome         # run locally
flutter build web --release   # production bundle → build/web/
flutter analyze               # lint (rules in analysis_options.yaml)
flutter test                  # run tests (no tests exist yet)
```

There is no test suite. Deployment is automated via `.github/workflows/deploy.yml`
(GitHub Pages on push to `main`). The workflow sets `--base-href "/<repo-name>/"` for a
project page; switch to `"/"` for a user/org page or custom domain.

## Architecture

**The data seam is the central design decision.** `lib/data/portfolio_repository.dart`
(`PortfolioRepository`) is the *only* source of data — every method returns hardcoded
content today. The intended evolution is to make these methods `async` and fetch from a
reactive Spring Boot (WebFlux + R2DBC + Postgres) API. Models in `lib/data/models.dart`
mirror a future JSON API. **The UI widgets take model types directly and must not change
when the backend is added** — preserve this property when editing. `HomePage` constructs
one `const PortfolioRepository()` and passes results down to sections.

**Composition:** `main.dart` → `HomePage` (`lib/pages/home_page.dart`) assembles all
sections in a single `SingleChildScrollView`. Each section gets a `GlobalKey`; nav links
scroll to them via `Scrollable.ensureVisible`. The nav is in the Scaffold `appBar` slot
(a `PreferredSizeWidget`) so scroll targets land just below it; mobile uses an end drawer.

**Sections** (`lib/sections/`): hero, about, skills, projects, experience, contact — each
a widget taking a `sectionKey` plus its model data.

**Shared widgets** (`lib/widgets/`): `common.dart` holds `SectionWrapper` (width
constraint + "01 / LABEL" eyebrow), `Hoverable`, buttons, `TechTag`, `FadeInUp`, and the
`openUrl` helper. `project_card.dart` draws a `CustomPainter` "Flutter → API → DB" diagram
when a project's `imageUrl` is null.

## Theming — change the whole look from one file

`lib/theme/app_theme.dart` centralizes everything visual:
- `AppColors` — near-black bg, off-white text, single electric-lime accent (`#D7FF3E`).
  Editing these rebrands the entire site.
- Fonts via `google_fonts`: **Fraunces** (serif headings), **Manrope** (body),
  **JetBrains Mono** (labels/tags). Do not introduce Inter/Roboto/Arial.
- `Gap` (8pt spacing scale), `Responsive` (breakpoints: mobile <760, desktop ≥1100,
  `pagePadding` grows with width), `kMaxContentWidth` (1100).
- `AppTheme.display/sectionTitle/cardTitle/body/mono(...)` — use these named styles rather
  than inlining `TextStyle`s, so type stays consistent.

## Content & config to fill in (placeholders)

- All portfolio content (profile, projects, skills, experience): `portfolio_repository.dart`.
  Projects use a **case-study** shape (problem / solution / role / outcome / highlights) —
  keep that structure; it's intentional.
- Contact form: `kWeb3FormsAccessKey` in `lib/sections/contact_section.dart` (free key from
  web3forms.com). The form POSTs JSON to `https://api.web3forms.com/submit` — no backend.
- SEO/meta: `web/index.html`, `web/manifest.json`.

## Conventions

- Lint enforces `prefer_const_constructors`, `prefer_const_literals_to_create_immutables`,
  and `avoid_print` — keep widget trees `const` where possible.
- Models are plain immutable data classes (mirror an API); add `fromJson` factories there
  when wiring a backend, not elsewhere.
- No local assets are bundled yet — images use network URLs. Declare assets in
  `pubspec.yaml` if you add local files.
