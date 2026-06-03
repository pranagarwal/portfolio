import 'models.dart';

/// =============================================================
/// THE DATA SEAM
/// -------------------------------------------------------------
/// Right now every method returns hardcoded example data. This is the ONLY
/// place that knows where data comes from. When you add your reactive Spring
/// Boot backend later, you change just this file — make the methods `async`
/// and fetch from your API. The UI never changes.
///
///   Future<List<Project>> getProjects() async {
///     final res = await http.get(Uri.parse('https://api.you.dev/projects'));
///     return (jsonDecode(res.body) as List).map(Project.fromJson).toList();
///   }
///
/// >>> EDIT EVERYTHING BELOW with your real details. <<<
/// =============================================================
class PortfolioRepository {
  const PortfolioRepository();

  Profile getProfile() => const Profile(
        name: 'Pranshu Kumar Agarwal',
        role: 'Full-Stack Developer',
        tagline:
            'I build fast, reactive products end to end — Flutter on the front, '
            'Spring Boot and Postgres on the back.',
        location: 'Mumbai, India',
        email: 'pranshuagarwal70@gmail.com',
        resumeUrl: 'https://example.com/resume.pdf',
        bio:
            'I’m a full-stack engineer who likes owning a feature from the pixel '
            'to the database. On the client I work in Flutter and Dart with a '
            'reactive, state-driven approach. On the server I build non-blocking '
            'APIs with Spring Boot WebFlux and Project Reactor, backed by Postgres '
            'over R2DBC. I care about clean architecture, predictable latency, and '
            'shipping things people actually use.',
        social: SocialLinks(
          github: 'https://github.com/pranagarwal',
          linkedin: 'https://linkedin.com/in/pran8959',
          twitter: 'https://twitter.com/pranagarwal',
        ),
      );

  List<SkillGroup> getSkills() => const [
        SkillGroup(
          label: 'Frontend',
          skills: [
            'Flutter',
            'Dart',
            'RxDart',
            'Riverpod / Bloc',
            'Responsive UI'
          ],
        ),
        SkillGroup(
          label: 'Backend',
          skills: [
            'Java',
            'Spring Boot',
            'Spring WebFlux',
            'Project Reactor',
            'Reactive Programming',
            'REST APIs',
          ],
        ),
        SkillGroup(
          label: 'Data',
          skills: [
            'PostgreSQL',
            'SQL',
            'R2DBC',
            'JPA / Hibernate',
            'Schema Design'
          ],
        ),
        SkillGroup(
          label: 'Tooling',
          skills: ['Git', 'Docker', 'GitHub Actions', 'CI/CD', 'Gradle'],
        ),
      ];

  List<Project> getProjects() => const [
        Project(
          featured: true,
          title: 'StreamDesk',
          tagline: 'Real-time support dashboard with live agent presence.',
          problem:
              'A support team had no live view of incoming tickets — agents '
              'refreshed manually and SLAs slipped.',
          solution:
              'A Flutter Web dashboard fed by a reactive WebFlux backend. Tickets '
              'stream to clients over Server-Sent Events; the UI updates instantly '
              'with no polling.',
          role:
              'Sole developer. Designed the schema, built the reactive API and '
              'the Flutter client, and set up CI/CD.',
          outcome:
              'Cut average ticket pickup time by ~40% and removed all manual '
              'refreshing.',
          tech: [
            'Flutter',
            'Spring WebFlux',
            'R2DBC',
            'PostgreSQL',
            'SSE',
            'Docker',
          ],
          highlights: [
            'Non-blocking end to end: WebFlux + R2DBC, zero blocking calls.',
            'Live updates via reactive SSE streams instead of polling.',
            'Optimistic UI with rollback on server rejection.',
          ],
          githubUrl: 'https://github.com/yourusername/streamdesk',
          liveUrl: null,
          imageUrl: null,
        ),
        Project(
          featured: true,
          title: 'LedgerLite',
          tagline: 'Offline-first personal finance tracker.',
          problem:
              'Existing budgeting apps broke without a connection and felt slow '
              'on mid-range phones.',
          solution:
              'An offline-first Flutter app with a local cache that syncs to a '
              'Spring Boot API when back online. Conflict resolution handled '
              'server-side.',
          role: 'Built the full stack: client, sync engine, and API.',
          outcome:
              'Works fully offline; sync completes in under a second on reconnect.',
          tech: ['Flutter', 'Dart', 'Spring Boot', 'PostgreSQL', 'REST'],
          highlights: [
            'Offline-first architecture with a clean local/remote data layer.',
            'Idempotent sync endpoints with server-side conflict resolution.',
            'Responsive layout from phone to desktop web.',
          ],
          githubUrl: 'https://github.com/yourusername/ledgerlite',
          liveUrl: null,
          imageUrl: null,
        ),
        Project(
          title: 'PulseAPI',
          tagline: 'A reactive metrics ingestion service.',
          problem:
              'High-volume metric events needed to be ingested without the '
              'backend falling over under bursts.',
          solution: 'A reactive ingestion pipeline using Project Reactor with '
              'backpressure, buffering, and batched writes to Postgres.',
          role: 'Backend engineer — designed and built the reactive pipeline.',
          outcome: 'Sustained 5k events/sec on a single modest instance.',
          tech: [
            'Java',
            'Spring WebFlux',
            'Project Reactor',
            'PostgreSQL',
            'R2DBC'
          ],
          highlights: [
            'Backpressure-aware streams to stay stable under load.',
            'Batched, non-blocking writes via R2DBC.',
          ],
          githubUrl: 'https://github.com/yourusername/pulseapi',
          liveUrl: null,
          imageUrl: null,
        ),
      ];

  List<Experience> getExperience() => const [
        Experience(
          role: 'Full-Stack Developer',
          company: 'Example Tech Pvt. Ltd.',
          period: '2023 — Present',
          summary:
              'Build and maintain Flutter clients and reactive Spring Boot '
              'services for a logistics platform.',
          highlights: [
            'Shipped a driver app used daily by 2,000+ drivers.',
            'Migrated key endpoints to WebFlux, cutting p95 latency by 30%.',
          ],
        ),
        Experience(
          role: 'Backend Developer',
          company: 'Another Company',
          period: '2021 — 2023',
          summary:
              'Designed Postgres schemas and built REST APIs in Spring Boot for '
              'an e-commerce backend.',
          highlights: [
            'Owned the orders and payments services.',
            'Introduced CI/CD with GitHub Actions.',
          ],
        ),
      ];
}
