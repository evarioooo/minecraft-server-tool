#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

MC_SERVER_JAR="spigot.jar"
MC_SCREEN_NAME="server-25565"
MC_MEMORY="6G"
MC_JAR_URL="http://media.craftlegends.world/jar/spigot-1.21.4.jar"

// The `do_check_dependencies()` function in the shell script is responsible for checking and
// installing necessary dependencies for running the Minecraft server. Here's a breakdown of what it
// does:
do_check_dependencies() {
    echo -e "${RED}Überprüfe Abhängigkeiten...${NC}"
    if ! command -v screen &> /dev/null; then
        echo -e "${YELLOW}screen wird installiert...${NC}"
        sudo apt update && sudo apt install -y screen
        echo -e "${GREEN}screen wurde installiert.${NC}"
    fi
    if ! command -v java &> /dev/null; then
        echo -e "${YELLOW}Java wird installiert...${NC}"
        sudo apt update && sudo apt install -y openjdk-17-jre
        echo -e "${GREEN}Java wurde installiert.${NC}"
    fi
    echo -e "${GREEN}Alle Abhängigkeiten sind installiert.${NC}"
}

// The `do_download()` function in the shell script is responsible for downloading the Minecraft server
// JAR file from a specified URL using the `wget` command. Here's a breakdown of what it does:
do_download() {
    echo -e "${YELLOW}Lade Minecraft-Server JAR herunter...${NC}"
    wget -O $MC_SERVER_JAR $MC_JAR_URL
    echo -e "${GREEN}Minecraft JAR wurde heruntergeladen und als ${MC_SERVER_JAR} gespeichert.${NC}"
}

// The `do_start()` function in the shell script is responsible for starting the Minecraft server.
// Here's a breakdown of what it does:
do_start() {
    do_check_dependencies
    if [ ! -f "$MC_SERVER_JAR" ]; then
        do_download
    fi
    echo -e "${YELLOW}Starte Minecraft-Server...${NC}"
    screen -dmS $MC_SCREEN_NAME java -Xmx$MC_MEMORY -Xms$MC_MEMORY -jar $MC_SERVER_JAR nogui
    echo -e "${GREEN}Minecraft Server wurde erfolgreich gestartet.${NC}"
}

// The `do_stop()` function in the shell script is responsible for stopping the Minecraft server.
// Here's a breakdown of what it does:
do_stop() {
    echo -e "${YELLOW}Stoppe Minecraft-Server...${NC}"
    screen -S $MC_SCREEN_NAME -X stuff "stop\n"
    echo -e "${GREEN}Minecraft Server wurde erfolgreich gestoppt.${NC}"
}

// The `do_restart()` function in the shell script is responsible for restarting the Minecraft server.
// Here's a breakdown of what it does:
do_restart() {
    do_stop
    sleep 5
    echo -e "${YELLOW}Warte auf eine Antwort...${NC}"
    do_start
}

// The `do_send()` function in the shell script is responsible for sending a message to the Minecraft
// server running in a screen session. Here's a breakdown of what it does:
do_send() {
    if [ -z "$1" ]; then
        echo -e "${RED}Bitte gib eine Nachricht ein.${NC}"
        exit 1
    fi
    screen -S $MC_SCREEN_NAME -X stuff "$1\n"
}

// The `case "" in ... esac` block in the shell script is a way to handle different options or
// commands passed to the script when it is executed from the command line.
case "$1" in
    start)
        do_start
        ;;
    stop)
        do_stop
        ;;
    restart)
        do_restart
        ;;
    send)
        shift
        do_send "$*"
        ;;
    download)
        do_download
        ;;
    *)
        echo -e "${YELLOW}Usage: $0 {start|stop|restart|send <nachricht>|download}${NC}"
        exit 1
        ;;
esac