# Architetture idiomatiche — Bash

Riferimento per la sezione "Architettura (solo greenfield)" di `02-clarify/SKILL.md`.
In Bash la struttura migliore è quasi sempre la più piccola: un'architettura a layer è **overengineering**. Si sale di voce solo quando lo script non sta più in testa.

---

## Script singolo

- **Pattern consigliato**: un file, funzioni con nomi espliciti, `main "$@"` in fondo; nessuna cartella e nessun layer.
- **Alternative**: "Tool multi-file" quando funzioni comuni servono a più script.
- **Albero**:
  ```
  backup.sh
  ```
- **Naming**: file `kebab-case.sh`; funzioni `snake_case`; costanti e variabili d'ambiente `UPPER_CASE`; variabili locali con `local`.
- **Test**: nessuno per default; `shellcheck` come verifica minima. bats-core (`test/backup.bats`) solo se la logica ha rami non banali.
- **Quando NON usarlo**: oltre ~300 righe, più entrypoint o funzioni duplicate fra script ⇒ "Tool multi-file". Logica complessa (parsing JSON strutturato, strutture dati, concorrenza) ⇒ valutare un altro linguaggio invece di strutturare Bash.

Scheletro di riferimento (da scrivere nei task di implementazione, **non** nello scaffold):

```bash
#!/usr/bin/env bash
set -euo pipefail

main() {
    # ...
}

main "$@"
```

## Tool multi-file

- **Pattern consigliato**: entrypoint in `bin/`, funzioni condivise in `lib/` caricate con `source`, nessuna logica a livello top-level nelle lib.
- **Alternative**: script singolo con sezioni di funzioni ben separate, se gli entrypoint sono 1-2.
- **Albero**:
  ```
  bin/
    <tool>           # entrypoint eseguibile, senza estensione
  lib/
    <area>.sh        # solo definizioni di funzioni
  test/              # bats-core, se previsto
  ```
- **Naming**: entrypoint senza estensione e con `chmod +x`; lib `<area>.sh`; funzioni di lib con prefisso d'area (`log_info`, `db_backup`) per evitare collisioni.
- **Test**: bats-core in `test/` sulle funzioni di `lib/`; `shellcheck` su `bin/` e `lib/`.
- **Quando NON usarlo**: un solo entrypoint ⇒ "Script singolo".

Le lib si caricano relative all'entrypoint, non alla directory corrente (forma portabile Linux/macOS; non risolve i symlink all'entrypoint):

```bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib/log.sh"
```

---

**Combinazioni non coperte qui** (es. installer interattivi complessi, dotfiles manager, script POSIX `sh` portabili): dichiarare "nessun riferimento curato" e proporre alternative col brainstorming generico.
