---
name: 09-commit
description: Creare commit ben strutturati per una funzionalità completata, testata ed eventualmente refactorata. Crea o aggiorna anche il CHANGELOG.md del progetto con versione SemVer e data, e il README.md bilingue (inglese e italiano) con un template fisso, non tecnico, pensato per utenti comuni. Usare quando l'utente dice "committa", "fai il commit", "aggiorna il changelog", "aggiorna il README" a chiusura del ciclo di lavoro. Nona fase del workflow feature-driven.
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
5. **Aggiornare il README** (vedi sezione [Aggiornamento README](#aggiornamento-readme)): creare o aggiornare `README.md` nella root del progetto secondo il template bilingue (inglese + italiano), oppure dichiarare perché viene saltato.
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
   - Se **non** ci sono cambiamenti visibili a chi usa il prodotto (solo refactor, chore, test, documentazione interna) → **saltare il CHANGELOG** e scrivere in chat: "CHANGELOG non aggiornato: <motivo>". Passare al punto 5 di "Cosa fare" (README).
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

> **Eccezione al path**: `README.md` **non** è un file di workflow. Va nella **root del progetto** (`git rev-parse --show-toplevel`), mai in `.claude/` né nella cartella della skill.

**Pubblico: utenti comuni, non sviluppatori.** Il README spiega cos'è il prodotto, a cosa serve e come installarlo e usarlo, come lo si spiegherebbe a chi non ha mai programmato.

**Bilingue in un unico file**: header comune, sotto ai badge i link alle due lingue, poi la parte **inglese** e la parte **italiana**, con le stesse sezioni e lo stesso contenuto (traduzione fedele, non due testi diversi).

Eseguire i sotto-passi in ordine, **dopo** che la voce del CHANGELOG è stata confermata (o saltata):

1. **Decidere cosa fare.**
   - **README assente** → crearlo dal template (sotto-passo 2).
   - **README presente e conforme al template** (header centrato con badge `Version`, link lingua, ancore `<a id="en"></a>` e `<a id="it"></a>`) → aggiornarlo **solo se** il ciclo cambia qualcosa che un utente comune nota (una funzione nuova o cambiata, il modo di installare o di usare, i requisiti) oppure se il CHANGELOG ha una nuova versione (badge). Altrimenti **saltare** e scrivere in chat: "README non aggiornato: <motivo>".
   - **README presente ma non conforme** (incluso un README conforme al vecchio template solo italiano) → proporre la **conversione** al template, recuperando dal vecchio README solo i contenuti utili a un utente comune. Nella proposta elencare esplicitamente cosa verrà **tolto** (es. build, struttura dei sorgenti, contribuzione). Se l'utente rifiuta, non toccare il README e scrivere in chat: "README non aggiornato: conversione rifiutata".
2. **Struttura obbligatoria** — seguire esattamente questo template, inclusi i separatori `---`, `<div align="center">`, le ancore `<a id>` e le emoji:
   ```markdown
   <div align="center">

   # <Nome progetto>

   **<one-line tagline in English>**<br>
   *<tagline di una riga in italiano>*

   [![Version](https://img.shields.io/badge/version-X.Y.Z-blue?style=plastic)](CHANGELOG.md)&nbsp;&nbsp;&nbsp;[![Python](https://img.shields.io/badge/Python-3776AB?style=plastic&logo=python&logoColor=white)](#)

   🇬🇧 [English](#en)&nbsp;&nbsp;·&nbsp;&nbsp;🇮🇹 [Italiano](#it)

   </div>

   ---

   <a id="en"></a>
   <a id="contents"></a>
   ## 📑 Contents

   - [✨ What it is](#what-it-is)
   - [🚀 Installation](#installation)

   ---

   <a id="what-it-is"></a>
   ## ✨ What it is

   ...

   <a id="installation"></a>
   ## 🚀 Installation

   ...

   ---

   <a id="it"></a>
   <a id="indice"></a>
   ## 📑 Indice

   - [✨ Cos'è](#cose)
   - [🚀 Installazione](#installazione)

   ---

   <a id="cose"></a>
   ## ✨ Cos'è

   ...

   <a id="installazione"></a>
   ## 🚀 Installazione

   ...
   ```
   - **Nome progetto**: nome leggibile (dal manifest o dalla cartella del repo, senza trattini o maiuscole forzate da codice).
   - **Tagline**: una sola frase che dice cosa fa il prodotto **per l'utente**, senza gergo; in grassetto la versione inglese, sotto in corsivo la stessa frase in italiano.
   - **Link lingua**: sempre presenti, subito sotto ai badge, dentro il `<div align="center">`, puntano alle ancore `#en` e `#it`.
   - **Badge `Version`**: `X.Y.Z` = versione della voce CHANGELOG appena confermata; se il CHANGELOG è stato saltato, la prima versione già presente nel CHANGELOG; altrimenti quella da manifest o ultimo tag (senza `v`); se non ce n'è nessuna, omettere il badge. Link a `CHANGELOG.md` solo se il file esiste, altrimenti `(#)`.
   - **Badge del linguaggio**: uno solo, per il linguaggio principale del progetto, nello stesso stile (`style=plastic`, logo e colore ufficiali shields.io, link `(#)`). Facoltativo un badge piattaforma (es. `platform-Windows%20%7C%20Linux-lightgrey`) se il progetto lo dichiara. Nessun altro badge. Badge separati da `&nbsp;&nbsp;&nbsp;`.
   - **Ordine delle lingue**: prima l'inglese, poi l'italiano, separati da `---`.
   - **Sezioni**: obbligatorie `✨ What it is` / `✨ Cos'è` e `🚀 Installation` / `🚀 Installazione`. Facoltative, solo se c'è qualcosa di utile da dire, in quest'ordine dopo l'installazione:

     | Inglese (ancora) | Italiano (ancora) |
     |---|---|
     | `🧭 How to use` (`how-to-use`) | `🧭 Come si usa` (`come-si-usa`) |
     | `🛟 Troubleshooting` (`troubleshooting`) | `🛟 Problemi comuni` (`problemi-comuni`) |
     | `📄 License` (`license`) | `📄 Licenza` (`licenza`) |

     Nessun'altra sezione. Le due lingue hanno **sempre le stesse sezioni**, nello stesso ordine.
   - **Indice**: uno per lingua (`📑 Contents` / `📑 Indice`), una voce per ogni sezione presente, nello stesso ordine, con la stessa emoji e il link all'ancora. Ogni sezione è preceduta da `<a id="<ancora>"></a>`; le ancore inglesi e italiane sono diverse, quindi non si scontrano.
3. **Stile non tecnico (regola dura).**
   - Frasi brevi, seconda persona ("you can", "open" / "puoi", "apri"), si spiega **cosa fa** e **a cosa serve**, non **come è fatto**.
   - **Vietato nel README**: build/compilazione, toolchain e framework di sviluppo, dipendenze di sviluppo, struttura dei sorgenti, architettura, test, CI, linee guida di contribuzione, API interne, nomi di file/funzioni/classi del codice, variabili d'ambiente da sviluppatore, gergo non spiegato.
   - **Installazione**: il percorso più semplice per un utente comune (download dalla pagina Releases, installer, store, pacchetto), con i requisiti (sistema operativo, ecc.) detti a parole. Se l'unico modo è un comando da terminale, è ammesso il **minimo indispensabile** in un blocco copia-incolla, preceduto da istruzioni a parole (es. "Open the Terminal and paste this command" / "Apri il Terminale e incolla questo comando"). Il blocco di codice è identico nelle due lingue.
   - **Non inventare**: link di download, comandi, funzioni e requisiti si scrivono solo se esistono davvero nel progetto. Se non è chiaro come un utente comune installa o usa il prodotto, **chiedere** all'utente.
4. **Aggiornare un README conforme**: toccare solo il badge versione e le sezioni interessate dal ciclo, **in entrambe le lingue** (una modifica in inglese ha sempre la sua controparte in italiano e viceversa); aggiungere una sezione facoltativa solo se il ciclo la rende necessaria, in entrambe le lingue, aggiornando i due indici. Non riscrivere né riformattare il resto.
5. **Mostrare il README all'utente e attendere conferma**: completo se nuovo o convertito, il diff se aggiornato. L'utente può correggerlo. Non scrivere nulla prima della conferma.
6. **Scrivere il file**, mantenendo il fine riga (CRLF/LF) del file esistente; per un file nuovo, lo stesso fine riga degli altri file di testo del progetto.
7. **Mettere in stage** `README.md` con nome esplicito, nello **stesso commit della feature** (come il CHANGELOG).

**Vietato in questo passo**: creare file README separati per lingua (`README.it.md`, `README.en.md`), creare altra documentazione (`DEVELOPMENT.md`, `CONTRIBUTING.md`, `docs/`, wiki), spostare altrove i contenuti tecnici tolti dal README, modificare codice o manifest per adattarli al README.

## Output atteso

Commit creati (feature + eventuale refactor separati), git tree pulito, `.claude/tasks.md` con tutti i task marcati `- [x]`. `CHANGELOG.md` nella root del progetto creato o aggiornato con la nuova voce nel commit della feature, oppure dichiarazione esplicita in chat del perché è stato saltato. `README.md` nella root conforme al template bilingue (inglese + italiano), non tecnico, nel commit della feature, oppure dichiarazione esplicita in chat del perché è stato saltato.

## Regole

- **[GUARDRAIL SCOPE]** Prima di committare, rileggi il diff riga per riga: ogni modifica deve essere motivabile con il task richiesto. Se una riga non serve, rimuovila. Vedi la skill `guardrail-scope`.
- Mai `git add -A` alla cieca — nomi di file espliciti o `git status` prima.
- Mai `--no-verify`, `--force`, `reset --hard` senza richiesta esplicita.
- Se un hook pre-commit fallisce, correggere la causa e fare un **nuovo** commit, non `--amend`.
- Se il diff contiene cambi fuori scope (formatting, rename, refactor non richiesti su codice preesistente), **stopparsi**, revertirli, e ripartire.
