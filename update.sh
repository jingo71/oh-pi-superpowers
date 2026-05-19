#!/usr/bin/env bash
set -euo pipefail

# ================================================
#    oh-pi-superpowers - Updater
# ================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

INSTALL_DIR="${HOME}/.pi"
SKILLS_DIR="${INSTALL_DIR}/agent/skills"
EXTENSIONS_DIR="${INSTALL_DIR}/agent/extensions"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILLS="${SCRIPT_DIR}/skills"
SOURCE_EXTENSIONS="${SCRIPT_DIR}/.pi/extensions"

echo -e "${BLUE}================================================${RESET}"
echo -e "${BLUE}   oh-pi-superpowers - Updater${RESET}"
echo -e "${BLUE}================================================${RESET}"
echo ""

echo -e "${YELLOW}Fetching latest from GitHub...${RESET}"

cd "${SCRIPT_DIR}"
if git rev-parse --git-dir > /dev/null 2>&1; then
    git pull origin main
else
    echo -e "  ${YELLOW}⚠${RESET} Not a git repo"
    echo -e "     Run setup.sh to install first"
fi

echo ""
echo -e "${YELLOW}Updating skills...${RESET}"
rm -rf "${SKILLS_DIR}/superpowers"
cp -r "${SOURCE_SKILLS}/" "${SKILLS_DIR}/superpowers/"
echo -e "  ${GREEN}✓${RESET} Skills updated"

echo ""
echo -e "${YELLOW}Updating extension...${RESET}"
rm -f "${EXTENSIONS_DIR}/superpowers-intro.ts"
cp -r "${SOURCE_EXTENSIONS}/" "${EXTENSIONS_DIR}/"
echo -e "  ${GREEN}✓${RESET} Extension updated"

echo ""
echo -e "${GREEN}================================================${RESET}"
echo -e "${GREEN}   SUCCESS! oh-pi-superpowers updated!${RESET}"
echo -e "${GREEN}================================================${RESET}"
echo ""
echo "Restart pi to use the latest version"
echo ""