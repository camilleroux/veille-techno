# Contribuer a veille-techno

Merci de votre interet pour ce projet ! Voici comment contribuer.

## Ajouter une source RSS

C'est la contribution la plus courante. La source doit :

- Etre **francophone** (ou proposer du contenu en francais)
- Avoir un flux **RSS 2.0 ou Atom** valide
- Etre pertinente pour les **developpeurs**

### Etapes

1. Forkez le repo
2. Editez `skills/veille/sources.yml` et ajoutez votre source :
   ```yaml
     - name: Nom de la source
       url: https://example.com/feed.rss
       site: https://example.com
       description: Description courte
   ```
3. Testez localement : `python3 skills/veille/fetch_feeds.py 7`
4. Ouvrez une Pull Request

## Modifier le skill

### Setup local

```bash
git clone https://github.com/CamilleRoux/veille-techno.git
cd veille-techno

# Installer le skill localement
cp skills/veille/* ~/.claude/skills/veille/

# Tester le script Python
python3 skills/veille/fetch_feeds.py 7
```

### Standards

- **Python** : compatible 3.10+, pas de dependance externe (stdlib uniquement)
- **Bash** : `set -euo pipefail` en en-tete
- **Skill** : tester avec `/veille` dans Claude Code apres modification

## Signaler un bug

Ouvrez une [issue](https://github.com/CamilleRoux/veille-techno/issues/new?template=bug_report.yml) en precisant :

- Votre OS et version de Python
- La commande executee
- Le message d'erreur

## Proposer une fonctionnalite

Ouvrez une [issue](https://github.com/CamilleRoux/veille-techno/issues/new?template=feature_request.yml) en decrivant votre idee.
