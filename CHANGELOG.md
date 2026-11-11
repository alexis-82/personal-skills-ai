# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.3.0] - 2026-11-11
### Added
- `05-implement` handles scaffold tasks: it creates only folders and `.gitkeep`, checks the result against `.claude/architecture.md`, and asks before touching files a project generator placed outside the planned tree.
- `03-plan-tasks` lists the files each project generator creates and flags those outside the documented tree as risks.
- The JS/TS frontend reference adds `pages/`, `components/ui/` and `lib/`, and keeps `main.tsx` and `App.tsx` where Vite generates them.

### Changed
- The Node API reference (Express/Fastify) now recommends one folder per business component (route, controller, service, data access, interfaces, colocated tests) with shared `core/`, `config/` and `bin/www/`; the layered layout becomes the alternative for small APIs.
- The Python API reference (FastAPI/Flask) now recommends one package per domain (router, schemas, service, repository, models) with shared `core/`, matching the JS/TS and Go references; the layered layout becomes the alternative for small APIs.
- The `.claude/plan.md` template is renamed `03-plan-tasks/plan-template.md`.

### Removed
- Generic team-oriented templates (time estimates, stakeholders, peer review) from phases 01, 03, 04, 05, 06, 08 and 09, which contradicted the skill instructions.

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
