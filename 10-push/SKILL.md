---
name: 10-push
description: Pubblicare sul remote i commit di una funzionalità già committata ed eventualmente aprire una pull request, dopo aver mostrato cosa verrà pubblicato e ottenuto conferma. Usare quando l'utente dice "pusha", "fai il push", "pubblica", "apri PR", "apri una pull request", tipicamente dopo il commit. Decima fase del workflow feature-driven, opzionale.
---

# Push e pull request

Fase 10/10 del workflow. Porta su GitHub (o su un altro remote) il lavoro consolidato in `09-commit`. Opzionale: i progetti senza remote chiudono il ciclo con il commit.

Questa fase **non** scrive file di lavoro: legge solo lo stato di git.

## Cosa fare

1. Leggere `plan.md`, `spec.md`, `tasks.md` di questa cartella per il metodo.
2. **Stato locale.** Eseguire `git status`.
   - Modifiche a file tracciati non committate → **fermarsi** e rimandare a `/09-commit`.
   - File non tracciati (non ignorati) → elencarli e chiedere se vanno committati prima del push. Non bloccare: possono essere file locali voluti.
3. **Branch e remote.** Branch corrente (`git branch --show-current`), remote (`git remote -v`), upstream (`git rev-parse --abbrev-ref @{u}`).
   - Nessun remote → **fermarsi**: non c'è niente da pubblicare, il ciclo finisce con `09-commit`.
   - HEAD staccato (nessun branch) → **fermarsi** e segnalarlo.
4. **Confronto con il remote.** Eseguire `git fetch <remote>`, poi contare i commit avanti/indietro:
   - con upstream: `git rev-list --left-right --count @{u}...HEAD`;
   - senza upstream ma con `<remote>/<branch>` esistente: stesso conteggio su `<remote>/<branch>...HEAD`;
   - senza upstream e senza branch remoto: branch nuovo, tutti i commit sono in uscita.

   Esito:
   - **indietro > 0** (il remote ha commit che il locale non ha) → **fermarsi**, mostrare i commit remoti mancanti e proporre all'utente `git pull --rebase`. Non eseguirlo di propria iniziativa.
   - **avanti = 0** → niente da pubblicare, dirlo e terminare.
5. **Mostrare cosa verrà pubblicato** e attendere conferma: remote (URL), branch di destinazione, elenco dei commit in uscita (`git log --oneline <base>..HEAD`).
6. **Push**, solo dopo conferma:
   - con upstream: `git push`;
   - senza upstream: `git push -u <remote> <branch>`.
   - Push rifiutato (es. il remote è avanzato nel frattempo, hook pre-push fallito) → **fermarsi** e riportare l'errore. Per un hook fallito, correggere la causa, non aggirarlo.
7. **Pull request**, solo se richiesta dall'utente:
   - Non aprirla se il branch corrente è quello di default del repo (`gh repo view --json defaultBranchRef`).
   - Mostrare titolo e corpo e attendere conferma.
   - Titolo conciso; corpo con **Summary** (bullet) e **Test plan**, secondo il template `spec.md` di questa cartella.
   - Passare il corpo **sempre da file**: scriverlo in un file temporaneo e usare `gh pr create --title "<titolo>" --body-file <file>`. Mai `--body "…"` con testo libero: in Bash il testo tra backtick dentro le virgolette doppie viene eseguito come comando.
8. **Riportare l'esito**: branch pubblicato, numero di commit, URL della PR se creata.

## Output atteso

Commit pubblicati sul remote (branch con upstream impostato) ed eventuale PR aperta, oppure dichiarazione esplicita in chat del motivo per cui la fase si è fermata (modifiche non committate, nessun remote, remote avanti, push rifiutato, niente da pubblicare).

## Regole

- **[GUARDRAIL SCOPE]** Pubblica **solo** il branch corrente e solo i commit già creati. Niente nuovi commit, rebase o modifiche ai file in questa fase. Vedi la skill `guardrail-scope`.
- Mai push senza conferma esplicita dell'utente per quel repo e quel branch.
- Mai `--force`, `--force-with-lease`, `--no-verify`, `--mirror`, `--all`, `--tags`.
- Mai creare tag git o GitHub Release, mai fare merge tra branch.
- Se il remote è avanti, la scelta tra rebase, merge o altro è dell'utente.
