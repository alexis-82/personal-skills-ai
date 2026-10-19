---
name: 01-spec
description: Definire la specifica di una nuova funzionalità partendo da un'idea o richiesta grezza, con Goals e Non-Goals espliciti. Usare quando l'utente vuole "specificare", "definire i requisiti", "scrivere la spec" o "documentare cosa fare" prima di iniziare a sviluppare. Prima fase del workflow feature-driven.
---

# Specifica funzionalità

Fase 1/9 del workflow. Trasforma un'idea in una specifica azionabile con confini chiari.

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

## Passo 0 — Profilo progetto (prima di tutto)

Prima di leggere i template e prima di qualunque domanda sulla feature, stabilire il **profilo del progetto**. Il profilo decide a chi si rivolge il `README.md` del progetto (lo aggiorna `09-commit`).

1. **Se esiste `.claude/project-profile.md` con un profilo valido** → leggerlo e scrivere in chat `Profilo progetto: <software|homelab>`. Non ripetere la domanda.
2. **Se non esiste**, oppure la riga `profile:` manca o ha un valore diverso da `software`/`homelab` → chiedere con `AskUserQuestion`, come **prima** domanda della sessione:
   - **Software** — prodotto per l'utente finale: il README parla solo del software e del suo uso (installazione, utilizzo, configurazione), niente build, compilazione, toolchain o sviluppo. Le note di sviluppo vanno in `.claude/development.md`.
   - **Homelab** — progetto da riprodurre: il README è per lo sviluppatore, dettagliato e riproducibile (prerequisiti, setup passo-passo, build, deploy, struttura).

   Poi creare `.claude/project-profile.md` con questo formato:
   ```markdown
   # Profilo progetto
   profile: software
   ```
   (`profile:` vale `software` oppure `homelab`.)
3. **Se l'utente chiede di cambiare profilo** (in qualunque momento) → riscrivere solo la riga `profile:`, togliere l'eventuale riga `readme-aligned: true` (il README va riallineato al nuovo profilo) e scrivere in chat il nuovo profilo.

La riga opzionale `readme-aligned: true` la scrive solo `09-commit`, dopo la ristrutturazione una tantum del README: questa skill non la aggiunge mai.

## Cosa fare

1. Leggere `plan.md` per il metodo, `spec.md` come template di output, `tasks.md` per la checklist operativa.
2. Chiedere all'utente (o dedurre dal contesto) chi sono gli utenti, cosa devono ottenere e con quali vincoli.
3. Compilare `.claude/spec.md` nella cartella del progetto (non in questa cartella skill, non nella root). Creare la cartella `.claude/` se non esiste. Il file deve contenere **tutte** le sezioni sotto, incluse Goals e Non-Goals.
4. Rileggere Non-Goals con l'utente prima di procedere — è la sezione più importante per prevenire scope creep.
5. Al termine, suggerire di passare a `/02-clarify` se restano ambiguità, altrimenti a `/03-plan-tasks`.

## Output atteso

Un file `.claude/spec.md` nel progetto con queste sezioni **obbligatorie**:

- **Obiettivo** — una frase che riassume perché questa feature esiste.
- **Goals** — 3-7 bullet con cosa la feature **deve** fare. Ogni goal deve essere verificabile (superato/fallito), non aspirazionale.
- **Non-Goals** — 3-7 bullet con cosa la feature **non deve** fare, esplicitamente. Include: funzionalità correlate ma escluse, casi d'uso non supportati, ottimizzazioni non richieste, refactor collaterali. Serve a delimitare lo scope in modo hard.
- **User stories** — `Come <ruolo>, voglio <azione>, per <beneficio>`.
- **Criteri di accettazione** — condizioni oggettive per dichiarare la feature "fatta".
- **Vincoli tecnici** — stack, compatibilità, performance, sicurezza.
- **Ambiguità aperte** — marcate `[?]`, da risolvere in fase 02.

In più, `.claude/project-profile.md` presente (creato al Passo 0 se mancava).

## Come scrivere i Non-Goals

Un buon Non-Goal è **specifico** e **plausibile** — descrive qualcosa che qualcuno *potrebbe pensare* sia incluso ma non lo è. Il file `spec.md` di questa cartella contiene una sezione **"Esempi di Non-Goals per tipo di software"** con casi per script Python, librerie, CLI, servizi, pipeline ML, app desktop. Usali come punto di partenza calibrato al progetto corrente.

Forma generale di un buon Non-Goal:
- "**NON** _funzionalità/comportamento specifico_" (verificabile a colpo d'occhio)
- oppure "**NON** _modificare X_ anche se durante il lavoro emerge Y" (blocca scope creep)

Non-Goal **cattivo** (troppo vago, non azionabile): "non fare cose fuori scope", "non introdurre bug", "non peggiorare le performance".

## Adattare il vocabolario al progetto

Questa skill funziona per **qualunque tipo di software**. Adatta il vocabolario a ciò che stai costruendo:

- **Script / analisi dati**: "input", "output", "step della pipeline"
- **Libreria / modulo**: "funzioni pubbliche", "classi esposte", "API della libreria"
- **CLI tool**: "comandi", "flag", "formato input/output"
- **Servizio / backend**: "endpoint", "messaggi", "schema"
- **App desktop / frontend**: "schermate", "componenti", "flussi utente"
- **Pipeline ML / ETL**: "step", "artefatti", "dataset"

Il template `spec.md` non impone un vocabolario — usa quello del tuo dominio.

## Regole

- Non implementare nulla in questa fase.
- Non decidere lo stack tecnico se non è già vincolato — questo è compito di `03-plan-tasks`.
- Se qualcosa è ambiguo, marcarlo con `[?]` invece di inventare.
- La spec **non** è completa se manca la sezione Non-Goals — è un errore comune saltarla e porta a scope creep in fase di implementazione.
- Se l'utente non sa cosa sono i Non-Goals, proporne 3 candidati dedotti dal contesto e chiedere conferma.
