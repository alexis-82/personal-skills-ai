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

- **Pattern consigliato**: per business component (Node.js Best Practices 1.1): una cartella per dominio con route, controller, service, data access e interfacce; validazione input nel controller (zod/JSON schema).
- **Alternative**: layered `routes/ services/ repositories/` per 1-2 domini piccoli; file singolo per microservizi con < 5 endpoint.
- **Albero (per component)**:
  ```
  src/
    index.ts         # crea l'app, middleware globali, monta le route dei component; export default app
    bin/
      www/
        server.ts    # avvio (listen), separato da index.ts per i test
    config/          # configurazione: lettura env, config dei servizi esterni (<db>.config.ts)
    core/            # trasversale, nessun codice di un singolo dominio
      constants/     # HttpCode, messaggi
      db/            # pool/client del DB
      interfaces/    # contratti condivisi (IResponse, IErrorWithStatus)
      log/           # logger applicativo + logger HTTP
      middleware/    # auth, error handler
      types/         # dichiarazioni .d.ts (es. environment.d.ts)
      utils/         # helper condivisi (createError, createResponse)
    components/
      <nome>/                      # dominio al plurale (brands, tasks)
        <nome>.route.ts            # path + middleware → controller
        <nome>.controller.ts       # HTTP: validazione input, req/res, status code
        <nome>.service.ts          # logica, nessun import del framework HTTP
        <nome>.data.ts             # query / accesso dati
        I<Entità>.ts               # interfacce del dominio, entità al singolare (IBrand); una per file
        <nome>.controller.test.ts  # integration: supertest / fastify.inject
        <nome>.service.test.ts     # unit con .data.ts finto
  ```
- **Naming**: cartelle e file `kebab-case`, suffisso di ruolo (`.route.ts`, `.controller.ts`, `.service.ts`, `.data.ts`); interfacce `I<Entità>.ts` al singolare (alternativa idiomatica TS senza prefisso: `<nome>.types.ts`).
- **Import**: una sola convenzione per tutto il progetto — relativi, oppure subpath imports nativi di Node (`"imports": { "#core/*": "./dist/core/*" }` in `package.json` + `paths` in tsconfig). Mai misti.
- **Config**: una sola cartella `config/`; `core/` non ha una propria `config/` (evita due posti per la stessa cosa).
- **Test**: colocati nel component; service in unit con `.data.ts` finto, controller in integration con `supertest` (Express) o `app.inject` (Fastify).
- **Quando NON usarlo**: proxy o BFF senza logica ⇒ eliminare `.service.ts`.

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
    main.tsx         # main.ts per Vue; generato da Vite
    App.tsx          # root: router + provider; generato da Vite, resta qui
    assets/          # statici importati; generato da Vite
    pages/
      <pagina>/
        <pagina>.tsx # una pagina per rotta: compone le feature, nessuna logica propria
    features/
      <feature>/
        components/
        hooks/       # composables/ per Vue; solo se la feature ha stato/side effect
        api.ts       # solo se la feature chiama il backend
    components/
      ui/            # primitive UI riusate da 2+ feature (shadcn o proprie)
    lib/             # util senza UI (cn, client HTTP)
  ```
- **Naming**: file `kebab-case.tsx` (coerente con shadcn), componenti esportati `PascalCase`; hook `useXxx`; composable `useXxx`.
- **Test**: colocati (`<componente>.test.tsx`) con vitest + Testing Library; e2e separati se previsti.
- **Quando NON usarlo**: pagina statica o widget singolo ⇒ niente `features/`, un componente basta.

---

**Combinazioni non coperte qui** (es. Next.js/Nuxt, Electron, React Native, serverless, monorepo con più app): dichiarare "nessun riferimento curato" e proporre alternative col brainstorming generico.
