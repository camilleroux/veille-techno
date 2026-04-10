#!/usr/bin/env bash
set -euo pipefail

SKILL_DIR="${HOME}/.claude/skills/veille"

echo "Desinstallation de /veille..."

if [ -d "${SKILL_DIR}" ] || [ -L "${SKILL_DIR}" ]; then
    rm -rf "${SKILL_DIR}"
    echo "Skill /veille desinstalle."
else
    echo "Rien a desinstaller : ${SKILL_DIR} n'existe pas."
fi
