# Architetture idiomatiche — Python

Riferimento per la sezione "Architettura (solo greenfield)" di `02-clarify/SKILL.md`.
Voci ordinate dalla più semplice alla più strutturata: partire dalla prima che regge il caso d'uso.

---

## Script / automazione

- **Pattern consigliato**: file singolo con `main()` e funzioni pure; nessun layer.
- **Alternative**: package minimo `src/<pkg>/` quando lo script supera ~300 righe o serve riuso.
- **Albero**:
  ```
  backup.py
  tests/
    test_backup.py
  ```
- **Naming**: `snake_case` per file e funzioni; entrypoint protetto da `if __name__ == "__main__":`.
- **Test**: `tests/` con pytest, solo sulle funzioni pure.
- **Quando NON usarlo**: più comandi, configurazione complessa o codice condiviso fra script ⇒ passare a "CLI".

## CLI tool

- **Pattern consigliato**: `src` layout; un modulo per comando, logica separata dal parsing degli argomenti.
- **Alternative**: file singolo con `argparse` per 1-2 comandi; `click`/`typer` se i sottocomandi sono molti.
- **Albero**:
  ```
  src/<pkg>/
    __main__.py      # entrypoint: python -m <pkg>
    cli.py           # parsing argomenti, dispatch
    commands/        # un modulo per sottocomando
    core/            # logica senza I/O di terminale
  tests/
  ```
- **Naming**: package `snake_case`; comando esposto con `[project.scripts]` in `pyproject.toml`.
- **Test**: `tests/` speculare a `src/<pkg>/`; i test di `core/` non invocano la CLI.
- **Quando NON usarlo**: un solo comando senza opzioni ⇒ "Script".

## Libreria / package

- **Pattern consigliato**: `src` layout, API pubblica esplicita in `__init__.py`, moduli interni con prefisso `_`.
- **Alternative**: flat layout (`<pkg>/` alla root) per librerie minuscole.
- **Albero**:
  ```
  src/<pkg>/
    __init__.py      # API pubblica (__all__)
    _internal.py
  tests/
  ```
- **Naming**: nome distribuzione con trattini, package importabile con underscore.
- **Test**: `tests/` fuori dal package, così i test girano contro il package installato.
- **Quando NON usarlo**: codice usato da un solo progetto ⇒ modulo dentro quel progetto.

## API HTTP (FastAPI / Flask)

- **Pattern consigliato**: un package per dominio con router, schemi, service e accesso dati; trasversale in `core/`. Fonti: FastAPI "Bigger Applications" (un router per risorsa), Flask "Project Layout" (un blueprint per dominio), zhanymkanov/fastapi-best-practices (package per dominio).
- **Alternative**: layered (`routers/ services/ repositories/`) per 1-2 domini piccoli; singolo `main.py` per prototipi o microservizi con < 5 endpoint.
- **Albero (per dominio)**:
  ```
  src/<pkg>/
    main.py          # crea app, middleware, include i router dei domini
    core/            # trasversale, nessun codice di un singolo dominio
      config.py      # settings da env (pydantic-settings)
      db.py          # engine / sessione
      security.py    # auth, dipendenze condivise
      exceptions.py  # errori base + handler
    <dominio>/       # al plurale (users, orders)
      router.py      # APIRouter / Blueprint: validazione via schemas, status code
      schemas.py     # Pydantic / dataclass di I/O
      service.py     # logica, nessun import del framework HTTP
      repository.py  # accesso dati
      models.py      # ORM, se presente
  tests/
    <dominio>/
      test_service.py  # unit con repository finto
      test_router.py   # integration con client HTTP di test
  ```
- **Naming**: package di dominio `snake_case` al plurale; moduli per ruolo senza ripetere il dominio (`users/service.py`, non `users/users_service.py`); funzioni di service come verbi (`create_user`).
- **Test**: `tests/` speculare ai domini, fuori dal package; unit sui service, integration via `TestClient` (FastAPI) o `app.test_client()` (Flask).
- **Quando NON usarlo**: CRUD sottile senza logica ⇒ `service.py` è solo inoltro, eliminarlo.

## Web app Django

- **Pattern consigliato**: convenzione Django (MTV): progetto + app per dominio; logica non banale in `services.py` dentro l'app.
- **Alternative**: Django REST Framework con la stessa struttura per API; app unica per progetti piccoli.
- **Albero**:
  ```
  config/            # settings.py, urls.py, wsgi.py/asgi.py
  <app>/
    models.py
    views.py
    urls.py
    services.py      # solo se la logica supera le view
    templates/<app>/
    tests/
  manage.py
  ```
- **Naming**: app al plurale e per dominio (`orders`), template namespaced `templates/<app>/`.
- **Test**: `tests/` dentro ogni app, `pytest-django` o `manage.py test`.
- **Quando NON usarlo**: API pura senza admin, ORM né template ⇒ "API HTTP".

---

**Combinazioni non coperte qui** (es. pipeline ETL/data, notebook, desktop GUI, worker a coda): dichiarare "nessun riferimento curato" e proporre alternative col brainstorming generico.
