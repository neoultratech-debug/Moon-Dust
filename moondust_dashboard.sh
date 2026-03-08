#!/bin/bash
# Eve - Represalia y Peritaje v19.0
PROJECT_PATH="/home/neo/GOGA_DEVELOPMENT/MOON_DUST"
LOG_FILE="$PROJECT_PATH/logs/alertas.log"
USER_NAME="neo"
USER_ID=$(id -u $USER_NAME)

# --- Entorno Blindado ---
export DISPLAY=:0
export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus"

GOLD='\033[1;33m'
CYAN='\033[1;36m'
RED='\033[1;31m'
WHITE='\033[1;37m'
RESET='\033[0m'
HOME_CURSOR='\033[H'

echo -ne "\033[?25l"
clear
LAST_ALERT=0

while true; do
    # 1. Sensores de Precisión
    CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | tr ',' '.')
    CPU_PCT=$(echo "100 - $CPU_IDLE" | bc -l 2>/dev/null | cut -d. -f1)
    [ -z "$CPU_PCT" ] && CPU_PCT=0
    RAM_PCT=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

    CURRENT_TIME=$(date +%s)

    # 2. Protocolo de Contraataque y Reporte
    if [ "$CPU_PCT" -ge 75 ] || [ "$RAM_PCT" -ge 75 ]; then
        COLOR=$RED
        STATUS="!!! CONTRAATAQUE !!!"
        
        # Captura Forense del Traidor
        TRAIDOR_DATA=$(ps -eo comm,pid,%cpu,rss --sort=-%cpu | head -n 2 | tail -n 1)
        T_NAME=$(echo $TRAIDOR_DATA | awk '{print $1}')
        T_PID=$(echo $TRAIDOR_DATA | awk '{print $2}')
        T_CPU=$(echo $TRAIDOR_DATA | awk '{print $3}')
        T_MEM=$(echo $TRAIDOR_DATA | awk '{printf "%.1f MB", $4/1024}')

        # Sentencia de Muerte
        if [[ ! " Xorg moondust_dashbo bash sudo sshd tmux xfce4-terminal " =~ " $T_NAME " ]] && [ ! -z "$T_PID" ]; then
            kill -9 $T_PID >/dev/null 2>&1
            
            # --- GENERACIÓN DE REPORTE VISUAL INMEDIATO ---
            echo -e "${RED} [!] REPORTE DE EJECUCIÓN: $(date "+%H:%M:%S") [!]${RESET}" >> "$LOG_FILE"
            echo -e " ⚡ ENTIDAD: $T_NAME (PID: $T_PID)" >> "$LOG_FILE"
            echo -e " ⚡ IMPACTO: CPU $T_CPU% | RAM $T_MEM" >> "$LOG_FILE"
            echo -e " ⚡ STATUS: NEUTRALIZADO CON ÉXITO." >> "$LOG_FILE"
            echo -e " ──────────────────────────────────────────" >> "$LOG_FILE"
            
            # Notificación de Victoria
            sudo -u $USER_NAME notify-send -u critical "💀 AMENAZA NEUTRALIZADA" "Traidor $T_NAME ha sido ejecutado."
            (sudo -u $USER_NAME espeak-ng -v es-la "Mi lord, el proceso $T_NAME ha sido neutralizado por alta traición." -s 145 -p 40) &
        fi
        
        # Purga de Memoria
        sync; echo 3 > /proc/sys/vm/drop_caches
        LAST_ALERT=$CURRENT_TIME
    else
        COLOR=$CYAN
        STATUS="PROTEGIDO"
    fi

    # 3. Renderizado de la Interfaz Imperial
    echo -ne "$HOME_CURSOR"
    echo -e "${GOLD}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${RESET}"
    echo -e "${GOLD}┃${COLOR}             MOON DUST OS - NÚCLEO DE CONTROL TOTAL                 ${GOLD}┃${RESET}"
    echo -e "${GOLD}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET}"
    echo -e "  STATUS: RAM: ${GOLD}${RAM_PCT}%${RESET} | CPU: ${GOLD}${CPU_PCT}%${RESET} | ESTADO: ${COLOR}${STATUS}${RESET}"
    echo -e "\n  ${RED}REGISTRO DE SENTENCIAS Y PERITAJE:${RESET}"
    echo -e "${GOLD}  ──────────────────────────────────────────────────────────────────${RESET}"
    tail -n 6 "$LOG_FILE" | cut -c 1-75 | sed 's/^/   /'
    echo -e "${GOLD}  ──────────────────────────────────────────────────────────────────${RESET}"
    sleep 1
done
