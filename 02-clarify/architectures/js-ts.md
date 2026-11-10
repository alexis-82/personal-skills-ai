# Architetture idiomatiche — JavaScript / TypeScript

Riferimento per la sezione "Architettura (solo greenfield)" di `02-clarify/SKILL.md`.
Voci ordinate dalla più semplice alla più strutturata. TypeScript è il default consigliato per tutto ciò che supera un singolo file.

---

## CLI tool (Node)

- **Pattern consigliato**: entrypoint sottile + comandi separati + logica pura senza I/O di terminale.
- **Alternative**: file singolo con `node:util` `parseArgs` per 1-2 comandi; `commander`/`yargs` se i sottocomandi sono molti.
- **Albero**:
  ```
  src/
    cli.ts           # parsing argomenti, dispatch
    commands/        # un file per sottocomando
    core/            # logica testabile
  bin/<nome>         # shim eseguibile → dist/cli.js
  test/
  ```
- **Naming**: file `kebab-case.ts`; comando esposto con `"bin"` in `package.json`.
- **Test**: `test/` con `node:test` o vitest, sui moduli di `core/`.
- **Quando NON usarlo**: script usa-e-getta ⇒ un solo file `.ts`/`.mjs`.

## Libreria / package npm

- **Pattern consigliato**: `src/index.ts` come unica API pubblica; moduli interni non riesportati.
- **Alternative**: più entrypoint con `"exports"` in `package.json` quando le aree sono indipendenti.
- **Albero**:
  ```
  src/
    index.ts         # API pubblica
    internal/
  test/
  ```
- **Naming**: file `kebab-case.ts`; export nominati, niente default export.
- **Test**: `test/` contro l'API pubblica, non contro `internal/`.
- **Quando NON usarlo**: codice usato da un solo progetto ⇒ modulo dentro quel progetto.

## API HTTP Node (Express / Fastify)

- **Pattern consigliato**: layered leggero `routes → services → repositories`; validazione input al bordo (zod/JSON schema).
- **Alternative**: package-by-feature (`src/modules/users/{routes,service,repo}.ts`) oltre 3-4 domini; file singolo per microservizi con < 5 endpoint.
- **Albero (layered)**:
  ```
  src/
    app.ts           # crea app, registra route e middleware
    server.ts        # avvio (listen), separato per i test
    routes/
    services/        # logica, nessun import del framework HTTP
    repositories/
    schemas/         # validazione I/O
    config.ts
  test/
    unit/
    integration/     # supertest / fastify.inject
  ```
- **Naming**: file `kebab-case.ts`, layer al plurale (`routes/users.ts`).
- **Test**: unit sui service con repository finti; integration con `supertest` (Express) o `app.inject` (Fastify).
- **Quando NON usarlo**: proxy o BFF senza logica ⇒ eliminare `services/`.

## API HTTP NestJS

- **Pattern consigliato**: convenzione Nest: un modulo per dominio con controller, service, DTO.
- **Alternative**: Express/Fastify layered se DI e decoratori non servono.
- **Albero**:
  ```
  src/
    main.ts
    app.module.ts
    <dominio>/
      <dominio>.module.ts
      <dominio>.controller.ts
      <dominio>.service.ts
      dto/
  test/              # e2e
  ```
- **Naming**: suffissi Nest (`.controller.ts`, `.service.ts`, `.module.ts`); unit test `*.spec.ts` accanto al file.
- **Test**: `*.spec.ts` colocati per gli unit; `test/` per e2e.
- **Quando NON usarlo**: servizio con 2-3 endpoint ⇒ il boilerplate Nest non si ripaga.

## Frontend SPA (React / Vue)

- **Pattern consigliato**: component-based, organizzazione per feature; stato e chiamate API fuori dai componenti di presentazione. **Non MVC.**
- **Alternative**: per tipo (`components/`, `hooks/`, `pages/`) sotto ~15 componenti; meta-framework (Next/Nuxt) se servono SSR o routing su file system ⇒ combinazione non coperta qui.
- **Albero (per feature)**:
  ```
  src/
    main.tsx         # main.ts per Vue
    app/             # root, router, provider
    features/
      <feature>/
        components/
        hooks/       # composables/ per Vue
        api.ts
    shared/          # componenti e util riusati da 2+ feature
  ```
- **Naming**: componenti `PascalCase.tsx` / `.vue`; hook `useXxx`; composable `useXxx`.
- **Test**: colocati (`Component.test.tsx`) con vitest + Testing Library; e2e separati se previsti.
- **Quando NON usarlo**: pagina statica o widget singolo ⇒ niente `features/`, un componente basta.

---

**Combinazioni non coperte qui** (es. Next.js/Nuxt, Electron, React Native, serverless, monorepo con più app): dichiarare "nessun riferimento curato" e proporre alternative col brainstorming generico.
