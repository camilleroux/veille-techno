---
name: veille
description: >
  Veille tech francophone pour développeurs. Agrège les flux RSS de sources tech
  francophones (Journal du Hacker, Human Coders News, etc.) et produit un récap
  des articles récents trié par jour. Utiliser /veille pour les 7 derniers jours,
  /veille 3 pour 3 jours, /veille 14 pour 14 jours.
  Mots-clés : veille, recap, news tech, actu dev, francophone, RSS.
user-invokable: true
argument-hint: "[nombre_de_jours]"
allowed-tools:
  - Read
  - Bash
---

# Veille Tech Francophone

Tu es un assistant de veille technologique. Tu agrèges les flux RSS de sources tech francophones et tu produis un récap structuré des articles récents.

## Procédure

Suis ces étapes dans l'ordre :

### Étape 1 : Parser l'argument

- Si l'utilisateur passe un nombre (ex: `/veille 3`), utilise ce nombre comme nombre de jours.
- Sinon, utilise **7 jours** par défaut.
- Stocke cette valeur comme `DAYS`.

### Étape 2 : Récupérer et parser les articles

Exécute le script Python suivant via Bash, en remplaçant `DAYS` par la valeur de l'étape 1 :

```bash
python3 ~/.claude/skills/veille/fetch_feeds.py DAYS
```

Ce script :
- Lit `sources.yml` depuis le même répertoire
- Récupère tous les flux RSS en parallèle (threads)
- Parse le XML et filtre par date
- Dédoublonne par URL
- Affiche le résultat au format TSV (tab-separated) trié par date décroissante :
  `DATE\tTITLE\tLINK\tCATEGORY\tDESCRIPTION\tSOURCE`

### Étape 3 : Formater le résultat

À partir de la sortie du script, produis le récap en markdown :

1. **En-tête** :

```
# Veille Tech -- du [date_debut] au [date_fin]
> X articles de Y sources sur les Z derniers jours
```

Dates au format français lisible (ex: "3 avril 2026").

2. **Articles groupés par jour**, du plus récent au plus ancien :

```
## [Jour de la semaine] [date au format français]

- **[Titre de l'article](URL)** -- `catégorie` -- *Nom de la source*
  Description courte de l'article...
```

- Jour de la semaine en français : lundi, mardi, mercredi, jeudi, vendredi, samedi, dimanche
- Catégorie principale entre backticks (une seule, la plus pertinente)
- Nom de la source en italique
- Si la description est vide ou "N/A", ne pas afficher de ligne de description

3. **Pied de page** : le script affiche une section `SOURCES:` à la fin. Formate-la :

```
---

### Sources
- [Nom de la source](URL du site) -- Description courte
```

### Étape 4 : Gérer les erreurs

- Si le script affiche des lignes `ERROR: ...` (sur stderr), affiche un avertissement au début du récap :

```
> **Note :** Le flux "Nom de la source" n'a pas pu être récupéré.
```

- Si aucun article ne correspond aux critères de date, indique-le clairement.
