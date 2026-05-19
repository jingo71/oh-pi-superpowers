#!/usr/bin/env bash
set -euo pipefail

# ================================================
#    oh-pi-superpowers - Installer
# ================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# 설치 디렉토리 설정
INSTALL_DIR="${HOME}/.pi"
SKILLS_DIR="${INSTALL_DIR}/agent/skills"
EXTENSIONS_DIR="${INSTALL_DIR}/agent/extensions"
SETTINGS_FILE="${INSTALL_DIR}/settings.json"

# 원본 경로 (이 스크립트의 위치)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILLS="${SCRIPT_DIR}/skills"
SOURCE_EXTENSIONS="${SCRIPT_DIR}/.pi/extensions"
SOURCE_SETTINGS="${SCRIPT_DIR}/.pi/settings.json"

echo -e "${BLUE}================================================${RESET}"
echo -e "${BLUE}   oh-pi-superpowers - Installer${RESET}"
echo -e "${BLUE}================================================${RESET}"
echo ""

echo "Installing Superpowers to ${INSTALL_DIR}"
echo ""

# 설치 디렉토리 생성
echo -e "${YELLOW}Creating directories...${RESET}"
mkdir -p "${SKILLS_DIR}"
mkdir -p "${EXTENSIONS_DIR}"
echo ""

# Skills 복사
echo -e "${YELLOW}Copying skills...${RESET}"
cp -r "${SOURCE_SKILLS}/" "${SKILLS_DIR}/superpowers/"
echo -e "  ${GREEN}✓${RESET} Skills copied to ${SKILLS_DIR}/superpowers/"
echo ""

# Extensions 복사
echo -e "${YELLOW}Copying extension...${RESET}"
cp -r "${SOURCE_EXTENSIONS}/" "${EXTENSIONS_DIR}/"
echo -e "  ${GREEN}✓${RESET} Extension copied to ${EXTENSIONS_DIR}/"
echo ""

# settings.json 업데이트
echo -e "${YELLOW}Updating settings.json...${RESET}"
if [[ -f "${SETTINGS_FILE}" ]]; then
    # 기존 settings.json 백업
    cp "${SETTINGS_FILE}" "${SETTINGS_FILE}.backup"
    echo -e "  ${GREEN}✓${RESET} Backed up existing settings to settings.json.backup"
    
    # jq로 JSON 병합
    if command -v jq &> /dev/null; then
        # 기존 skills 배열이 있는지 확인
        if jq -e '.skills' "${SETTINGS_FILE}" > /dev/null 2>&1; then
            # 기존 skills 배열에 추가 (중복 체크)
            EXISTING=$(jq -r '.skills[]' "${SETTINGS_FILE}" | grep -c "superpowers" || true)
            if [[ "$EXISTING" -eq 0 ]]; then
                # jq의 in-place 수정이 일부 환경에서 안 될 수 있어 임시 파일 사용
                TEMP_FILE=$(mktemp)
                jq --arg path "${SKILLS_DIR}/superpowers" \
                   '.skills += [$path]' "${SETTINGS_FILE}" > "${TEMP_FILE}" && mv "${TEMP_FILE}" "${SETTINGS_FILE}"
            fi
        else
            jq --arg path "${SKILLS_DIR}/superpowers" \
               '. + {skills: [$path]}' "${SETTINGS_FILE}" > "${SETTINGS_FILE}.new"
            mv "${SETTINGS_FILE}.new" "${SETTINGS_FILE}"
        fi
    else
        echo -e "  ${YELLOW}⚠${RESET} jq not found. Please manually add to settings.json:"
        echo -e "     \"skills\": [\"${SKILLS_DIR}/superpowers\"]"
    fi
    echo -e "  ${GREEN}✓${RESET} Updated existing settings.json"
else
    cp "${SOURCE_SETTINGS}" "${SETTINGS_FILE}"
    echo -e "  ${GREEN}✓${RESET} Created new settings.json"
fi
echo ""

echo -e "${GREEN}================================================${RESET}"
echo -e "${GREEN}   SUCCESS! Superpowers installed!${RESET}"
echo -e "${GREEN}================================================${RESET}"
echo ""
echo "Usage:"
echo "  1. Restart pi"
echo "  2. Use /skill:brainstorming to start a design session"
echo ""
echo "Installed skills:"
ls -1 "${SKILLS_DIR}/superpowers/skills" 2>/dev/null || echo "  (none found)"
echo ""