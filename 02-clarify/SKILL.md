---
name: 02-clarify
description: Chiarire una spec attraverso un dialogo di brainstorming con lo sviluppatore — esplorare alternative tecniche, stack, architettura, approcci e trade-off, poi risolvere le ambiguità residue. Usare quando l'utente dice "chiarisci", "brainstorma", "esploriamo le opzioni", "quale stack usare", "quali alternative", "cosa manca", "questa spec è vaga", o quando `.claude/spec.md` contiene marker `[?]` / TODO / punti ambigui. Seconda fase del workflow feature-driven, tra spec e plan-tasks.
---

# Chiarimento requisiti + Brainstorming

Fase 2/10 del workflow. Due obiettivi intrecciati:

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

1. **Brainstorming** — dialogo aperto e bidirezionale per esplorare alternative (stack, architettura, approcci, trade-off) prima che qualunque decisione venga cementata nel piano.
2. **Convergenza** — trasformare le esplorazioni in decisioni scritte e risolvere le ambiguità puntuali residue.

Il brainstorming **non è opzionale**: anche se la spec sembra chiara, ci sono quasi sempre decisioni progettuali (stack, storage, algoritmo, pattern, boundary di responsabilità) che meritano di essere messe sul tavolo prima di pianificare i task. Saltare questa fase porta a decisioni implicite fatte in solitudine dall'AI durante l'implementazione — con costi alti per revertirle dopo.

## Cosa fare

### Fase A — Analisi (silenziosa)

1. Leggere `plan.md`, `spec.md` (template), `tasks.md` (checklist) di questa cartella.
2. Aprire `.claude/spec.md` del progetto e ispezionare rapidamente il codebase (stack esistente, convenzioni, dipendenze già presenti) per capire i vincoli reali.
3. Identificare **due categorie** di punti aperti:
   - **Ambiguità puntuali**: marker `[?]`, TODO, frasi vaghe ("gestire correttamente", "ottimizzato", "user-friendly"), assunzioni non dichiarate.
   - **Punti decisionali**: scelte con più soluzioni valide che la spec non ha ancora vincolato — es. quale libreria/framework, quale storage, quale pattern architetturale, come modellare i dati, dove tracciare i confini di responsabilità, come gestire concorrenza/errori, quale strategia di test.

### Fase B — Brainstorming (obbligatoria, interattiva)

4. Per ogni **punto decisionale** significativo aprire un dialogo diretto con lo sviluppatore. Il formato è:
   - **Contesto in una riga**: perché questa decisione conta, quali vincoli visibili già la limitano.
   - **2-4 alternative concrete e nominate**: non "opzione A vs opzione B" generiche — soluzioni riconoscibili tipo "SQLite vs Postgres vs file JSON", "async con `asyncio` vs sync + thread pool", "modulo dentro il monolite esistente vs microservizio separato".
   - **Per ciascuna alternativa**: `pro` (1-2 bullet concreti), `contro` (1-2 bullet concreti), `quando conviene` (una riga).
   - **Raccomandazione**: se una ti sembra più adatta al contesto, dichiaralo esplicitamente con la motivazione — non nascondere l'opinione, ma non imporla.
   - **Domanda focalizzata** con `AskUserQuestion` presentando le alternative come opzioni. Lascia sempre lo spazio a una quinta strada proposta dallo sviluppatore.

5. Se lo sviluppatore propone un'alternativa non nella lista, **discuterla**: pro/contro con la stessa struttura, poi confronto con le altre. Il brainstorming è bidirezionale, non un menu chiuso.

**Temi da coprire in brainstorming** (quando applicabili al progetto):

- **Stack tecnico**: linguaggio, framework, librerie chiave, versioni.
- **Persistenza**: DB relazionale, NoSQL, file, in-memory, cache layer, formato.
- **Architettura / concorrenza**: sync/async, worker/queue, batch/streaming, monolite/modulare, event-driven.
- **Modello dati**: schema, relazioni, denormalizzazione, invarianti, migrazioni.
- **Interfaccia esposta**: CLI/HTTP/libreria/UI; formato input/output; contratto pubblico.
- **Gestione errori**: fail-fast vs graceful degradation, retry, idempotenza, dead letter.
- **Testing**: livelli (unit/integration/e2e), fixture vs mock, container di test.
- **Deploy / esecuzione**: locale, container, serverless, cron, on-demand, distribuzione.
- **Osservabilità**: logging, metrics, tracing — livello opportuno per lo scope.

Non serve toccarli tutti — solo quelli **realmente aperti** per questa feature. Se la spec dice già "usa Postgres esistente", non ribrainstormare la persistenza.

#### Architettura (solo greenfield)

Punto decisionale **obbligatorio** quando il progetto è greenfield. Si affronta **dopo** aver chiuso lo stack tecnico.

a. **Rilevare il greenfield**: il progetto è greenfield se non contiene file sorgente (`.py`, `.js`, `.mjs`, `.ts`, `.jsx`, `.tsx`, `.vue`, `.go`, `.sh`, ecc.). Non contano README, LICENSE, `.gitignore`, file di configurazione (`package.json`, `pyproject.toml`, `go.mod`, ...) e `.claude/`. Nei casi dubbi (es. un solo script di prova, codice generato) chiedere all'utente. **Non greenfield ⇒ saltare questa sezione**: non proporre una nuova architettura, non scrivere `architecture.md`.
b. **Se `.claude/architecture.md` esiste già**: chiedere se tenerlo così com'è o rifare la scelta. Se va tenuto, chiudere qui la sezione.
c. **Stack prima, architettura dopo**: chiudere linguaggio e framework prima di questa decisione. Se il framework resta aperto, decidere su linguaggio + tipo di progetto.
d. **Aprire il riferimento** `architectures/<linguaggio>.md` di questa cartella (`python.md`, `js-ts.md`, `go.md`, `bash.md`) e cercare la voce per tipo di progetto + framework.
   - **Multi-stack** (es. API Python + SPA React): aprire un file per stack e comporre gli alberi sotto cartelle di primo livello (`backend/`, `frontend/`), ognuno con le convenzioni del proprio stack al suo interno. Niente cartelle di stack diversi in collisione alla root.
   - **Nessun riferimento curato** (linguaggio non coperto o combinazione assente nel file): dichiararlo esplicitamente ("nessun riferimento curato per <combinazione>"), poi proporre alternative col formato standard del brainstorming **senza presentarle come curate**.
e. **Principio guida**: architettura idiomatica rispetto a linguaggio, framework e tipo di progetto, privilegiando semplicità, manutenibilità, testabilità e separazione delle responsabilità. **Nessun pattern senza una necessità reale**: MVC, layer, hexagonal ecc. solo dove il caso d'uso lo giustifica. In dubbio, la voce più semplice che regge il caso d'uso.
f. **Proporre 2-4 pattern** col formato standard (contesto, alternative con pro/contro/quando conviene, raccomandazione), mostrando per ciascuno l'albero di cartelle. Nell'albero sostituire i segnaposto dei riferimenti (`<pkg>`, `<nome>`, `<dominio>`, ...) con nomi concreti del progetto: lo scaffold crea le cartelle esattamente come scritte. Chiedere conferma dell'albero con `AskUserQuestion`. Senza conferma non si scrive nulla.
g. **In Fase C**, dopo la conferma, scrivere `.claude/architecture.md` con questo template:

   ```markdown
   # Architettura

   ## Pattern
   <nome del pattern> — <riferimento curato usato, oppure "nessun riferimento curato">

   ## Motivazione
   <perché questo pattern per linguaggio + framework + tipo di progetto>

   ## Alternative scartate
   - <alternativa> — <motivo>

   ## Albero
   <albero di cartelle confermato>

   ## Responsabilità
   - `<cartella>/` — <cosa contiene e cosa NON contiene>

   ## Test
   <dove vanno i test e di che tipo>

   ## Note
   Lo scaffold crea solo cartelle + `.gitkeep`; i `.gitkeep` restano anche quando le cartelle vengono popolate.
   ```

**Divieto**: questa fase **non crea cartelle né file nel progetto**. Lo scaffold lo pianifica `03-plan-tasks` come Task 0 e lo esegue `05-implement`.

### Fase C — Convergenza e scrittura

6. Per ogni **ambiguità puntuale** residua (non decisionale) formulare **una** domanda chiusa (sì/no o opzioni multiple) — mai domande aperte a cascata. Usare `AskUserQuestion`.
7. Verificare che la sezione **Non-Goals** esista e sia specifica. Se manca o è vaga, proporre 3-5 Non-Goals candidati dedotti dal contesto e dalle decisioni prese in brainstorming, e chiedere conferma — è il momento giusto per fissare i binari.
8. Aggiornare `.claude/spec.md` del progetto con:
   - Nuova sezione **"Decisioni prese"** con: decisione, alternative valutate, motivazione (1-2 righe).
   - Se è stata scelta un'architettura: una riga in "Decisioni prese" con il pattern e il rinvio a `.claude/architecture.md`, senza duplicare l'albero.
   - Se è stata scelta un'architettura: scrivere `.claude/architecture.md` col template del punto (g) della sottosezione "Architettura (solo greenfield)".
   - Risposte alle domande e rimozione dei marker `[?]` risolti.
   - Non-Goals confermati/aggiunti.
9. Se restano ambiguità non risolvibili ora, marcarle come `[?risolvere-dopo: <motivo>]`.

## Output atteso

`.claude/spec.md` del progetto con:
- Nessun marker `[?]` non risolto (o marcato esplicitamente `[?risolvere-dopo]`).
- Sezione **"Decisioni prese"** che documenta le scelte fatte in brainstorming, con motivazione breve e alternative scartate.
- Non-Goals specifici e confermati.

## Regole

- **Il brainstorming è obbligatorio** — anche se sembra che "sia tutto chiaro", cerca almeno un punto decisionale (stack, modello dati, boundary, gestione errori) da mettere sul tavolo. Se davvero non ce n'è (spec pre-chiusa dallo sviluppatore), dichiararlo esplicitamente prima di procedere.
- **Massimo 4 domande per turno** — se ci sono molti punti decisionali, iterare su turni multipli piuttosto che sommergere lo sviluppatore.
- **Pro/contro concreti**, non generici: "più veloce" senza dire quanto ≠ utile; "più semplice" senza dire in cosa ≠ utile. Cita numeri, dipendenze, righe di codice, LoE indicativo quando possibile.
- **Non decidere per l'utente**: proponi, valuta insieme, poi scrivi la scelta. Ma non essere neutro se hai un'opinione — dichiarala.
- **Il brainstorming è divergente prima di essere convergente**: mostra le alternative *prima* di eleggere una vincitrice, anche quando hai già in mente la risposta.
- **Non riscrivere la spec da zero** — modifica chirurgica, aggiungendo la sezione "Decisioni prese".
- Se emergono ambiguità che cambiano la spec di fondo (Goals rivisti, scope allargato), tornare a `/01-spec`.
- Se la spec è genuinamente chiusa e tutte le decisioni sono già state prese esplicitamente, dichiararlo e passare a `/03-plan-tasks`.
