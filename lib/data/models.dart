/// Plain data models. These intentionally mirror what a backend API would
/// return so that swapping the hardcoded repository for live data later is a
/// one-file change (see PortfolioRepository).

class Profile {
  final String name;
  final String role; // e.g. "Full-Stack Developer"
  final String tagline; // short hero subline
  final String location;
  final String email;
  final String bio; // longer "about" paragraph(s)
  final String? resumeUrl; // link to a hosted PDF
  final SocialLinks social;

  const Profile({
    required this.name,
    required this.role,
    required this.tagline,
    required this.location,
    required this.email,
    required this.bio,
    required this.social,
    this.resumeUrl,
  });
}

class SocialLinks {
  final String? github;
  final String? linkedin;
  final String? twitter;

  const SocialLinks({this.github, this.linkedin, this.twitter});
}

/// A project written up as a mini case study — the format that signals
/// full-stack depth to a reviewer.
class Project {
  final String title;
  final String tagline; // one line
  final String problem; // what needed solving
  final String solution; // what you built
  final String role; // your contribution
  final String outcome; // measurable result
  final List<String> tech; // ["Flutter", "Spring WebFlux", ...]
  final List<String> highlights; // bullet points
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl; // optional screenshot / architecture diagram (network)
  final bool featured;

  const Project({
    required this.title,
    required this.tagline,
    required this.problem,
    required this.solution,
    required this.role,
    required this.outcome,
    required this.tech,
    this.highlights = const [],
    this.githubUrl,
    this.liveUrl,
    this.imageUrl,
    this.featured = false,
  });
}

class SkillGroup {
  final String label; // "Frontend", "Backend", "Data", ...
  final List<String> skills;

  const SkillGroup({required this.label, required this.skills});
}

class Experience {
  final String role;
  final String company;
  final String period; // "2023 — Present"
  final String summary;
  final List<String> highlights;

  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.summary,
    this.highlights = const [],
  });
}
