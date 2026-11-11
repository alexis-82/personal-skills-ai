<div align="center">

# Feature-Driven Workflow for pi

**Ten guided steps that help the pi assistant take a new feature from idea to publication, without going off track.**<br>
*Dieci passi guidati che aiutano l'assistente pi a portare una nuova funzione dall'idea alla pubblicazione, senza uscire dai binari.*

[![Version](https://img.shields.io/badge/version-3.1.0-blue?style=plastic)](CHANGELOG.md)&nbsp;&nbsp;&nbsp;[![Markdown](https://img.shields.io/badge/Markdown-000000?style=plastic&logo=markdown&logoColor=white)](#)&nbsp;&nbsp;&nbsp;[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey?style=plastic)](#)

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

Feature-Driven Workflow is a set of skills for [pi](https://pi.dev), an AI coding assistant. It splits the work on a new feature into ten clear steps: first you decide together what to build and what to leave out, then pi plans, writes, tests, reviews and saves the work, asking for your confirmation at the important moments.

What you get:

- **Clear boundaries**: at the start you write down what the feature must do and, just as important, what it must not do. pi keeps to that list for the whole job.
- **Choices made together**: before writing anything, pi shows you the alternatives with their pros and cons and lets you decide.
- **A tidy project from day one**: on a new project pi proposes a folder structure suited to the language you use.
- **No surprises**: pi changes only what you asked for. If it notices other problems, it tells you instead of fixing them on its own.
- **Ready-made notes**: at the end, pi updates the list of changes and the project description for you.

It works with any kind of software: scripts, websites, apps, command-line tools and more.

<a id="installation"></a>
## 🚀 Installation

You need pi version 1.0.3 or later, which in turn needs Node.js newer than 22.14. It works on Windows, Linux and macOS.

Open a terminal and paste this command:

```bash
pi install git:github.com/alexis-82/personal-skills-ai@pi-testing
```

If pi is already open, type `/reload` to load the skills. To update later, run the same command again.

<a id="how-to-use"></a>
## 🧭 How to use

In pi, type the command of the step you want, or simply ask in your own words (for example "write the spec" or "commit"): pi usually picks the right step by itself.

| Step | Command | What happens |
|---|---|---|
| 1 | `/skill:01-spec` | You describe the idea; pi writes what the feature must and must not do |
| 2 | `/skill:02-clarify` | pi shows the options and asks you to choose |
| 3 | `/skill:03-plan-tasks` | pi splits the work into small tasks |
| 4 | `/skill:04-analyze` | *Optional* — pi looks for risks in the plan |
| 5 | `/skill:05-implement` | pi writes the code, one task at a time |
| 6 | `/skill:06-test` | pi checks that everything works as agreed |
| 7 | `/skill:07-review` | *Optional* — pi reviews the code looking for problems |
| 8 | `/skill:08-refactor` | *Optional* — pi tidies up the new code without changing what it does |
| 9 | `/skill:09-commit` | pi saves the work and updates the change list and description |
| 10 | `/skill:10-push` | *Optional* — pi publishes the work online after your confirmation |

At any time you can say **"watch the scope"** or type `/skill:guardrail-scope` to remind pi to change only what you asked for.

<a id="troubleshooting"></a>
## 🛟 Troubleshooting

- **pi doesn't pick the right step on its own**: type the step command directly, for example `/skill:01-spec`.
- **The commands don't appear after installing**: type `/reload` in pi, or restart it.
- **You want to use Claude with a Claude Pro or Max subscription**: pi needs an extra add-on. Paste `pi install npm:pi-claude-pro`, and keep only one add-on of this kind installed. It is made by a third party: check it before installing.

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

Feature-Driven Workflow è un insieme di skill per [pi](https://pi.dev), un assistente alla programmazione basato sull'AI. Divide il lavoro su una nuova funzione in dieci passi chiari: prima decidete insieme cosa costruire e cosa lasciare fuori, poi pi pianifica, scrive, prova, revisiona e salva il lavoro, chiedendo la tua conferma nei momenti importanti.

Cosa ottieni:

- **Confini chiari**: all'inizio scrivi cosa la funzione deve fare e, altrettanto importante, cosa non deve fare. pi rispetta quell'elenco per tutto il lavoro.
- **Scelte fatte insieme**: prima di scrivere qualsiasi cosa, pi ti mostra le alternative con pro e contro e ti lascia decidere.
- **Un progetto ordinato dal primo giorno**: su un progetto nuovo pi propone una struttura di cartelle adatta al linguaggio che usi.
- **Nessuna sorpresa**: pi modifica solo quello che hai chiesto. Se nota altri problemi te li segnala, invece di sistemarli di testa sua.
- **Note già pronte**: alla fine pi aggiorna per te l'elenco delle modifiche e la descrizione del progetto.

Funziona con qualunque tipo di software: script, siti web, app, programmi da riga di comando e altro.

<a id="installazione"></a>
## 🚀 Installazione

Ti serve pi versione 1.0.3 o successiva, che a sua volta richiede Node.js più recente della 22.14. Funziona su Windows, Linux e macOS.

Apri un terminale e incolla questo comando:

```bash
pi install git:github.com/alexis-82/personal-skills-ai@pi-testing
```

Se pi è già aperto, scrivi `/reload` per caricare le skill. Per aggiornare in futuro, ripeti lo stesso comando.

<a id="come-si-usa"></a>
## 🧭 Come si usa

In pi scrivi il comando del passo che ti serve, oppure chiedi semplicemente a parole tue (per esempio "scrivi la spec" o "committa"): di solito pi sceglie da solo il passo giusto.

| Passo | Comando | Cosa succede |
|---|---|---|
| 1 | `/skill:01-spec` | Descrivi l'idea; pi scrive cosa la funzione deve e non deve fare |
| 2 | `/skill:02-clarify` | pi ti mostra le opzioni e ti chiede di scegliere |
| 3 | `/skill:03-plan-tasks` | pi divide il lavoro in piccoli compiti |
| 4 | `/skill:04-analyze` | *Facoltativo* — pi cerca i rischi nel piano |
| 5 | `/skill:05-implement` | pi scrive il codice, un compito alla volta |
| 6 | `/skill:06-test` | pi verifica che tutto funzioni come concordato |
| 7 | `/skill:07-review` | *Facoltativo* — pi rilegge il codice in cerca di problemi |
| 8 | `/skill:08-refactor` | *Facoltativo* — pi riordina il codice nuovo senza cambiare cosa fa |
| 9 | `/skill:09-commit` | pi salva il lavoro e aggiorna elenco delle modifiche e descrizione |
| 10 | `/skill:10-push` | *Facoltativo* — pi pubblica il lavoro online dopo la tua conferma |

In qualunque momento puoi dire **"attenzione allo scope"** o scrivere `/skill:guardrail-scope` per ricordare a pi di modificare solo quello che hai chiesto.

<a id="problemi-comuni"></a>
## 🛟 Problemi comuni

- **pi non sceglie da solo il passo giusto**: scrivi direttamente il comando del passo, per esempio `/skill:01-spec`.
- **I comandi non compaiono dopo l'installazione**: scrivi `/reload` in pi, oppure riavvialo.
- **Vuoi usare Claude con un abbonamento Claude Pro o Max**: pi ha bisogno di un componente aggiuntivo. Incolla `pi install npm:pi-claude-pro` e tieni installato un solo componente di questo tipo. È fatto da terzi: controllalo prima di installarlo.
