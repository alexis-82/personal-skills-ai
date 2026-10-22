# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2026-10-22
### Added
- `09-commit` generates READMEs with a centered title and tagline, a single row of shields.io badges (version, technologies, and license/platform/last commit when available) and an index with emoji section titles.

## [1.1.0] - 2026-10-19
### Added
- `01-spec` asks once per project whether it is **Software** (end-user) or **Homelab** (developer, reproducible) and stores the answer in `.claude/project-profile.md`.
- `09-commit` creates or updates the project's `README.md` according to the profile: end-user only for Software (build and development notes go to `.claude/development.md`), full developer and reproducibility docs for Homelab. Changes are shown for confirmation, and a mixed README is restructured once.
- `09-commit` can be triggered with "aggiorna il README".

### Changed
- `10-guardrail-scope` treats `README.md` as a product file: profile-driven README updates happen only in `09-commit`, unless the README is explicitly part of the spec.

## [1.0.0] - 2026-10-17
### Added
- `09-commit` now creates or updates the project's `CHANGELOG.md` (Keep a Changelog + SemVer, with date), showing the entry for confirmation before writing.
- Installers remove previously installed skills with the old unnumbered names, avoiding duplicates.

### Changed
- **Breaking:** skills are renamed with their workflow phase number (`/spec` → `/01-spec`, `/clarify` → `/02-clarify`, …, `/guardrail-scope` → `/10-guardrail-scope`).
