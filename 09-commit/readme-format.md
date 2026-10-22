# Formato README

Modello grafico del `README.md` generato da `09-commit`. Riguarda solo la **forma**: il contenuto lo decide `SKILL.md` secondo il profilo.

## Modello

```markdown
<div align="center">

# <Nome progetto>

**<tagline di una riga>**

[![Version](https://img.shields.io/badge/version-X.Y.Z-blue?style=plastic)](CHANGELOG.md)&nbsp;&nbsp;&nbsp;[![Python](https://img.shields.io/badge/Python-3776AB?style=plastic&logo=python&logoColor=white)](#)

</div>

---

<a id="indice"></a>
## 📑 Indice

- [✨ Cos'è](#cose)
- [🚀 Installazione](#installazione)

---

<a id="cose"></a>
## ✨ Cos'è

...

<a id="installazione"></a>
## 🚀 Installazione

...
```

## Regole

- **Intestazione centrata**: titolo, tagline di una riga (proposta all'utente insieme al resto) e badge. Le righe vuote dentro `<div>` servono: senza, GitHub non interpreta il Markdown. Niente logo, link rapidi o footer.
- **Badge** [shields.io](https://shields.io/), `style=plastic`, **tutti su una riga** separati da `&nbsp;&nbsp;&nbsp;`:
  - **versione** dall'ultima voce del `CHANGELOG.md` (altrimenti manifest o tag);
  - **tecnologie** con cui è sviluppato il progetto (linguaggio, framework, runtime), dedotte da manifest e file tracciati, con `logo=` di simple-icons;
  - licenza, piattaforma, ultimo commit **solo se il dato esiste**. Per il badge GitHub usare solo `owner/repo`, mai l'URL del remote (può contenere un token).
  - Nell'URL `badge/<etichetta>-<testo>-<colore>` il trattino va raddoppiato (`1.0.0-rc.1` → `1.0.0--rc.1`), gli spazi diventano `%20`, `#` diventa `%23`.
- **Indice** sempre presente dopo l'intestazione, con le sole sezioni `##`.
- **Titoli `##`** con emoji iniziale e ancora `<a id="slug"></a>` sulla riga sopra (slug: minuscolo, senza emoji, accenti e punteggiatura, spazi → `-`). I `##` dentro blocchi di codice non sono titoli.
- L'eventuale testo introduttivo prima del primo `##` va nella sezione `✨ Cos'è`, non si elimina.
- Ammessi dove servono: callout `> [!TIP]` / `> [!NOTE]` e `<details>` per FAQ.
