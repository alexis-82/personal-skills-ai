# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
