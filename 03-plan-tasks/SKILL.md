---
name: 03-plan-tasks
description: Trasformare una spec chiarita in un piano tecnico e una lista di task azionabili. Usare quando l'utente dice "pianifica", "scomponi in task", "fammi un piano di implementazione" e c'è già una spec pronta. Terza fase del workflow feature-driven, prima di implementare.
---

# Piano tecnico e task breakdown

Fase 3/10 del workflow. Da spec a lista di lavoro eseguibile.

> **⚠ Output path (regola dura)**
> Tutti i file di lavoro di questa skill vanno **esclusivamente** in `.pi-workflow/` nella root del progetto:
> `.pi-workflow/spec.md`, `.pi-workflow/plan.md`, `.pi-workflow/tasks.md`, `.pi-workflow/analysis.md`, `.pi-workflow/review.md`, `.pi-workflow/test-report.md`, `.pi-workflow/architecture.md`.
> **Mai** nella root del progetto. **Mai** nella cartella della skill (quella in cui pi l'ha installata).
>
> **Prima di scrivere il primo file, obbligatorio**:
> 1. Se `.pi-workflow/` non esiste nella root del progetto, crearla.
> 2. Se trovi già uno di questi file nella **root del progetto** (residuo da sessioni precedenti), **spostalo** in `.pi-workflow/` (`git mv` se tracciato, `mv` altrimenti) prima di procedere — non duplicarlo, non ignorarlo, non ricrearne una copia.
>
> Nota: dentro la cartella di questa skill esiste `plan-template.md` — è un **template di riferimento**, si legge ma non si tocca. I file di lavoro veri stanno solo in `.pi-workflow/` del progetto.

## Cosa fare

1. Leggere `plan-template.md` di questa cartella come template di `.pi-workflow/plan.md`.
2. Leggere `.pi-workflow/spec.md` del progetto (output della fase 01/02).
3. Ispezionare il codebase per capire architettura esistente, stack, convenzioni (cercando file e testo nei file principali).
   - **Se esiste `.pi-workflow/architecture.md`** (scritto da `02-clarify`): leggerlo e trattarlo come vincolo strutturale. Ogni file citato in `plan.md` va collocato in una cartella prevista dall'albero documentato; non inventare una struttura diversa. Se una feature richiede davvero una cartella fuori albero, segnalarlo nei rischi di `plan.md`.
   - **Task 0 di scaffold**: generarlo in testa a `tasks.md` **solo se** il progetto è ancora greenfield (nessun file sorgente, stesso criterio di `02-clarify`) **e** l'albero documentato contiene almeno una cartella. Contenuto: creare solo le cartelle dell'albero, ognuna con un `.gitkeep`; nessun altro file (niente `__init__.py`, `go.mod`, `package.json`, entrypoint). Formato: `- [ ] Task 0: Creare l'albero di cartelle da .pi-workflow/architecture.md (solo cartelle + .gitkeep) — DoD: l'albero su disco corrisponde a quello documentato e non contiene altri file`.
   - **Generatori di progetto** (es. `npm create vite`, `wails init`, `django-admin startproject`, `nest new`): molti pretendono una directory vuota o inesistente e su una directory già popolata si bloccano o propongono di cancellarla. Escludere dal Task 0 le cartelle che il generatore crea o possiede, con le loro sottocartelle. Aggiungere subito dopo il task del generatore un task di scaffold per quelle cartelle (solo cartelle + `.gitkeep`). Se il generatore opera sulla root del progetto, non generare il Task 0: lo scaffold va interamente nel task che segue il generatore. Elencare in `plan.md` i file e le cartelle che il generatore crea e confrontarli con l'albero: quelli non previsti vanno nei rischi di `plan.md`, con la proposta di aggiornare l'albero o di spostarli.
   - **Senza `architecture.md`**: comportamento invariato.
4. Produrre `.pi-workflow/plan.md` nel progetto con: approccio tecnico, file da toccare, ordine di implementazione, rischi. Creare la cartella `.pi-workflow/` se non esiste.
5. Produrre `.pi-workflow/tasks.md` nel progetto con task numerati, ciascuno:
   - piccolo (< 2h di lavoro)
   - indipendentemente testabile
   - con criterio di "fatto" esplicito
6. Suggerire di procedere con `/skill:04-analyze` per validare il piano o `/skill:05-implement` per partire.

## Output atteso

- `.pi-workflow/plan.md` del progetto: approccio + rischi + ordine.
- `.pi-workflow/tasks.md` del progetto: checklist `- [ ] Task N: <descrizione> — DoD: <criterio>`.

## Regole

- Ogni task deve essere richiudibile (fatto/non fatto), non "lavora su X".
- Non stimare tempi se non richiesto: la granularità sostituisce la stima.
- Se emergono ambiguità nella spec, tornare a `/skill:02-clarify`.
