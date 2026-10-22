---
name: 09-commit
description: Creare commit ben strutturati e opzionalmente aprire una pull request per una funzionalità completata, testata ed eventualmente refactorata. Crea o aggiorna anche il CHANGELOG.md del progetto con versione SemVer e data. Usare quando l'utente dice "committa", "fai il commit", "apri PR", "aggiorna il changelog" a chiusura del ciclo di lavoro. Nona e ultima fase del workflow feature-driven.
---

# Commit e pull request

Fase 9/9 del workflow. Consolida il lavoro (implementazione + test + refactor) in git in modo revisionabile.

> **⚠ Output path (regola dura)**
> Tutti i file di lavoro di questa skill vanno **esclusivamente** in `.pi-workflow/` nella root del progetto:
> `.pi-workflow/spec.md`, `.pi-workflow/plan.md`, `.pi-workflow/tasks.md`, `.pi-workflow/analysis.md`, `.pi-workflow/review.md`, `.pi-workflow/test-report.md`.
> **Mai** nella root del progetto. **Mai** nella cartella della skill (quella in cui pi l'ha installata).
>
> **Prima di scrivere il primo file, obbligatorio**:
> 1. Se `.pi-workflow/` non esiste nella root del progetto, crearla.
> 2. Se trovi già uno di questi file nella **root del progetto** (residuo da sessioni precedenti), **spostalo** in `.pi-workflow/` (`git mv` se tracciato, `mv` altrimenti) prima di procedere — non duplicarlo, non ignorarlo, non ricrearne una copia.
>
> Nota: dentro la cartella di questa skill esistono `plan.md`/`spec.md`/`tasks.md` — sono **template di riferimento**, si leggono ma non si toccano. I file di lavoro veri stanno solo in `.pi-workflow/` del progetto.
>
> **Eccezione**: `CHANGELOG.md` è un file di prodotto, non di workflow — va nella **root del progetto** (vedi [Aggiornamento CHANGELOG](#aggiornamento-changelog)).

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Eseguire `git status` e `git diff` per capire cosa entra nel commit.
3. **Ispezionare i file staged**: cercare segreti (chiavi API, password, token), file di build, file `.env`. Se trovi qualcosa di sospetto — anche se il nome sembra innocuo — aprire il file prima di procedere.
4. **Aggiornare il CHANGELOG** (vedi sezione [Aggiornamento CHANGELOG](#aggiornamento-changelog)): creare o aggiornare `CHANGELOG.md` nella root del progetto con la nuova voce, oppure dichiarare perché viene saltato.
5. Raggruppare le modifiche in commit logici. Come regola:
   - **Un commit per la feature** (implementazione + test relativi).
   - **Un commit separato per il refactor** se è stato fatto (fase 07), così la storia distingue chiaramente cambi di comportamento da cambi strutturali.
   - Mai un file solo per commit se non giustificato dal senso logico.
6. Messaggio di commit:
   - Prima riga: `<tipo>: <cosa cambia>` (max 70 caratteri). Tipi: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.
   - Corpo: **perché**, non cosa (il diff mostra il cosa).
7. Se richiesta PR: creare con `gh pr create`, titolo conciso, corpo con Summary (bullet) + Test plan.
8. Non pushare/aprire PR senza conferma esplicita dell'utente per quel repo.

## Aggiornamento CHANGELOG

> **Eccezione al path**: `CHANGELOG.md` **non** è un file di workflow. Va nella **root del progetto** (`git rev-parse --show-toplevel`), mai in `.pi-workflow/` né nella cartella della skill.

Eseguire i sotto-passi in ordine:

1. **Classificare il ciclo.** Fonti: Goals di `.pi-workflow/spec.md` e task completati in `.pi-workflow/tasks.md` se esistono, altrimenti solo il diff. Ignorare i file sotto `.pi-workflow/`.
   - Se **non** ci sono cambiamenti visibili a chi usa il prodotto (solo refactor, chore, test, documentazione interna) → **saltare il CHANGELOG** e scrivere in chat: "CHANGELOG non aggiornato: <motivo>". Passare al punto 5 di "Cosa fare".
2. **Riprendere un tentativo precedente.** Eseguire `git diff HEAD -- CHANGELOG.md`. Se mostra una voce `## [X.Y.Z]` aggiunta e non ancora committata (es. hook pre-commit fallito, commit rilanciato), quella voce va **sostituita**, non affiancata: rimuovere solo quella voce (il resto del file non si tocca) e proseguire dal sotto-passo 3. Versione e voce vanno **ricalcolate**, perché nel frattempo il contenuto del ciclo può essere cambiato (es. un fix diventato anche una feature: `1.2.1` → `1.3.0`).
3. **Determinare la versione** (SemVer):
   - `## [Unreleased]` **non è una versione**: non conta mai come base del calcolo.
   - **CHANGELOG con almeno una versione** → leggere la prima intestazione di versione (la prima `## ` diversa da `## [Unreleased]`) e incrementare:
     - breaking change → MAJOR (`1.4.2` → `2.0.0`);
     - nuova funzionalità → MINOR (`1.4.2` → `1.5.0`);
     - solo fix → PATCH (`1.4.2` → `1.4.3`).
     - Se MAJOR è `0` e c'è un breaking change → proporre MINOR (`0.4.2` → `0.5.0`) e segnalare che il passaggio a `1.0.0` è una scelta dell'utente.
   - **CHANGELOG assente, o presente ma senza nessuna versione** (es. solo intestazione e `## [Unreleased]`) → cercare la versione corrente del progetto **in sola lettura**: manifest (`package.json`, `pyproject.toml`, `Cargo.toml`, `*.csproj`, `setup.py`, `pom.xml`, `build.gradle`, …) oppure ultimo tag (`git describe --tags --abbrev=0`, togliendo l'eventuale prefisso `v`: `v2.3.0` → `2.3.0`). Se trovata, proporre il bump SemVer a partire da quella. Altrimenti proporre `0.1.0` (progetto nuovo o in sviluppo) o `1.0.0` (progetto già in uso) e **chiedere** all'utente.
   - Se la prima intestazione di versione **non è SemVer** (es. `## [v2]`, `## 2024-01-01`) → non dedurre, chiedere la versione all'utente.
   - La versione scritta nella voce è sempre `X.Y.Z` senza prefisso `v`.
   - Ogni ciclo è **sempre una nuova versione**, anche se l'ultima è dello stesso giorno o non ancora pushata.
4. **Comporre la voce, sempre in inglese:**
   - Intestazione: `## [X.Y.Z] - YYYY-MM-DD`, con la data odierna ricavata dal sistema (`date +%F` o `Get-Date -Format yyyy-MM-dd`), mai inventata.
   - Sezioni Keep a Changelog **solo se non vuote**, in quest'ordine: `### Added`, `### Changed`, `### Deprecated`, `### Removed`, `### Fixed`, `### Security`.
   - Bullet brevi orientati a chi usa il prodotto (cosa cambia per lui), non dettagli implementativi.
5. **Mostrare versione e voce all'utente e attendere conferma.** L'utente può correggere la versione o il testo. Non scrivere nulla prima della conferma.
6. **Scrivere il file**, mantenendo il fine riga (CRLF/LF) del file esistente; per un file nuovo, usare lo stesso fine riga degli altri file di testo del progetto:
   - **File assente** → creare `CHANGELOG.md` con questa intestazione fissa seguita dalla voce:
     ```markdown
     # Changelog

     All notable changes to this project will be documented in this file.

     The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
     and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
     ```
   - **File esistente** → un'unica regola di inserimento: la voce va subito **prima della prima intestazione di versione** (la prima `## ` diversa da `## [Unreleased]`); se non ce n'è nessuna, va **in fondo al file**. Di conseguenza un eventuale blocco `## [Unreleased]` resta sempre sopra la nuova voce, e né l'intestazione né il contenuto di `[Unreleased]` si toccano.
   - **Non modificare nessun'altra riga**: le voci precedenti non vanno riformattate, riordinate o corrette, anche se non rispettano il formato.
7. **Mettere in stage** `CHANGELOG.md` con nome esplicito, nello **stesso commit della feature**. Se il ciclo produce più commit (feature + refactor), il CHANGELOG va in quello della feature.

**Vietato in questo passo**: creare tag git o GitHub Release, aggiornare la versione in file di progetto (`package.json`, `pyproject.toml`, ecc.), ricostruire lo storico dal `git log`.

## Output atteso

Commit creati (feature + eventuale refactor separati), git tree pulito, `.pi-workflow/tasks.md` con tutti i task marcati `- [x]`, eventuale PR aperta. `CHANGELOG.md` nella root del progetto creato o aggiornato con la nuova voce nel commit della feature, oppure dichiarazione esplicita in chat del perché è stato saltato.

## Regole

- **[GUARDRAIL SCOPE]** Prima di committare, rileggi il diff riga per riga: ogni modifica deve essere motivabile con il task richiesto. Se una riga non serve, rimuovila. Vedi `/skill:10-guardrail-scope`.
- Mai `git add -A` alla cieca — nomi di file espliciti o `git status` prima.
- Mai `--no-verify`, `--force`, `reset --hard` senza richiesta esplicita.
- Se un hook pre-commit fallisce, correggere la causa e fare un **nuovo** commit, non `--amend`.
- Se il diff contiene cambi fuori scope (formatting, rename, refactor non richiesti su codice preesistente), **stopparsi**, revertirli, e ripartire.
