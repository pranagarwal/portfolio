# Full-Stack Developer Portfolio (Flutter Web)

A fast, responsive portfolio built with Flutter Web. Static-only for now (no backend
required), with the data layer structured so you can plug in a reactive Spring Boot
backend later by editing a single file.

**Aesthetic:** editorial-technical — near-black background, editorial serif headings
(Fraunces), clean grotesque body (Manrope), monospace labels (JetBrains Mono), and a
single electric-lime accent.

---

## 1. Prerequisites

- Flutter SDK 3.4+ — https://docs.flutter.dev/get-started/install
- Enable web support (already on by default in recent Flutter):
  ```bash
  flutter config --enable-web
  ```

## 2. Run locally

```bash
flutter pub get
flutter run -d chrome
```

To build a production bundle:

```bash
flutter build web --release
# output is in build/web/
```

---

## 3. What YOU need to fill in

Everything below uses placeholder/example content. Replace it:

| What | File | Notes |
|------|------|-------|
| Name, role, bio, location, email, social links | `lib/data/portfolio_repository.dart` → `getProfile()` | This is the main one. |
| Your real projects (case studies) | `lib/data/portfolio_repository.dart` → `getProjects()` | Keep the problem/solution/role/outcome structure — it sells full-stack depth. |
| Skills | `lib/data/portfolio_repository.dart` → `getSkills()` | |
| Work history | `lib/data/portfolio_repository.dart` → `getExperience()` | |
| Resume link | `getProfile()` → `resumeUrl` | Host a PDF somewhere and link it. |
| Contact form key | `lib/sections/contact_section.dart` → `kWeb3FormsAccessKey` | Free key from https://web3forms.com |
| Page title + SEO/social tags | `web/index.html` and `web/manifest.json` | |
| Brand mark colors / fonts | `lib/theme/app_theme.dart` | Change `AppColors` to rebrand the whole site. |
| Project images (optional) | `imageUrl` on each project | Network URL. If null, a generated placeholder diagram shows. |

## 4. Set up the contact form (free)

1. Go to https://web3forms.com and create an access key with your email (no signup beyond the email).
2. Paste it into `kWeb3FormsAccessKey` in `lib/sections/contact_section.dart`.
3. Done — submissions arrive in your inbox. No backend needed.

---

## 5. Deploy for free

### Option A — GitHub Pages (workflow included)

1. Push this project to a GitHub repo.
2. In the repo: **Settings → Pages → Build and deployment → Source = GitHub Actions**.
3. Push to `main`. The included workflow (`.github/workflows/deploy.yml`) builds and deploys automatically.
4. Site goes live at `https://USERNAME.github.io/REPO/`.

**base-href note:** the workflow sets `--base-href "/REPO/"` for a *project* page.
If you use a repo named `USERNAME.github.io` (a *user* page) or a custom domain,
edit the build step to `--base-href "/"`.

### Option B — Cloudflare Pages (no base-href headaches, custom domain easy)

1. Build command: `flutter build web --release`
2. Build output directory: `build/web`
3. You may need to install Flutter in the build — easiest is to keep using the GitHub
   Actions build above and point Cloudflare at the artifact, or build locally and deploy
   the `build/web` folder via Wrangler/drag-and-drop.

Netlify, Vercel, and Firebase Hosting also work the same way (serve `build/web`).

> Free tiers change often — confirm current limits when you sign up.

---

## 6. Project structure

```
lib/
  main.dart                      App entry
  theme/app_theme.dart           Colors, fonts, spacing, responsive helpers
  data/
    models.dart                  Plain data models (mirror a future API)
    portfolio_repository.dart    THE DATA SEAM — edit your content here
  widgets/
    common.dart                  Buttons, section wrapper, hover fx, animations
    nav_bar.dart                 Sticky nav + mobile drawer
    project_card.dart            Case-study card
  sections/                      hero / about / skills / projects / experience / contact
  pages/home_page.dart           Assembles sections + scroll navigation
```

---

## 7. Adding the reactive backend later

When you're ready, build a Spring Boot WebFlux + R2DBC service that exposes your
projects/experience as JSON. Then in `portfolio_repository.dart`:

- Add `fromJson` factories to the models in `models.dart`.
- Make the repository methods `async` and fetch from your API with the `http` package.
- Update the section widgets to use `FutureBuilder` (or your state manager) around the
  now-async data.

The UI components themselves don't need to change — they already take the same model types.
```
```
