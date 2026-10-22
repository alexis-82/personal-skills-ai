# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
