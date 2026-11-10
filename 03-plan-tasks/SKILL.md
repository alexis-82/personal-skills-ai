---
name: 03-plan-tasks
description: Trasformare una spec chiarita in un piano tecnico e una lista di task azionabili. Usare quando l'utente dice "pianifica", "scomponi in task", "fammi un piano di implementazione" e c'è già una spec pronta. Terza fase del workflow feature-driven, prima di implementare.
---

# Piano tecnico e task breakdown

Fase 3/10 del workflow. Da spec a lista di lavoro eseguibile.

> **⚠ Output path (regola dura)**
> Tutti i file di lavoro di questa skill vanno **esclusivamente** in `.claude/` nella root del progetto:
> `.claude/spec.md`, `.claude/plan.md`, `.claude/tasks.md`, `.claude/analysis.md`, `.claude/review.md`, `.claude/test-report.md`, `.claude/architecture.md`.
> **Mai** nella root del progetto. **Mai** nella cartella della skill (`~/.claude/skills/...`).
>
> **Prima di scrivere il primo file, obbligatorio**:
> 1. Se `.claude/` non esiste nella root del progetto, crearla.
> 2. Se trovi già uno di questi file nella **root del progetto** (residuo da sessioni precedenti), **spostalo** in `.claude/` (`git mv` se tracciato, `mv` altrimenti) prima di procedere — non duplicarlo, non ignorarlo, non ricrearne una copia.
>
> Nota: dentro la cartella di questa skill esistono `plan.md`/`spec.md`/`tasks.md` — sono **template di riferimento**, si leggono ma non si toccano. I file di lavoro veri stanno solo in `.claude/` del progetto.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella come riferimento metodologico.
2. Leggere `.claude/spec.md` del progetto (output della fase 01/02).
3. Ispezionare il codebase per capire architettura esistente, stack, convenzioni (Glob/Grep sui file principali).
   - **Se esiste `.claude/architecture.md`** (scritto da `02-clarify`): leggerlo e trattarlo come vincolo strutturale. Ogni file citato in `plan.md` va collocato in una cartella prevista dall'albero documentato; non inventare una struttura diversa. Se una feature richiede davvero una cartella fuori albero, segnalarlo nei rischi di `plan.md`.
   - **Task 0 di scaffold**: generarlo in testa a `tasks.md` **solo se** il progetto è ancora greenfield (nessun file sorgente, stesso criterio di `02-clarify`) **e** l'albero documentato contiene almeno una cartella. Contenuto: creare solo le cartelle dell'albero, ognuna con un `.gitkeep`; nessun altro file (niente `__init__.py`, `go.mod`, `package.json`, entrypoint). Formato: `- [ ] Task 0: Creare l'albero di cartelle da .claude/architecture.md (solo cartelle + .gitkeep) — DoD: l'albero su disco corrisponde a quello documentato e non contiene altri file`.
   - **Generatori di progetto** (es. `npm create vite`, `wails init`, `django-admin startproject`, `nest new`): molti pretendono una directory vuota o inesistente e su una directory già popolata si bloccano o propongono di cancellarla. Escludere dal Task 0 le cartelle che il generatore crea o possiede, con le loro sottocartelle. Aggiungere subito dopo il task del generatore un task di scaffold per quelle cartelle (solo cartelle + `.gitkeep`). Se il generatore opera sulla root del progetto, non generare il Task 0: lo scaffold va interamente nel task che segue il generatore.
   - **Senza `architecture.md`**: comportamento invariato.
4. Produrre `.claude/plan.md` nel progetto con: approccio tecnico, file da toccare, ordine di implementazione, rischi. Creare la cartella `.claude/` se non esiste.
5. Produrre `.claude/tasks.md` nel progetto con task numerati, ciascuno:
   - piccolo (< 2h di lavoro)
   - indipendentemente testabile
   - con criterio di "fatto" esplicito
6. Suggerire di procedere con `/04-analyze` per validare il piano o `/05-implement` per partire.

## Output atteso

- `.claude/plan.md` del progetto: approccio + rischi + ordine.
- `.claude/tasks.md` del progetto: checklist `- [ ] Task N: <descrizione> — DoD: <criterio>`.

## Regole

- Ogni task deve essere richiudibile (fatto/non fatto), non "lavora su X".
- Non stimare tempi se non richiesto: la granularità sostituisce la stima.
- Se emergono ambiguità nella spec, tornare a `/02-clarify`.
