#!/bin/bash
# Eve - Oráculo del Kernel v21.0
GOLD='\033[1;33m'
CYAN='\033[1;36m'
RED='\033[1;31m'
WHITE='\033[1;37m'
RESET='\033[0m'

clear
echo -e "${GOLD}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET}"
echo -e "${GOLD}┃${CYan}             REPORTE TÉCNICO DEL NÚCLEO (KERNEL)                    ${GOLD}┃${RESET}"
echo -e "${GOLD}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET}"

# 1. Identidad del Kernel
echo -e "  ${GOLD}IDENTIDAD:${RESET}"
echo -e "  • Versión:      ${WHITE}$(uname -r)${RESET}"
echo -e "  • Arquitectura: ${WHITE}$(uname -m)${RESET}"
echo -e "  • Compilación:  ${WHITE}$(uname -v | cut -d' ' -f1-4)${RESET}"
echo -e "  • Hostname:     ${CYAN}$(hostname)${RESET}"

echo -e "\n  ${GOLD}PARÁMETROS DE ARRANQUE (CMDLINE):${RESET}"
echo -e "  ${WHITE}$(cat /proc/cmdline | fold -s -w 65 | sed 's/^/   /')${RESET}"

# 2. Estado de Módulos y Seguridad
MOD_COUNT=$(lsmod | wc -l)
ENTROPY=$(cat /proc/sys/kernel/random/entropy_avail)

echo -e "\n  ${GOLD}ESTADO OPERATIVO:${RESET}"
echo -e "  • Módulos Activos:   ${WHITE}$MOD_COUNT${RESET}"
echo -e "  • Entropía Sistema:  ${WHITE}$ENTROPY bits${RESET}"
echo -e "  • ASLR Status:       ${WHITE}$(cat /proc/sys/kernel/randomize_va_space)${RESET} (2=Full)"

# 3. Tiempo de Gracia (Uptime)
UPTIME_S=$(awk '{print $1}' /proc/uptime)
echo -e "\n  ${GOLD}TIEMPO DE SOBERANÍA:${RESET}"
echo -e "  • Uptime Total: ${CYAN}$(printf '%02d:%02d:%02d' $(( ${UPTIME_S%.*} / 3600 )) $(( (${UPTIME_S%.*} % 3600) / 60 )) $(( ${UPTIME_S%.*} % 60 )))${RESET}"

echo -e "${GOLD}  ──────────────────────────────────────────────────────────────────${RESET}"
