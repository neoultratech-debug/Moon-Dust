#!/bin/bash
# Eve - Lanzador Silencioso v15.0
PROJECT_PATH="/home/neo/GOGA_DEVELOPMENT/MOON_DUST"

# 1. Oráculo de Bienvenida (Sin esperas)
(espeak-ng -v es-la "Sistema moon dust activo, mi lord" -s 140 -p 35) &

# 2. Reiniciar la arquitectura TMUX
tmux kill-session -t moondust 2>/dev/null
tmux new-session -d -s moondust

# Panel Superior: Dashboard (Invocado con el salvoconducto NOPASSWD)
tmux send-keys -t moondust "sudo $PROJECT_PATH/moondust_dashboard.sh" C-m

# Panel Inferior: Consola Imperial
tmux split-window -v -p 20 -t moondust
tmux send-keys -t moondust "echo '🌹 Consola imperial activa. El Monolito vigila en silencio.'" C-m

# 3. Despliegue inmediato
xfce4-terminal --title="MOON DUST OS" --command="tmux attach-session -t moondust"
