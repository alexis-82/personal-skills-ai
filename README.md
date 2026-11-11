<div align="center">

# Feature-Driven Workflow

**Ten guided steps that help Claude Code take a new feature from idea to publication, without going off track.**<br>
*Dieci passi guidati che aiutano Claude Code a portare una nuova funzione dall'idea alla pubblicazione, senza uscire dai binari.*

[![Version](https://img.shields.io/badge/version-2.3.0-blue?style=plastic)](CHANGELOG.md)&nbsp;&nbsp;&nbsp;[![Markdown](https://img.shields.io/badge/Markdown-000000?style=plastic&logo=markdown&logoColor=white)](#)&nbsp;&nbsp;&nbsp;[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey?style=plastic)](#)

🇬🇧 [English](#en)&nbsp;&nbsp;·&nbsp;&nbsp;🇮🇹 [Italiano](#it)

</div>

---

<a id="en"></a>
<a id="contents"></a>
## 📑 Contents

- [✨ What it is](#what-it-is)
- [🚀 Installation](#installation)
- [🧭 How to use](#how-to-use)
- [🛟 Troubleshooting](#troubleshooting)

---

<a id="what-it-is"></a>
## ✨ What it is

Feature-Driven Workflow is a set of skills for Claude Code, Anthropic's coding assistant. It splits the work on a new feature into ten clear steps: first you decide together what to build and what to leave out, then Claude plans, writes, tests, reviews and saves the work, asking for your confirmation at the important moments.

What you get:

- **Clear boundaries**: at the start you write down what the feature must do and, just as important, what it must not do. Claude keeps to that list for the whole job.
- **Choices made together**: before writing anything, Claude shows you the alternatives with their pros and cons and lets you decide.
- **A tidy project from day one**: on a new project Claude proposes a folder structure suited to the language you use.
- **No surprises**: Claude changes only what you asked for. If it notices other problems, it tells you instead of fixing them on its own.
- **Ready-made notes**: at the end, Claude updates the list of changes and the project description for you.

It works with any kind of software: scripts, websites, apps, command-line tools and more.

<a id="installation"></a>
## 🚀 Installation

You need Claude Code installed on your computer (Windows, Linux or macOS).

1. Download this project: on the GitHub page click **Code → Download ZIP** and unzip it, or copy it with Git.
2. Open the unzipped folder in a terminal and run the installer for your system.

**Windows** — open PowerShell in the folder and paste:

```powershell
.\install.ps1
```

**Linux / macOS** — open the Terminal in the folder and paste:

```bash
./install.sh
```

3. Restart Claude Code. The skills are ready.

To update, download the new version and run the installer again: it replaces the old one.

<a id="how-to-use"></a>
## 🧭 How to use

In Claude Code, type the command of the step you want, or simply ask in your own words (for example "write the spec" or "commit"): Claude picks the right step by itself.

| Step | Command | What happens |
|---|---|---|
| 1 | `/01-spec` | You describe the idea; Claude writes what the feature must and must not do |
| 2 | `/02-clarify` | Claude shows the options and asks you to choose |
| 3 | `/03-plan-tasks` | Claude splits the work into small tasks |
| 4 | `/04-analyze` | *Optional* — Claude looks for risks in the plan |
| 5 | `/05-implement` | Claude writes the code, one task at a time |
| 6 | `/06-test` | Claude checks that everything works as agreed |
| 7 | `/07-review` | *Optional* — Claude reviews the code looking for problems |
| 8 | `/08-refactor` | *Optional* — Claude tidies up the new code without changing what it does |
| 9 | `/09-commit` | Claude saves the work and updates the change list and description |
| 10 | `/10-push` | *Optional* — Claude publishes the work online after your confirmation |

At any time you can say **"watch the scope"** to remind Claude to change only what you asked for.

<a id="troubleshooting"></a>
## 🛟 Troubleshooting

- **Windows blocks the installer with an "execution policy" error**: in the same PowerShell window paste `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`, then run `.\install.ps1` again. The change lasts only until you close the window.
- **Linux or macOS says "permission denied"**: paste `chmod +x install.sh` once, then run `./install.sh` again.
- **The commands don't appear in Claude Code**: restart Claude Code after installing.

---

<a id="it"></a>
<a id="indice"></a>
## 📑 Indice

- [✨ Cos'è](#cose)
- [🚀 Installazione](#installazione)
- [🧭 Come si usa](#come-si-usa)
- [🛟 Problemi comuni](#problemi-comuni)

---

<a id="cose"></a>
## ✨ Cos'è

Feature-Driven Workflow è un insieme di skill per Claude Code, l'assistente alla programmazione di Anthropic. Divide il lavoro su una nuova funzione in dieci passi chiari: prima decidete insieme cosa costruire e cosa lasciare fuori, poi Claude pianifica, scrive, prova, revisiona e salva il lavoro, chiedendo la tua conferma nei momenti importanti.

Cosa ottieni:

- **Confini chiari**: all'inizio scrivi cosa la funzione deve fare e, altrettanto importante, cosa non deve fare. Claude rispetta quell'elenco per tutto il lavoro.
- **Scelte fatte insieme**: prima di scrivere qualsiasi cosa, Claude ti mostra le alternative con pro e contro e ti lascia decidere.
- **Un progetto ordinato dal primo giorno**: su un progetto nuovo Claude propone una struttura di cartelle adatta al linguaggio che usi.
- **Nessuna sorpresa**: Claude modifica solo quello che hai chiesto. Se nota altri problemi te li segnala, invece di sistemarli di testa sua.
- **Note già pronte**: alla fine Claude aggiorna per te l'elenco delle modifiche e la descrizione del progetto.

Funziona con qualunque tipo di software: script, siti web, app, programmi da riga di comando e altro.

<a id="installazione"></a>
## 🚀 Installazione

Ti serve Claude Code installato sul computer (Windows, Linux o macOS).

1. Scarica questo progetto: nella pagina GitHub clicca **Code → Download ZIP** ed estrailo, oppure copialo con Git.
2. Apri la cartella estratta in un terminale e avvia l'installazione per il tuo sistema.

**Windows** — apri PowerShell nella cartella e incolla:

```powershell
.\install.ps1
```

**Linux / macOS** — apri il Terminale nella cartella e incolla:

```bash
./install.sh
```

3. Riavvia Claude Code. Le skill sono pronte.

Per aggiornare, scarica la nuova versione e avvia di nuovo l'installazione: sostituisce quella vecchia.

<a id="come-si-usa"></a>
## 🧭 Come si usa

In Claude Code scrivi il comando del passo che ti serve, oppure chiedi semplicemente a parole tue (per esempio "scrivi la spec" o "committa"): Claude sceglie da solo il passo giusto.

| Passo | Comando | Cosa succede |
|---|---|---|
| 1 | `/01-spec` | Descrivi l'idea; Claude scrive cosa la funzione deve e non deve fare |
| 2 | `/02-clarify` | Claude ti mostra le opzioni e ti chiede di scegliere |
| 3 | `/03-plan-tasks` | Claude divide il lavoro in piccoli compiti |
| 4 | `/04-analyze` | *Facoltativo* — Claude cerca i rischi nel piano |
| 5 | `/05-implement` | Claude scrive il codice, un compito alla volta |
| 6 | `/06-test` | Claude verifica che tutto funzioni come concordato |
| 7 | `/07-review` | *Facoltativo* — Claude rilegge il codice in cerca di problemi |
| 8 | `/08-refactor` | *Facoltativo* — Claude riordina il codice nuovo senza cambiare cosa fa |
| 9 | `/09-commit` | Claude salva il lavoro e aggiorna elenco delle modifiche e descrizione |
| 10 | `/10-push` | *Facoltativo* — Claude pubblica il lavoro online dopo la tua conferma |

In qualunque momento puoi dire **"attenzione allo scope"** per ricordare a Claude di modificare solo quello che hai chiesto.

<a id="problemi-comuni"></a>
## 🛟 Problemi comuni

- **Windows blocca l'installazione con un errore di "execution policy"**: nella stessa finestra di PowerShell incolla `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`, poi avvia di nuovo `.\install.ps1`. La modifica dura solo finché non chiudi la finestra.
- **Linux o macOS risponde "permission denied"**: incolla una volta `chmod +x install.sh`, poi avvia di nuovo `./install.sh`.
- **I comandi non compaiono in Claude Code**: riavvia Claude Code dopo l'installazione.
