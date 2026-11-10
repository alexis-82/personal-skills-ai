# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.0] - 2026-11-10
### Added
- When you start a new project (no source code yet), `02-clarify` now proposes an idiomatic architecture based on language, framework and project type, avoiding MVC or extra layers where they aren't needed, and records the confirmed choice in `.claude/architecture.md`.
- Curated architecture references for Python, JavaScript/TypeScript, Go and Bash; other languages or project types are explicitly flagged as having no curated reference.
- Projects with two stacks (e.g. API + web frontend) get separate `backend/` and `frontend/` folders.

### Changed
- `03-plan-tasks` reads `.claude/architecture.md`, places planned files inside the documented folders and adds a "Task 0" that creates the folder tree (folders and `.gitkeep` only), leaving out folders created by project generators such as `npm create vite` or `wails init`.

## [2.1.0] - 2026-11-06
### Added
- `09-commit` now creates or updates the project's `README.md`: bilingual (English + Italian) in a single file, non-technical and written for everyday users, with a fixed template (centered header, badges, language links, per-language index) and confirmation before writing.

## [2.0.0] - 2026-10-22
### Added
- `/10-push`: optional final phase that checks the branch against the remote, shows the outgoing commits, pushes after confirmation and opens a pull request on request.

### Changed
- **Breaking:** the scope guardrail is renamed `10-guardrail-scope` → `guardrail-scope` and no longer appears in the `/` menu; Claude applies it on its own.
- **Breaking:** `09-commit` works locally only; pushing and pull requests move to `/10-push`.
- Phases are numbered out of 10 ("Fase N/10").
- Installers remove previously installed skills from an explicit list of old names, including the old `10-guardrail-scope` folder.

## [1.0.0] - 2026-10-17
### Added
- `09-commit` now creates or updates the project's `CHANGELOG.md` (Keep a Changelog + SemVer, with date), showing the entry for confirmation before writing.
- Installers remove previously installed skills with the old unnumbered names, avoiding duplicates.

### Changed
- **Breaking:** skills are renamed with their workflow phase number (`/spec` → `/01-spec`, `/clarify` → `/02-clarify`, …, `/guardrail-scope` → `/10-guardrail-scope`).
