# veille-techno

Skill Claude Code qui agrege les flux RSS de sources tech francophones et produit un recap des articles recents.

## Architecture

```
skills/veille/
  SKILL.md           # Instructions pour Claude (invoque fetch_feeds.py)
  sources.yml        # Configuration des sources RSS (YAML simplifie)
  fetch_feeds.py     # Script Python : fetch parallele + parse XML + filtre date + dedup
```

## Comment ca marche

1. L'utilisateur tape `/veille [N]` (N = nombre de jours, defaut 7)
2. Claude lit SKILL.md et execute `python3 fetch_feeds.py N`
3. Le script lit sources.yml, fetch les flux en parallele, parse le XML, filtre par date, deduplique par URL
4. Sortie TSV : `DATE\tTITLE\tLINK\tCATEGORY\tDESCRIPTION\tSOURCE`
5. Claude formate le TSV en markdown (groupe par jour, sources en pied de page)

## Tester localement

```bash
# Tester le script directement
python3 skills/veille/fetch_feeds.py 7

# Installer et tester le skill
cp skills/veille/* ~/.claude/skills/veille/
# Puis /veille dans Claude Code
```

## Points importants

- Zero dependance Python externe (stdlib uniquement, pas de PyYAML)
- Le parser YAML dans fetch_feeds.py est minimaliste : il ne gere que le format specifique de sources.yml
- Les descriptions vides ou contenant juste "Comments" (JDH) sont filtrees
