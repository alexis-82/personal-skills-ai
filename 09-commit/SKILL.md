---
name: 09-commit
description: Creare commit ben strutturati per una funzionalità completata, testata ed eventualmente refactorata. Crea o aggiorna anche il CHANGELOG.md del progetto con versione SemVer e data, e il README.md secondo il profilo del progetto (Software/Homelab). Usare quando l'utente dice "committa", "fai il commit", "aggiorna il changelog", "aggiorna il README" a chiusura del ciclo di lavoro. Nona fase del workflow feature-driven.
---

# Commit

Fase 9/10 del workflow. Consolida il lavoro (implementazione + test + refactor) in git in modo revisionabile.

> **⚠ Output path (regola dura)**
> Tutti i file di lavoro di questa skill vanno **esclusivamente** in `.claude/` nella root del progetto:
> `.claude/spec.md`, `.claude/plan.md`, `.claude/tasks.md`, `.claude/analysis.md`, `.claude/review.md`, `.claude/test-report.md`.
> **Mai** nella root del progetto. **Mai** nella cartella della skill (`~/.claude/skills/...`).
>
> **Prima di scrivere il primo file, obbligatorio**:
> 1. Se `.claude/` non esiste nella root del progetto, crearla.
> 2. Se trovi già uno di questi file nella **root del progetto** (residuo da sessioni precedenti), **spostalo** in `.claude/` (`git mv` se tracciato, `mv` altrimenti) prima di procedere — non duplicarlo, non ignorarlo, non ricrearne una copia.
>
> Nota: dentro la cartella di questa skill esistono `plan.md`/`spec.md`/`tasks.md` — sono **template di riferimento**, si leggono ma non si toccano. I file di lavoro veri stanno solo in `.claude/` del progetto.
>
> **Eccezione**: `CHANGELOG.md` e `README.md` sono file di prodotto, non di workflow — vanno nella **root del progetto** (vedi [Aggiornamento CHANGELOG](#aggiornamento-changelog) e [Aggiornamento README](#aggiornamento-readme)).

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Eseguire `git status` e `git diff` per capire cosa entra nel commit.
3. **Ispezionare i file staged**: cercare segreti (chiavi API, password, token), file di build, file `.env`. Se trovi qualcosa di sospetto — anche se il nome sembra innocuo — aprire il file prima di procedere.
4. **Aggiornare il CHANGELOG** (vedi sezione [Aggiornamento CHANGELOG](#aggiornamento-changelog)): creare o aggiornare `CHANGELOG.md` nella root del progetto con la nuova voce, oppure dichiarare perché viene saltato.
5. **Aggiornare il README** (vedi sezione [Aggiornamento README](#aggiornamento-readme)): creare o aggiornare `README.md` secondo il profilo del progetto, oppure dichiarare perché viene saltato.
6. Raggruppare le modifiche in commit logici. Come regola:
   - **Un commit per la feature** (implementazione + test relativi).
   - **Un commit separato per il refactor** se è stato fatto (fase 07), così la storia distingue chiaramente cambi di comportamento da cambi strutturali.
   - Mai un file solo per commit se non giustificato dal senso logico.
7. Messaggio di commit:
   - Prima riga: `<tipo>: <cosa cambia>` (max 70 caratteri). Tipi: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.
   - Corpo: **perché**, non cosa (il diff mostra il cosa).
8. Questa fase lavora solo in locale: niente push e niente PR, sono compito di `10-push`. Al termine, se il repo ha un remote, suggerire `/10-push` per pubblicare.

## Aggiornamento CHANGELOG

> **Eccezione al path**: `CHANGELOG.md` **non** è un file di workflow. Va nella **root del progetto** (`git rev-parse --show-toplevel`), mai in `.claude/` né nella cartella della skill.

Eseguire i sotto-passi in ordine:

1. **Classificare il ciclo.** Fonti: Goals di `.claude/spec.md` e task completati in `.claude/tasks.md` se esistono, altrimenti solo il diff. Ignorare i file sotto `.claude/`.
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

## Aggiornamento README

> **Eccezione al path**: `README.md` è un file di prodotto e va nella **root del progetto**. `.claude/development.md` invece è un file di lavoro e resta in `.claude/`.

Eseguire i sotto-passi in ordine:

1. **Leggere il profilo** da `.claude/project-profile.md` (riga `profile: software` oppure `profile: homelab`) e scrivere in chat `Profilo progetto: <profilo>`.
   - Se il file **non esiste** (es. `01-spec` saltata), oppure la riga `profile:` manca o ha un valore diverso da `software`/`homelab` → porre la stessa domanda Software/Homelab del Passo 0 di `01-spec` e creare il file nello stesso formato.
   - Se l'utente chiede di **cambiare profilo** → riscrivere solo la riga `profile:` e togliere l'eventuale riga `readme-aligned: true`, come nel Passo 0 di `01-spec`.
2. **Ristrutturazione una tantum.** Se il file di profilo **non** contiene la riga `readme-aligned: true` e il `README.md` esistente non è coerente col profilo (vedi sotto-passo 4) → preparare una riorganizzazione completa del README secondo il profilo:
   - in Software: spostare build/sviluppo in `.claude/development.md`;
   - in Homelab: se esiste `.claude/development.md` (es. dopo un cambio da Software), usarlo come **fonte** per le sezioni di sviluppo del README e chiedere all'utente se eliminarlo.

   La riorganizzazione **non** ha una conferma propria: entra nella proposta unica del sotto-passo 5. La riga `readme-aligned: true` si aggiunge al file di profilo al sotto-passo 6, sia se l'utente accetta sia se rifiuta la riorganizzazione, così la proposta non si ripete. Se il README è già coerente o non esiste, aggiungere comunque la riga al sotto-passo 6.
3. **Decidere se aggiornare.** Fonti: Goals di `.claude/spec.md`, task completati in `.claude/tasks.md`, diff (ignorando i file sotto `.claude/`). Aggiornare **solo se** il ciclo cambia qualcosa di documentato per il profilo:
   - Software: una funzione visibile all'utente, requisiti di sistema, modo di installare, comandi/opzioni, configurazione lato utente. Se cambiano solo build, toolchain, struttura o test → aggiornare **solo** `.claude/development.md` (il README resta invariato).
   - Homelab: tutto quanto sopra più prerequisiti/versioni, passi di setup, build, variabili d'ambiente, deploy, struttura del progetto.
   - Se nulla di questo cambia (e non c'è una ristrutturazione al sotto-passo 2) → **saltare** e scrivere in chat: "README non aggiornato: <motivo>". Aggiungere comunque `readme-aligned: true` al file di profilo se non c'è già, poi passare al punto 6 di "Cosa fare".
4. **Contenuto per profilo.**
   - **Software** (utente finale) — sezioni ammesse: cos'è / a cosa serve, requisiti di sistema, installazione (download, installer, pacchetto), utilizzo, configurazione lato utente, risoluzione problemi, licenza. **Vietato** nel README: build, compilazione, toolchain e framework di sviluppo (es. `go build`, `wails`, `npm`, `cargo`), dipendenze di sviluppo, struttura dei sorgenti, test, linee guida di contribuzione. Se l'utente del prodotto è uno sviluppatore (libreria, SDK, CLI per dev), il README documenta installazione e **uso** (import, API pubblica, comandi), ma non come si compila o testa il progetto stesso.
   - **Software → `.claude/development.md`**: riceve tutto ciò che è vietato nel README (build, toolchain, struttura, test, come contribuire). Crearlo o aggiornarlo quando il ciclo cambia queste informazioni o quando la ristrutturazione ce le sposta.
   - **Homelab** (sviluppatore, riproducibile) — sezioni attese: panoramica e architettura, prerequisiti con versioni, setup passo-passo da zero, build e avvio, configurazione e variabili d'ambiente, deploy, struttura del progetto, risoluzione problemi. In Homelab `.claude/development.md` **non** si crea.
   - **Forma** (entrambi i profili): il README segue il modello di `readme-format.md` di questa cartella (titolo centrato, badge, indice). I badge delle tecnologie sono ammessi anche in Software: il divieto riguarda le istruzioni di build, non i badge.
5. **Mostrare le modifiche e attendere conferma.** Un'unica proposta per README e (in Software) `.claude/development.md`. L'utente può correggerla. Non scrivere nulla prima della conferma.
6. **Scrivere i file** toccando solo le sezioni interessate dal ciclo (salvo la ristrutturazione accettata al sotto-passo 5), poi aggiungere `readme-aligned: true` al file di profilo se non c'è già. Mantenere la lingua e il fine riga (CRLF/LF) del README esistente; per un file nuovo usare la lingua delle istruzioni dell'utente e lo stesso fine riga degli altri file di testo del progetto.
7. **Mettere in stage** `README.md` con nome esplicito, nello **stesso commit della feature** (come il CHANGELOG). `.claude/development.md` e `.claude/project-profile.md` sono file di lavoro: **mai** in stage.

**Vietato in questo passo**: creare altra documentazione nella root o altrove (`DEVELOPMENT.md`, `CONTRIBUTING.md`, `docs/`, wiki), tradurre il README o cambiarne la lingua, modificare codice, CHANGELOG o manifest per adattarli al profilo, togliere `.claude/` dal `.gitignore`. L'allineamento del README al profilo avviene **solo** in questa fase; se il README è esplicitamente nei Goals/task della spec, quelle modifiche si fanno in `05-implement` e qui si verifica solo la coerenza col profilo.

## Output atteso

Commit creati (feature + eventuale refactor separati), git tree pulito, `.claude/tasks.md` con tutti i task marcati `- [x]`. `CHANGELOG.md` nella root del progetto creato o aggiornato con la nuova voce nel commit della feature, oppure dichiarazione esplicita in chat del perché è stato saltato. `README.md` nella root coerente col profilo del progetto e aggiornato nel commit della feature (con, in Software, `.claude/development.md` aggiornato e non committato), oppure dichiarazione esplicita in chat del perché è stato saltato.

## Regole

- **[GUARDRAIL SCOPE]** Prima di committare, rileggi il diff riga per riga: ogni modifica deve essere motivabile con il task richiesto. Se una riga non serve, rimuovila. Vedi la skill `guardrail-scope`.
- Mai `git add -A` alla cieca — nomi di file espliciti o `git status` prima.
- Mai `--no-verify`, `--force`, `reset --hard` senza richiesta esplicita.
- Se un hook pre-commit fallisce, correggere la causa e fare un **nuovo** commit, non `--amend`.
- Se il diff contiene cambi fuori scope (formatting, rename, refactor non richiesti su codice preesistente), **stopparsi**, revertirli, e ripartire.
