# /veille -- Veille tech francophone pour Claude Code

[![GitHub stars](https://img.shields.io/github/stars/CamilleRoux/veille-techno)](https://github.com/CamilleRoux/veille-techno/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai/claude-code)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-3776AB.svg)](https://www.python.org)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](CHANGELOG.md)
[![Langue](https://img.shields.io/badge/langue-fran%C3%A7ais-blue.svg)](#)

Skill [Claude Code](https://claude.ai/claude-code) qui agrège les flux RSS de sources tech francophones et produit un récap des articles récents, trié par jour.

![Démonstration de /veille](demo.gif)

## Table des matières

- [Fonctionnalités](#fonctionnalités)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Sources](#sources-incluses)
- [Ajouter une source](#ajouter-une-source)
- [Architecture](#architecture)
- [Désinstallation](#désinstallation)
- [Contribuer](#contribuer)

## Fonctionnalités

- Agrégation de flux **RSS 2.0 et Atom** de sources tech francophones
- Récap trié par **jour** avec dédoublonnage automatique des articles
- Exécution ultra-rapide : **~1 seconde** (Python natif, zéro dépendance externe)
- Récupération des flux en **parallèle** (multi-thread)
- Sources **configurables** via un simple fichier YAML
- Fonctionne sur **macOS et Linux**

## Installation

### Option A : Claude Code Plugin (recommandé)

Depuis Claude Code, ajoutez le marketplace puis installez le plugin :

```
/plugin marketplace add CamilleRoux/veille-techno
/plugin install veille-techno@CamilleRoux-veille-techno
```

Le skill sera disponible dans tous vos projets.

### Option B : Installation manuelle (macOS / Linux)

```bash
git clone --depth 1 https://github.com/CamilleRoux/veille-techno.git
bash veille-techno/install.sh
```

<details>
<summary>One-liner (curl)</summary>

```bash
curl -fsSL https://raw.githubusercontent.com/CamilleRoux/veille-techno/main/install.sh | bash
```

Préférer la méthode git clone pour pouvoir inspecter le script avant exécution.

</details>

## Utilisation

Dans Claude Code :

```
/veille          # Récap des 7 derniers jours (par défaut)
/veille 3        # Récap des 3 derniers jours
/veille 14       # Récap des 14 derniers jours
```

### Exemple de sortie

```
# Veille Tech -- du 3 au 10 avril 2026
> 38 articles de 2 sources sur les 7 derniers jours

## Vendredi 10 avril 2026

- **MegaLinter : linting multi-langages en une commande** -- `dev` -- *Human Coders News*
  Installez MegaLinter v9 pour analyser 100+ langages...
- **Actualité Cyber de la semaine** -- `sécurité` -- *Journal du Hacker*
  Zero-day FortiClient EMS, 350 Go volés...

## Jeudi 9 avril 2026
- ...

---

### Sources
- Journal du Hacker -- Agrégateur communautaire de news tech francophones
- Human Coders News -- Actualités dev collaboratives par et pour les développeurs
```

## Sources incluses

| Source | Description |
|--------|-------------|
| [Journal du Hacker](https://www.journalduhacker.net) | Agrégateur communautaire de news tech francophones |
| [Human Coders News](https://news.humancoders.com) | Actualités dev collaboratives par et pour les développeurs |
| [Dépêches LinuxFr.org](https://linuxfr.org) | Actualités du Libre et Open Source |

## Ajouter une source

Éditez `~/.claude/skills/veille/sources.yml` et ajoutez un bloc :

```yaml
  - name: Ma Source
    url: https://example.com/feed.rss
    site: https://example.com
    description: Description courte de la source
```

Tout flux RSS ou Atom valide est supporté. Voir [CONTRIBUTING.md](CONTRIBUTING.md) pour proposer une source par défaut.

## Architecture

```
veille-techno/
├── skills/veille/
│   ├── SKILL.md           # Définition du skill (instructions pour Claude)
│   ├── sources.yml        # Liste configurable des flux RSS
│   └── fetch_feeds.py     # Script Python (fetch parallèle + parse XML)
├── .claude-plugin/
│   └── plugin.json        # Manifest pour le marketplace Claude Code
├── .github/
│   ├── workflows/ci.yml   # Validation syntaxe Python
│   └── ISSUE_TEMPLATE/    # Templates bug report / feature request
├── install.sh             # Installeur (copie vers ~/.claude/skills/)
├── uninstall.sh           # Désinstalleur
├── CHANGELOG.md           # Historique des versions
├── CONTRIBUTING.md         # Guide de contribution
├── CLAUDE.md              # Instructions projet pour Claude Code
├── LICENSE                # MIT
└── README.md
```

**Comment ça marche :** quand vous tapez `/veille`, Claude Code lit `SKILL.md` qui lui indique d'exécuter `fetch_feeds.py`. Ce script Python récupère les flux RSS en parallèle, parse le XML, filtre par date, dédoublonne par URL, et renvoie les articles au format TSV. Claude formate ensuite le résultat en markdown.

## Désinstallation

```bash
rm -rf ~/.claude/skills/veille
```

Ou via le script :

```bash
curl -fsSL https://raw.githubusercontent.com/CamilleRoux/veille-techno/main/uninstall.sh | bash
```

## Contribuer

Les contributions sont les bienvenues ! Voir [CONTRIBUTING.md](CONTRIBUTING.md) pour les détails.

En bref : pour ajouter une source, ouvrez une PR modifiant `skills/veille/sources.yml`.

## English version

Looking for an English-language version? Check out [/digest](https://github.com/CamilleRoux/tech-digest) — the same skill aggregating Hacker News, Lobste.rs and more.

## Auteur

Créé par [Camille Roux](https://www.camilleroux.com) -- développeur, entrepreneur et passionné de veille tech.

## Licence

[MIT](LICENSE)
