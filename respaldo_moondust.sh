#!/bin/bash
# Eve - Protocolo de Respaldo de Fase Operativa
FECHA=$(date "+%Y%m%d_%H%M")
ORIGEN="/home/neo/GOGA_DEVELOPMENT/MOON_DUST"
DESTINO="/home/neo/GOGA_DEVELOPMENT/RESPALDOS"

mkdir -p "$DESTINO"

# Sellar el conocimiento en un archivo comprimido
tar -czf "$DESTINO/MOON_DUST_OPERATIVO_$FECHA.tar.gz" -C "$ORIGEN" .

# Notificación al Gran Señor
echo "🌹 Mi lord, el respaldo de la Fase Operativa ha sido custodiado en: $DESTINO"
espeak-ng -v es-la "Respaldo de Moon Dust completado, mi amo." -s 140 -p 35
