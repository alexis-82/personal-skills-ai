---
name: 05-implement
description: Implementare la funzionalità seguendo un piano e una task list già definiti. Usare quando l'utente dice "implementa", "scrivi il codice", "esegui i task" o simili, e esistono già .pi-workflow/plan.md e .pi-workflow/tasks.md nel progetto. Quinta fase del workflow feature-driven.
---

# Implementazione

Fase 5/10 del workflow. Da piano a codice funzionante.

> **⚠ Output path (regola dura)**
> Tutti i file di lavoro di questa skill vanno **esclusivamente** in `.pi-workflow/` nella root del progetto:
> `.pi-workflow/spec.md`, `.pi-workflow/plan.md`, `.pi-workflow/tasks.md`, `.pi-workflow/analysis.md`, `.pi-workflow/review.md`, `.pi-workflow/test-report.md`.
> **Mai** nella root del progetto. **Mai** nella cartella della skill (quella in cui pi l'ha installata).
>
> **Prima di scrivere il primo file, obbligatorio**:
> 1. Se `.pi-workflow/` non esiste nella root del progetto, crearla.
> 2. Se trovi già uno di questi file nella **root del progetto** (residuo da sessioni precedenti), **spostalo** in `.pi-workflow/` (`git mv` se tracciato, `mv` altrimenti) prima di procedere — non duplicarlo, non ignorarlo, non ricrearne una copia.

## Cosa fare

1. Leggere `.pi-workflow/plan.md`, `.pi-workflow/tasks.md` **e le sezioni Goals/Non-Goals di `.pi-workflow/spec.md`** del progetto. Tenere i Non-Goals in mente come lista di "vietato".
2. Per ogni task in ordine:
   - Marcarlo `in_progress`.
   - Implementare la modifica minima che soddisfa il DoD.
   - Verificare rapidamente (compilazione/lint/test unitario mirato) prima di passare al successivo.
   - Marcarlo `done` in `.pi-workflow/tasks.md`.
3. Se un task rivela che il piano è sbagliato: **fermarsi**, aggiornare il piano, non improvvisare.
4. Al termine, suggerire `/skill:06-test` per la validazione completa.

## Task di scaffold e generatori

Vale per il Task 0 e per i task di scaffold che seguono un generatore (pianificati da `03-plan-tasks` a partire da `.pi-workflow/architecture.md`):

- Creare **solo cartelle + `.gitkeep`**, esattamente come nell'albero documentato. Nessun altro file (niente entrypoint, `package.json`, `__init__.py`, `go.mod`): quelli arrivano dai task successivi.
- Al termine confrontare `find <cartella> -type d` con l'albero di `architecture.md`; il task è fatto solo se coincidono.
- Dopo un generatore (es. `npm create vite`, `nest new`, `django-admin startproject`): se ha creato file o cartelle **non previsti** dall'albero, **non spostarli né cancellarli**. Elencarli e chiedere se aggiornare `architecture.md` o spostarli; solo dopo la risposta proseguire.

## Output atteso

Codice implementato + `.pi-workflow/tasks.md` aggiornato con task completati marcati `- [x]`.

## Regole

- **[GUARDRAIL SCOPE]** Modifica solo il codice strettamente necessario al task. Niente pulizie opportunistiche, riformattazioni, rinomine o refactor non richiesti. Vedi la skill `guardrail-scope`.
- **[NON-GOALS]** Prima di ogni modifica, verificare che non violi un Non-Goal dichiarato in `.pi-workflow/spec.md`. Se un task ti sta portando a violare un Non-Goal, **fermati** e segnalalo — probabilmente il piano ha un problema.
- Un task alla volta — no batch di modifiche non correlate.
- No feature extra oltre spec: se serve qualcosa fuori scope, aggiungerlo come nuovo task, non implementarlo di nascosto.
- Preferire modificare file esistenti a crearne di nuovi.
- Se un test esistente si rompe per una modifica non voluta, capire perché prima di "aggiustarlo".
- Se trovi un problema fuori scope: **segnalalo**, non risolverlo.
