# Changelog

Toutes les modifications notables sont documentees ici.
Format base sur [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).

## [1.0.0] - 2026-04-10

### Ajoute

- Skill `/veille` pour Claude Code : recap hebdomadaire de la veille tech francophone
- 2 sources par defaut : Journal du Hacker, Human Coders News
- Script Python `fetch_feeds.py` : fetch parallele, parse RSS 2.0 + Atom, zero dependance externe
- Deduplication automatique par URL avec fusion des sources
- Argument optionnel pour le nombre de jours (`/veille 3`, `/veille 14`)
- Installeur `install.sh` avec preservation du `sources.yml` utilisateur
- CI GitHub Actions (validation syntaxe Python)
