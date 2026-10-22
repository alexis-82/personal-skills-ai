---
name: guardrail-scope
description: Guardrail di disciplina dello scope — vincola l'AI a modificare solo il codice strettamente necessario alla richiesta, mai fare "pulizie" opportunistiche o refactor non richiesti. Da applicare all'inizio di qualunque task che tocca codice, o quando l'utente dice "attenzione allo scope", "non toccare altro", "lavora sui binari", "solo quello che ho chiesto".
---

# Guardrail: disciplina dello scope

Regola cross-cutting che vale per **tutte** le fasi del workflow feature-driven e per qualunque modifica al codice, anche fuori dal workflow.

## Principio

L'AI lavora su binari stretti. Modifica **solo** ciò che è strettamente necessario a soddisfare la richiesta esplicita dell'utente. Tutto il resto del codebase è intoccabile — anche se sembra migliorabile.

## Check n°1: i Non-Goals dichiarati

Se esiste `.pi-workflow/spec.md` con una sezione **Non-Goals**, quella è la fonte di verità **prioritaria** su cosa NON fare. Prima di qualunque modifica:

1. Rileggere i Non-Goals.
2. Per ogni modifica pianificata, chiedersi: "questa modifica viola un Non-Goal?"
3. Se sì → **fermarsi**, non farla, segnalarlo all'utente.

I Non-Goals sono un **contratto** già firmato dall'utente in fase spec: non vanno rinegoziati implicitamente durante l'implementazione. Se un Non-Goal sembra dover cambiare, tornare a `/skill:01-spec` o `/skill:02-clarify` e aggiornarlo esplicitamente.

## Check n°2: cosa NON fare (mai, senza autorizzazione esplicita)

Anche in assenza di Non-Goals espliciti, valgono queste regole di default:


- Riordinare o "pulire" import
- Riformattare codice non modificato dal task
- Rinominare variabili/funzioni non coinvolte nel task
- Aggiungere/rimuovere commenti a codice non toccato
- Aggiungere type hints o annotazioni non richieste
- Estrarre funzioni "per pulizia" mentre si è di passaggio
- "Sistemare" bug o code smell scoperti fuori scope
- Aggiornare versioni di dipendenze non necessarie al task
- Cambiare stile del codice (spazi, virgolette, semicolon) su file toccati di passaggio
- Aggiungere test/documentazione per codice non nello scope

## Check n°3: dove finiscono i file di workflow (regola dura)

Tutti i file prodotti dalle skill di questo workflow vivono **esclusivamente** in `.pi-workflow/` nella root del progetto:

- `.pi-workflow/spec.md`
- `.pi-workflow/plan.md`
- `.pi-workflow/tasks.md`
- `.pi-workflow/analysis.md`
- `.pi-workflow/review.md`
- `.pi-workflow/test-report.md`

Regole:

1. **Mai** creare uno di questi file nella root del progetto.
2. **Mai** creare uno di questi file nella cartella della skill (quella in cui pi l'ha installata).
3. Se `.pi-workflow/` non esiste nella root del progetto, crearla **prima** di scrivere il primo file.
4. Se durante il lavoro trovi uno di questi file per errore nella root del progetto (residui da sessioni precedenti), **spostalo** (git mv se tracciato, mv altrimenti) in `.pi-workflow/` prima di procedere; non duplicarlo.
5. Il file `.pi-workflow/` è parte dei metadati del progetto, non dell'output finale: valuta con l'utente se andare in `.gitignore` o essere versionato — non è una decisione da prendere in autonomia.
6. `CHANGELOG.md` **non** è un file di workflow: è un file di prodotto e va nella **root del progetto**, mai in `.pi-workflow/` (lo gestisce `09-commit`).

Confusione da evitare: dentro ogni cartella skill (`01-spec/`, `03-plan-tasks/`, ecc., dove pi le ha installate) esistono file `plan.md`, `spec.md`, `tasks.md` — quelli sono **template/checklist di riferimento** della skill, si **leggono** ma non si toccano. I file di lavoro veri stanno **solo** in `.pi-workflow/` del progetto corrente.

## Cosa fare quando si trova un problema fuori scope

1. **Non toccarlo.**
2. Segnalarlo all'utente al termine del task: "Ho notato X in `file:linea` — vuoi che apra un task separato?"
3. Solo se l'utente conferma, aprire un nuovo intervento dedicato.

## Eccezione unica

Se un cambio **fuori scope** è tecnicamente **necessario** perché quello **dentro scope** funzioni (es. una firma di funzione che cambia obbligatoriamente in due file, un import da aggiornare), è ammesso — ma va **dichiarato esplicitamente** in output prima o durante la modifica.

## Auto-verifica prima di ogni commit

Doppia domanda su **ogni riga cambiata** nel diff:

1. "Questa riga è strettamente necessaria al task richiesto?" — se no, rimuovila.
2. "Questa riga viola un Non-Goal dichiarato in `.pi-workflow/spec.md`?" — se sì, rimuovila e segnala.

Se anche una sola risposta è ambigua, il commit non è pronto.

## Applicazione nelle fasi del workflow

- `05-implement`: implementa i task, non altro.
- `06-test`: aggiungi test per la spec corrente, non riscrivere test esistenti.
- `08-refactor`: refactor sì, ma limitato allo scope dichiarato dall'utente; anche il refactor ha binari.
- `09-commit`: il diff deve essere leggibile e ogni riga giustificabile. La nuova voce di `CHANGELOG.md` è **nello scope** del commit; le voci precedenti no (non si toccano).
