<div align="center">

# Feature-Driven Workflow — pi Skills

**10 skill per pi che portano una funzionalità dalla spec al commit, senza uscire dallo scope.**

[![Version](https://img.shields.io/badge/version-2.0.0-blue?style=plastic)](CHANGELOG.md)&nbsp;&nbsp;&nbsp;[![pi](https://img.shields.io/badge/pi-skills-8A2BE2?style=plastic)](https://pi.dev)&nbsp;&nbsp;&nbsp;[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-standard-555555?style=plastic)](https://pi.dev/docs/latest/skills)&nbsp;&nbsp;&nbsp;[![Markdown](https://img.shields.io/badge/Markdown-000000?style=plastic&logo=markdown&logoColor=white)](#)&nbsp;&nbsp;&nbsp;[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey?style=plastic)](#)&nbsp;&nbsp;&nbsp;[![Last commit](https://img.shields.io/github/last-commit/alexis-82/personal-skills-claude/pi-testing?style=plastic)](https://github.com/alexis-82/personal-skills-claude/commits/pi-testing)

</div>

---

<a id="indice"></a>
## 📑 Indice

- [✨ Cos'è](#cose)
- [🧩 Le 10 skill, seguire il workflow in questo ordine](#le-10-skill-seguire-il-workflow-in-questo-ordine)
- [🧠 Concetti chiave](#concetti-chiave)
- [🚀 Installazione](#installazione)
- [🛠️ Come si usano](#come-si-usano)
- [💡 Esempio di flusso completo](#esempio-di-flusso-completo)
- [📁 Struttura file](#struttura-file)
- [🎨 Personalizzazione](#personalizzazione)
- [📝 Note](#note)

---

<a id="cose"></a>
## ✨ Cos'è

Set di **10 skill** per [pi](https://pi.dev) che strutturano lo sviluppo di una funzionalità in fasi discrete, dalla spec iniziale al commit finale, con un **guardrail cross-cutting** che impedisce all'AI di uscire fuori dallo scope della richiesta.

Le skill seguono lo standard **Agent Skills** (cartella con `SKILL.md`) e si installano come **pi package**. Sono **stack-agnostic**: funzionano per script Python, librerie, CLI tool, servizi web, pipeline ML, app desktop, e qualunque altro tipo di software.

---

<a id="le-10-skill-seguire-il-workflow-in-questo-ordine"></a>
## 🧩 Le 10 skill, seguire il workflow in questo ordine

| # | Comando | Ruolo | Output principale |
|---|---------|-------|-------------------|
| 01 | `/skill:01-spec` | Definire requisiti + Goals + **Non-Goals** | `.pi-workflow/spec.md` nel progetto |
| 02 | `/skill:02-clarify` | Brainstorming interattivo (stack, architettura, alternative) + risoluzione ambiguità | `spec.md` chiarito con "Decisioni prese" |
| 03 | `/skill:03-plan-tasks` | Piano tecnico + task breakdown | `.pi-workflow/plan.md` + `.pi-workflow/tasks.md` |
| 04 | `/skill:04-analyze` | Analisi critica del piano | `.pi-workflow/analysis.md` |
| 05 | `/skill:05-implement` | Scrivere il codice | Codice + `.pi-workflow/tasks.md` aggiornato |
| 06 | `/skill:06-test` | Test contro criteri di accettazione | Suite verde |
| 07 | `/skill:07-review` | Code review del codice implementato (correttezza, edge case, sicurezza, prestazioni, leggibilità) | `.pi-workflow/review.md` con findings per severità |
| 08 | `/skill:08-refactor` | Pulire con i test come rete di sicurezza | Codice più leggibile, comportamento invariato |
| 09 | `/skill:09-commit` | `CHANGELOG.md` aggiornato + commit strutturati + eventuale PR | Storia git pulita + `CHANGELOG.md` nella root |
| 10 ⚠ | `/skill:10-guardrail-scope` | Cross-cutting: Guardrail AI | — |

Ordine tipico: `spec → clarify → plan-tasks → (analyze) → implement → test → (review) → (refactor) → commit`. Le fasi `04-analyze`, `07-review` e `08-refactor` sono opzionali.

---

<a id="concetti-chiave"></a>
## 🧠 Concetti chiave

### Goals / Non-Goals

Ogni `.pi-workflow/spec.md` contiene due sezioni obbligatorie:

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

1. **Check n°1** — se esiste `.pi-workflow/spec.md` con Non-Goals, quelli sono la fonte di verità prioritaria.
2. **Check n°2** — anche in loro assenza, no pulizie opportunistiche, no riformattazioni, no rinomine collaterali, no refactor spontanei.
3. **Auto-verifica pre-commit** — ogni riga del diff deve essere motivabile con il task richiesto. Se no, va rimossa.

Se durante il lavoro emergono problemi fuori scope, l'AI li **segnala** ma non li risolve senza autorizzazione.

### CHANGELOG automatico

A ogni ciclo `09-commit` crea o aggiorna `CHANGELOG.md` nella **root del progetto** (non in `.pi-workflow/`), nel formato [Keep a Changelog](https://keepachangelog.com/) + [SemVer](https://semver.org/), con voci in inglese:

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

<a id="installazione"></a>
## 🚀 Installazione

Le skill si installano come **pi package**, direttamente da questo branch:

```bash
pi install git:github.com/alexis-82/personal-skills-claude@pi-testing
```

Oppure da un clone locale del repo:

```bash
git clone -b pi-testing https://github.com/alexis-82/personal-skills-claude.git
pi install ./personal-skills-claude
```

Il `package.json` del repo dichiara le 10 cartelle skill nella chiave `pi.skills`, quindi pi carica solo quelle.

| Operazione | Comando |
|------------|---------|
| Installare solo per il progetto corrente (scrive in `.pi/settings.json`) | `pi install -l <sorgente>` |
| Riallineare i package installati | `pi update --extensions` |
| Vedere i package installati | `pi list` |
| Disinstallare | `pi remove <sorgente>` |

Dopo un'installazione o un aggiornamento in una sessione già aperta, esegui `/reload`. Se dopo nuovi commit sul branch la versione installata non cambia, reinstalla con `pi install <sorgente>`.

> **Da verificare al primo avvio**: le cartelle skill contengono anche i template `plan.md`, `spec.md`, `tasks.md`. All'avvio di pi controlla nelle diagnostiche che le skill caricate siano **esattamente 10** e che i template non compaiano come skill a sé.

### Guardrail sempre attivo (opzionale)

Come skill, `10-guardrail-scope` si attiva quando la invochi o quando il modello la riconosce dalla descrizione. Se vuoi che le sue regole valgano **in ogni sessione**, copia a mano le sezioni che ti interessano (Principio, Check n°1, Check n°2) nel context file globale di pi:

```
~/.pi/agent/AGENTS.md
```

pi carica `AGENTS.md` sempre, senza bisogno di invocarlo. Il package non scrive mai in questo file: la scelta resta tua.

---

<a id="come-si-usano"></a>
## 🛠️ Come si usano

### Invocazione esplicita

In pi le skill si invocano con il prefisso `/skill:`. Il testo dopo il nome viene passato come richiesta:

```
/skill:01-spec voglio esportare gli utenti in CSV
/skill:05-implement
/skill:10-guardrail-scope
```

La voce di settings `enableSkillCommands` decide se i comandi `/skill:` compaiono nel completamento; digitati a mano funzionano comunque.

### Attivazione automatica

All'avvio pi mette nome e `description` di ogni skill nel prompt di sistema, e il modello carica la skill adatta quando la richiesta corrisponde. Frasi che le triggerano:

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

L'attivazione automatica non è garantita: se il modello non carica la skill, usa `/skill:<nome>`.

---

<a id="esempio-di-flusso-completo"></a>
## 💡 Esempio di flusso completo

Immagina di dover aggiungere un endpoint di export in un servizio Python esistente.

```
> /skill:01-spec voglio esportare gli utenti in CSV via endpoint GET /users/export

[AI compila .pi-workflow/spec.md con Goals + Non-Goals + interfaccia + criteri]

> ok procedi

> /skill:02-clarify

[AI apre un brainstorming: presenta 2-4 alternative per i punti decisionali
 (es. formato CSV via streaming vs in-memory, autenticazione richiesta o no,
 paginazione o dump completo) con pro/contro concreti e opzioni numerate,
 e tu rispondi col numero. Poi 2-3 domande chiuse per le ambiguità puntuali
 e propone Non-Goals aggiuntivi. Aggiunge la sezione "Decisioni prese" a spec.md]

> /skill:03-plan-tasks

[AI ispeziona il codebase, produce .pi-workflow/plan.md e .pi-workflow/tasks.md con 4 task]

> /skill:05-implement

[AI implementa task 1..4, tenendo d'occhio i Non-Goals; se emerge un problema fuori scope, lo segnala]

> /skill:06-test

[AI scrive test per ogni criterio di accettazione, verifica suite verde]

> /skill:07-review  (opzionale)

[AI revisiona il codice su 5 assi (correttezza, edge case, sicurezza, prestazioni,
 leggibilità), produce .pi-workflow/review.md con findings per severità. Se ci sono
 blocker/major, torna a /skill:05-implement; altrimenti prosegue.]

> /skill:08-refactor  (opzionale)

[AI pulisce solo il codice appena scritto, non tocca il resto]

> /skill:09-commit

[AI rilegge il diff riga per riga, propone la voce ## [1.3.0] - <data> per il
 CHANGELOG e attende conferma, poi crea commit separati per feature (con CHANGELOG)
 e refactor]
```

In qualunque momento puoi dire **"attenzione allo scope"** per invocare esplicitamente `10-guardrail-scope` come promemoria.

---

<a id="struttura-file"></a>
## 📁 Struttura file

```
personal-skills-claude/
├── README.md                    # questo file
├── CHANGELOG.md
├── package.json                 # manifest pi package (chiave "pi.skills")
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

Ogni cartella skill contiene:
- `SKILL.md` — istruzioni per l'AI (con frontmatter YAML `name` e `description`)
- `plan.md`, `spec.md`, `tasks.md` — template e checklist di supporto (dove applicabile), letti dalla skill per percorso relativo

---

<a id="personalizzazione"></a>
## 🎨 Personalizzazione

- **Vocabolario**: adatta i termini della `spec.md` al tuo dominio. Il template è neutro (parla di "consumatori", "interfaccia", "unità di codice") — sostituisci con "endpoint", "comando", "modulo", "componente", ecc. secondo il progetto.
- **Fasi**: se non ti serve una fase (es. analisi o refactor), saltala. Il workflow non è rigido.
- **Non-Goals per stack**: `01-spec/spec.md` ha esempi per 6 tipi di software; aggiungi i tuoi se lavori su domini ricorrenti (embedded, mobile, ecc.).
- **Solo invocazione esplicita**: se non vuoi che il modello attivi una skill da solo, aggiungi `disable-model-invocation: true` al suo frontmatter; resterà disponibile con `/skill:<nome>`.
- **Modifiche locali**: dopo aver modificato una skill durante una sessione, esegui `/reload`.

---

<a id="note"></a>
## 📝 Note

- Le skill sono in italiano ma il codice generato segue le convenzioni del progetto (inglese se il codebase è in inglese).
- I file `plan.md` / `spec.md` / `tasks.md` nelle cartelle skill sono **template di riferimento**, non vengono modificati durante l'uso. I file di lavoro veri vivono **sempre** nel progetto sotto `.pi-workflow/` (`spec.md`, `plan.md`, `tasks.md`, `analysis.md`, `review.md` e l'eventuale `test-report.md`). Mai nella root del progetto, mai nella cartella della skill — regola rafforzata dal Check n°3 di `10-guardrail-scope`.
- `.pi-workflow/` è distinta da `.pi/`: quest'ultima è la cartella di configurazione di pi, che viene caricata solo dopo aver concesso la fiducia al progetto.
- Se dopo una sessione trovi uno di questi file nella root del progetto (residuo da sessioni precedenti), spostalo dentro `.pi-workflow/`: le skill sanno gestirlo, ma un file omonimo in root può confondere le fasi successive.
- **Domande in `02-clarify`**: pi non ha uno strumento integrato per le domande a scelta multipla, quindi la skill le scrive in chat con opzioni numerate. Se un'estensione fornisce uno strumento di domanda strutturata, la skill lo usa.
- **Nessuna sandbox**: pi non ha un sistema di permessi; il guardrail di scope è un'istruzione per il modello, non un blocco tecnico.
- La skill `10-guardrail-scope` è pensata anche per essere invocata fuori dal workflow feature-driven, in qualunque task che tocchi codice.
