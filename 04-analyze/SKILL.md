---
name: 04-analyze
description: Analisi critica di un piano tecnico, del codice esistente o di un problema prima di implementare. Usare quando l'utente dice "analizza", "verifica il piano", "cerca rischi", "trova bug" o vuole una revisione preliminare. Quarta fase del workflow feature-driven, opzionale ma consigliata per feature complesse.
---

# Analisi critica

Fase 4/9 del workflow. Trova i problemi prima che diventino costosi.

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

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. Leggere `.pi-workflow/spec.md`, `.pi-workflow/plan.md`, `.pi-workflow/tasks.md` del progetto.
3. Analizzare su 4 assi:
   - **Correttezza**: il piano copre tutti i criteri di accettazione della spec?
   - **Impatto**: quali parti del codice esistente vengono toccate? Regressioni possibili?
   - **Sicurezza**: input non fidati, autenticazione, autorizzazione, secret, injection.
   - **Prestazioni**: query N+1, loop nested, chiamate di rete non necessarie.
4. Produrre `.pi-workflow/analysis.md` nel progetto con findings elencati, ognuno con severità (blocker/major/minor) e file:linea.
5. Se ci sono blocker, tornare a `/skill:03-plan-tasks` per aggiornare il piano.

## Output atteso

`.pi-workflow/analysis.md` nel progetto con findings numerati e severità, oppure dichiarazione esplicita "nessun problema rilevato" con giustificazione.

## Regole

- Ogni finding deve avere uno scenario di fallimento concreto (input → comportamento sbagliato), non solo "potrebbe rompersi".
- Non riscrivere il piano — segnala e basta.
- Preferire pochi finding solidi a molti speculativi.
