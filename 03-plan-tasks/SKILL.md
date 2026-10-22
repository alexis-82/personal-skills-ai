---
name: 03-plan-tasks
description: Trasformare una spec chiarita in un piano tecnico e una lista di task azionabili. Usare quando l'utente dice "pianifica", "scomponi in task", "fammi un piano di implementazione" e c'è già una spec pronta. Terza fase del workflow feature-driven, prima di implementare.
---

# Piano tecnico e task breakdown

Fase 3/10 del workflow. Da spec a lista di lavoro eseguibile.

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

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella come riferimento metodologico.
2. Leggere `.pi-workflow/spec.md` del progetto (output della fase 01/02).
3. Ispezionare il codebase per capire architettura esistente, stack, convenzioni (cercando file e testo nei file principali).
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
