# Feature-Driven Workflow — Claude Code Skills

Set di **10 skill** per Claude Code che strutturano lo sviluppo di una funzionalità in fasi discrete, dalla spec iniziale al commit finale, con un **guardrail cross-cutting** che impedisce all'AI di uscire fuori dallo scope della richiesta.

Le skill sono **stack-agnostic**: funzionano per script Python, librerie, CLI tool, servizi web, pipeline ML, app desktop, e qualunque altro tipo di software.

---

## Indice

- [Le 10 skill, seguire il workflow in questo ordine](#le-10-skill-seguire-il-workflow-in-questo-ordine)
- [Concetti chiave](#concetti-chiave)
  - [Goals / Non-Goals](#goals--non-goals)
  - [Guardrail: disciplina dello scope](#guardrail-disciplina-dello-scope)
  - [CHANGELOG automatico](#changelog-automatico)
- [Installazione](#installazione)
  - [Windows (PowerShell)](#windows-powershell)
  - [Linux / macOS (bash)](#linux--macos-bash)
  - [Cosa fanno gli script](#cosa-fanno-gli-script)
- [Come si usano](#come-si-usano)
  - [Invocazione esplicita](#invocazione-esplicita)
  - [Attivazione automatica](#attivazione-automatica)
- [Esempio di flusso completo](#esempio-di-flusso-completo)
- [Struttura file](#struttura-file)
- [Personalizzazione](#personalizzazione)
- [Note](#note)

---

## Le 10 skill, seguire il workflow in questo ordine

| # | Skill | Ruolo | Output principale |
|---|-------|-------|-------------------|
| 01 | `01-spec` | Definire requisiti + Goals + **Non-Goals** | `.claude/spec.md` nel progetto |
| 02 | `02-clarify` | Brainstorming interattivo (stack, architettura, alternative) + risoluzione ambiguità | `spec.md` chiarito con "Decisioni prese" |
| 03 | `03-plan-tasks` | Piano tecnico + task breakdown | `.claude/plan.md` + `.claude/tasks.md` |
| 04 | `04-analyze` | Analisi critica del piano | `.claude/analysis.md` |
| 05 | `05-implement` | Scrivere il codice | Codice + `.claude/tasks.md` aggiornato |
| 06 | `06-test` | Test contro criteri di accettazione | Suite verde |
| 07 | `07-review` | Code review del codice implementato (correttezza, edge case, sicurezza, prestazioni, leggibilità) | `.claude/review.md` con findings per severità |
| 08 | `08-refactor` | Pulire con i test come rete di sicurezza | Codice più leggibile, comportamento invariato |
| 09 | `09-commit` | `CHANGELOG.md` aggiornato + commit strutturati + eventuale PR | Storia git pulita + `CHANGELOG.md` nella root |
| 10 ⚠ | `10-guardrail-scope` | Cross-cutting: Guardarail AI | — |

Ordine tipico: `spec → clarify → plan-tasks → (analyze) → implement → test → (review) → (refactor) → commit`. Le fasi `04-analyze`, `07-review` e `08-refactor` sono opzionali.

---

## Concetti chiave

### Goals / Non-Goals

Ogni `.claude/spec.md` contiene due sezioni obbligatorie:

- **Goals** — 3-7 bullet verificabili con cosa la feature **deve** fare.
- **Non-Goals** — 3-7 bullet con cosa la feature **NON** deve fare, esplicitamente.

I **Non-Goals** sono il contratto che l'utente firma con l'AI in fase 01. Vengono riletti dalle fasi successive prima di ogni modifica e servono a prevenire scope creep.

Esempio (script Python di analisi):

```markdown
## Goals
- [ ] Leggere CSV da ./in/, calcolare medie mensili, salvare in ./out/report.csv

## Non-Goals
- [ ] NON parallelizzare il calcolo
- [ ] NON persistere su DB
- [ ] NON aggiungere plot/grafici
```

Il file `01-spec/spec.md` (template nella cartella della skill) contiene esempi di Non-Goals per: script Python, librerie, CLI, servizi backend, pipeline ML, app desktop.

### Guardrail: disciplina dello scope

`10-guardrail-scope` è una skill trasversale che vincola l'AI a modificare **solo** il codice strettamente necessario alla richiesta. Regole:

1. **Check n°1** — se esiste `.claude/spec.md` con Non-Goals, quelli sono la fonte di verità prioritaria.
2. **Check n°2** — anche in loro assenza, no pulizie opportunistiche, no riformattazioni, no rinomine collaterali, no refactor spontanei.
3. **Auto-verifica pre-commit** — ogni riga del diff deve essere motivabile con il task richiesto. Se no, va rimossa.

Se durante il lavoro emergono problemi fuori scope, l'AI li **segnala** ma non li risolve senza autorizzazione.

### CHANGELOG automatico

A ogni ciclo `09-commit` crea o aggiorna `CHANGELOG.md` nella **root del progetto** (non in `.claude/`), nel formato [Keep a Changelog](https://keepachangelog.com/) + [SemVer](https://semver.org/), con voci in inglese:

```markdown
## [1.3.0] - 2026-10-17
### Added
- CSV export of users via `GET /users/export`.
```

- **Versione**: l'AI propone il bump SemVer (MAJOR = breaking, MINOR = nuova funzionalità, PATCH = fix) partendo dall'ultima voce; se il CHANGELOG non esiste legge la versione da manifest o tag, altrimenti propone `0.1.0` / `1.0.0`. **Tu confermi** versione e testo prima che il file venga scritto.
- **Data**: quella odierna, nel formato `YYYY-MM-DD`.
- **Commit**: il CHANGELOG entra nello stesso commit della feature.
- **Ogni ciclo è una nuova versione**. I cicli di solo refactor/chore/test non generano voci: l'AI lo dichiara in chat.
- **Non** crea tag o GitHub Release, **non** modifica la versione in `package.json` & co., **non** tocca le voci precedenti.

---

## Installazione

Le skill vanno installate in `~/.claude/skills/` (su Windows: `C:\Users\<utente>\.claude\skills\`). Nel repo trovi due script che copiano le 9 cartelle nella destinazione, sovrascrivendo eventuali versioni precedenti con lo stesso nome.

### Windows (PowerShell)

```powershell
.\install.ps1
```

Se PowerShell blocca l'esecuzione con un errore di execution policy, sbloccalo solo per questa sessione:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\install.ps1
```

### Linux / macOS (bash)

```bash
./install.sh
```

Se serve, rendi lo script eseguibile una volta sola: `chmod +x install.sh`.

### Cosa fanno gli script

- Creano `~/.claude/skills/` se manca.
- Rimuovono le eventuali cartelle installate con i vecchi nomi senza numerazione (`spec`, `clarify`, …) per evitare skill duplicate.
- Copiano le 10 skill (`01-spec`, `02-clarify`, `03-plan-tasks`, `04-analyze`, `05-implement`, `06-test`, `07-review`, `08-refactor`, `09-commit`, `10-guardrail-scope`), sovrascrivendo eventuali versioni precedenti con lo stesso nome.
- Al termine, riavvia Claude Code per caricare le skill aggiornate.

Ogni cartella skill contiene:
- `SKILL.md` — istruzioni per l'AI (con frontmatter YAML)
- `plan.md`, `spec.md`, `tasks.md` — template e checklist di supporto (dove applicabile)

---

## Come si usano

### Invocazione esplicita

Digita lo slash command:

```
/01-spec
/05-implement
/10-guardrail-scope
```

### Attivazione automatica

Le skill si attivano da sole in base al `description` YAML. Frasi che le triggerano:

| Se dici… | Si attiva… |
|----------|------------|
| "definisci i requisiti", "scrivi la spec" | `01-spec` |
| "chiarisci", "cosa manca", "brainstorma", "esploriamo le opzioni", "quale stack" | `02-clarify` |
| "pianifica", "scomponi in task" | `03-plan-tasks` |
| "analizza", "verifica il piano" | `04-analyze` |
| "implementa", "scrivi il codice" | `05-implement` |
| "testa", "scrivi i test" | `06-test` |
| "revisiona", "code review", "cerca bug nel codice" | `07-review` |
| "refactora", "pulisci il codice" | `08-refactor` |
| "committa", "apri PR", "aggiorna il changelog" | `09-commit` |
| "attenzione allo scope", "lavora sui binari" | `10-guardrail-scope` |

---

## Esempio di flusso completo

Immagina di dover aggiungere un endpoint di export in un servizio Python esistente.

```
> /01-spec voglio esportare gli utenti in CSV via endpoint GET /users/export

[AI compila spec.md con Goals + Non-Goals + interfaccia + criteri]

> ok procedi

> /02-clarify

[AI apre un brainstorming: presenta 2-4 alternative per i punti decisionali
 (es. formato CSV via streaming vs in-memory, autenticazione richiesta o no,
 paginazione o dump completo) con pro/contro concreti, chiede a te di scegliere.
 Poi 2-3 domande chiuse per le ambiguità puntuali e propone Non-Goals aggiuntivi.
 Aggiunge la sezione "Decisioni prese" a spec.md]

> /03-plan-tasks

[AI ispeziona il codebase, produce .claude/plan.md e .claude/tasks.md con 4 task]

> /05-implement

[AI implementa task 1..4, tenendo d'occhio i Non-Goals; se emerge un problema fuori scope, lo segnala]

> /06-test

[AI scrive test per ogni criterio di accettazione, verifica suite verde]

> /07-review  (opzionale)

[AI revisiona il codice su 5 assi (correttezza, edge case, sicurezza, prestazioni,
 leggibilità), produce .claude/review.md con findings per severità. Se ci sono
 blocker/major, torna a /05-implement; altrimenti prosegue.]

> /08-refactor  (opzionale)

[AI pulisce solo il codice appena scritto, non tocca il resto]

> /09-commit

[AI rilegge il diff riga per riga, propone la voce ## [1.3.0] - <data> per il
 CHANGELOG e attende conferma, poi crea commit separati per feature (con CHANGELOG)
 e refactor]
```

In qualunque momento puoi dire **"attenzione allo scope"** per invocare esplicitamente `10-guardrail-scope` come promemoria.

---

## Struttura file

```
skills/
├── README.md                    # questo file
├── 01-spec/
│   ├── SKILL.md                 # istruzioni AI
│   ├── plan.md                  # metodo
│   ├── spec.md                  # template output (con esempi Non-Goals per stack)
│   └── tasks.md                 # checklist
├── 02-clarify/
├── 03-plan-tasks/
├── 04-analyze/
├── 05-implement/
├── 06-test/
├── 07-review/
├── 08-refactor/
├── 09-commit/
└── 10-guardrail-scope/
    └── SKILL.md
```

---

## Personalizzazione

- **Vocabolario**: adatta i termini della `spec.md` al tuo dominio. Il template è neutro (parla di "consumatori", "interfaccia", "unità di codice") — sostituisci con "endpoint", "comando", "modulo", "componente", ecc. secondo il progetto.
- **Fasi**: se non ti serve una fase (es. analisi o refactor), saltala. Il workflow non è rigido.
- **Non-Goals per stack**: `01-spec/spec.md` ha esempi per 6 tipi di software; aggiungi i tuoi se lavori su domini ricorrenti (embedded, mobile, ecc.).
- **Memoria persistente**: il guardrail è già registrato nel sistema di memoria di Claude Code, quindi si applica **in tutte le sessioni**, anche fuori da questo workflow.

---

## Note

- Le skill sono in italiano ma il codice generato segue le convenzioni del progetto (inglese se il codebase è in inglese).
- I file `plan.md` / `spec.md` / `tasks.md` nelle cartelle skill sono **template di riferimento**, non vengono modificati durante l'uso. I file di lavoro veri vivono **sempre** nel progetto sotto `.claude/` (`spec.md`, `plan.md`, `tasks.md`, `analysis.md`, `review.md` e l'eventuale `test-report.md`). Mai nella root del progetto, mai nella cartella della skill — regola rafforzata dal Check n°3 di `10-guardrail-scope`.
- Se dopo una sessione trovi uno di questi file nella root del progetto (residuo da versioni precedenti delle skill), spostalo dentro `.claude/`: le skill ora sanno gestirlo, ma un file omonimo in root può confondere le fasi successive.
- La skill `10-guardrail-scope` è pensata anche per essere invocata fuori dal workflow feature-driven, in qualunque task che tocchi codice.
