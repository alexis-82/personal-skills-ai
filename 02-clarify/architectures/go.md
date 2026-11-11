# Architetture idiomatiche — Go

Riferimento per la sezione "Architettura (solo greenfield)" di `02-clarify/SKILL.md`.
Voci ordinate dalla più semplice alla più strutturata. In Go si parte piatti e si aggiungono package solo quando servono: **nessuna voce è MVC**, e `pkg/` non si crea per default.

---

## CLI tool

- **Pattern consigliato**: `cmd/<nome>/main.go` sottile + logica in `internal/`; package per responsabilità, non per layer.
- **Alternative**: `main.go` singolo alla root per tool piccoli (< ~500 righe); `cobra` solo se i sottocomandi sono molti.
- **Albero**:
  ```
  cmd/<nome>/
    main.go          # flag, wiring, exit code
  internal/
    <dominio>/       # es. internal/backup, internal/config
  go.mod
  ```
- **Naming**: package corti, minuscoli, singolari, senza underscore (`config`, non `configs` o `config_utils`); niente package `util`/`common`.
- **Test**: `*_test.go` accanto al codice, table-driven; `testdata/` per le fixture.
- **Quando NON usarlo**: un solo file fa tutto ⇒ `main.go` alla root, `internal/` arriva quando serve.

## Servizio HTTP

- **Pattern consigliato**: `cmd/` + `internal/` con package per dominio; handler HTTP sottili che chiamano il dominio; interfacce definite **da chi le usa**, non da chi le implementa.
- **Alternative**: layered (`internal/http`, `internal/service`, `internal/store`) quando il dominio è uno solo; hexagonal/ports-and-adapters solo con più adapter reali (es. HTTP + gRPC + CLI sullo stesso dominio).
- **Albero (per dominio)**:
  ```
  cmd/server/
    main.go          # config, wiring dipendenze, avvio
  internal/
    <dominio>/       # es. internal/order: tipi, logica, interfaccia Store
    <storage>/       # implementazioni concrete dello storage (es. postgres/, sqlite/)
    httpapi/         # router e handler (net/http o chi/echo)
  go.mod
  ```
- **Naming**: `order.Service`, non `order.OrderService`; costruttori `NewXxx`; un package per dominio, non per tipo di file.
- **Test**: `*_test.go` accanto al codice; handler con `httptest`; storage con implementazioni finte dell'interfaccia definita nel package di dominio.
- **Quando NON usarlo**: 2-3 endpoint senza persistenza ⇒ `main.go` + `handlers.go` nello stesso package.

## Libreria / modulo

- **Pattern consigliato**: package alla root del modulo; API pubblica = identificatori esportati; dettagli in `internal/`.
- **Alternative**: sotto-package pubblici quando le aree sono indipendenti e vanno importate separatamente.
- **Albero**:
  ```
  <nome>.go          # package <nome>, API pubblica
  internal/
  example_test.go    # esempi eseguibili, finiscono nella documentazione
  go.mod
  ```
- **Naming**: il nome del package fa parte dell'API (`csv.Reader`, non `csv.CSVReader`); doc comment su ogni identificatore esportato.
- **Test**: `*_test.go` accanto; `Example*` per la documentazione; package `<nome>_test` per testare solo l'API pubblica.
- **Quando NON usarlo**: codice usato da un solo binario ⇒ `internal/` di quel progetto.

---

**Combinazioni non coperte qui** (es. servizi gRPC, worker a coda, operator Kubernetes, monorepo con più binari e moduli): dichiarare "nessun riferimento curato" e proporre alternative col brainstorming generico.
