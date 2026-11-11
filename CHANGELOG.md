# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.1.0] - 2026-11-11
### Added
- `09-commit` now creates or updates the project's `README.md`: bilingual (English + Italian) in a single file, non-technical and written for everyday users, with a fixed template and confirmation before writing.
- When you start a new project (no source code yet), `02-clarify` proposes an idiomatic architecture based on language, framework and project type and records the confirmed choice in `.pi-workflow/architecture.md`; curated references cover Python, JavaScript/TypeScript, Go and Bash.
- `03-plan-tasks` places planned files inside the documented folders, adds a "Task 0" that creates the folder tree (folders and `.gitkeep` only) and flags files created by project generators outside that tree.
- `05-implement` handles scaffold tasks: it creates only folders, checks them against `.pi-workflow/architecture.md`, and asks before touching files a generator placed outside the planned tree.

### Changed
- The Node and Python API references recommend one folder per domain (route/router, controller, service, data access, interfaces or schemas, colocated tests) with shared `core/`; the layered layout becomes the alternative for small APIs.
- The JS/TS frontend reference adds `pages/`, `components/ui/` and `lib/`, and keeps `main.tsx` and `App.tsx` where Vite generates them.
- The `.pi-workflow/plan.md` template is renamed `03-plan-tasks/plan-template.md`.

### Removed
- Generic team-oriented templates (time estimates, stakeholders, peer review) from phases 01, 03, 04, 05, 06, 08 and 09, which contradicted the skill instructions.

## [3.0.0] - 2026-10-22
### Added
- `/skill:10-push`: optional final phase that checks the branch against the remote, shows the outgoing commits, pushes after confirmation and opens a pull request on request.

### Changed
- **Breaking:** the scope guardrail is renamed `/skill:10-guardrail-scope` → `/skill:guardrail-scope` and is no longer numbered as a phase.
- **Breaking:** `09-commit` works locally only; pushing and pull requests move to `/skill:10-push`.
- Phases are numbered out of 10 ("Fase N/10").

## [2.0.0] - 2026-10-22
### Added
- pi package manifest (`package.json`): install all 10 skills with `pi install git:github.com/alexis-82/personal-skills-claude@pi-testing`.
- README section on making the scope guardrail always active by adding it to `~/.pi/agent/AGENTS.md`.

### Changed
- **Breaking:** skills now target the pi agent; they are invoked as `/skill:01-spec` … `/skill:10-guardrail-scope`.
- **Breaking:** workflow files are written to `.pi-workflow/` in the project instead of `.claude/`.
- `02-clarify` asks its decision and clarification questions in chat as numbered options (or through a structured question tool, if a pi extension provides one).

### Removed
- **Breaking:** `install.sh` and `install.ps1`; use `pi install` instead.
- Claude Code support on this branch.

## [1.0.0] - 2026-10-17
### Added
- `09-commit` now creates or updates the project's `CHANGELOG.md` (Keep a Changelog + SemVer, with date), showing the entry for confirmation before writing.
- Installers remove previously installed skills with the old unnumbered names, avoiding duplicates.

### Changed
- **Breaking:** skills are renamed with their workflow phase number (`/spec` → `/01-spec`, `/clarify` → `/02-clarify`, …, `/guardrail-scope` → `/10-guardrail-scope`).
