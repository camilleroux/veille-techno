#!/usr/bin/env bash
set -euo pipefail

main() {
    SKILL_DIR="${HOME}/.claude/skills/veille"
    REPO_URL="https://github.com/CamilleRoux/veille-techno"
    REPO_TAG="${VEILLE_TAG:-v1.0.0}"

    echo "════════════════════════════════════════"
    echo "  /veille -- Veille Tech Francophone"
    echo "  Skill pour Claude Code"
    echo "════════════════════════════════════════"
    echo ""

    # Prerequis
    command -v git >/dev/null 2>&1 || { echo "Erreur : git est requis."; exit 1; }
    echo "* git detecte"

    # Creer le dossier skills si besoin
    mkdir -p "${HOME}/.claude/skills"

    # Telecharger dans un dossier temporaire
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf ${TEMP_DIR}" EXIT

    echo "* Telechargement (${REPO_TAG})..."
    git clone --depth 1 --branch "${REPO_TAG}" "${REPO_URL}" "${TEMP_DIR}/veille-techno" 2>/dev/null

    # Installer les fichiers du skill
    echo "* Installation des fichiers..."
    if [ -d "${SKILL_DIR}" ] && [ ! -L "${SKILL_DIR}" ]; then
        # Sauvegarde d'un sources.yml modifie par l'utilisateur
        if [ -f "${SKILL_DIR}/sources.yml" ]; then
            cp "${SKILL_DIR}/sources.yml" "${TEMP_DIR}/sources.yml.bak"
        fi
    fi

    mkdir -p "${SKILL_DIR}"
    cp -r "${TEMP_DIR}/veille-techno/skills/veille/"* "${SKILL_DIR}/"

    # Restaurer le sources.yml de l'utilisateur s'il existait
    if [ -f "${TEMP_DIR}/sources.yml.bak" ]; then
        cp "${TEMP_DIR}/sources.yml.bak" "${SKILL_DIR}/sources.yml"
        echo "* sources.yml existant conserve"
    fi

    echo ""
    echo "Skill /veille installe avec succes !"
    echo ""
    echo "Utilisation :"
    echo "  1. Lancez Claude Code : claude"
    echo "  2. Tapez :              /veille"
    echo "  3. Ou pour 3 jours :    /veille 3"
    echo ""
    echo "Configuration des sources : ${SKILL_DIR}/sources.yml"
    echo "Pour desinstaller : curl -fsSL ${REPO_URL}/raw/main/uninstall.sh | bash"
}

main "$@"
