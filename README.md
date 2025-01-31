# Table of contents

* [About the project](#about-the-project)
* [Installation](#installation)
* [Usage](#usage)
* [Authors](#authors)
* [License](#license)

# About the project

A simple bash script to control an minecraft server.

# Installation

Clone this repo
```
git clone https://github.com/evarioooo/minecraft-server-tool.git
```

Change directory to minecraft-server-tool
```
cd minecraft-server-tool
```

Rename the script to server.sh and delete the old minecraft-server-tool.sh
```
cp minecraft-server-tool.sh server.sh && rm minecraft-server-tool.sh
```

To run this script we should add permission
```
chmod +x server.sh
```

Edit the variables to yours
```
MC_SERVER_JAR="YOUR_MINECRAFT_SERVER.jar"
MC_SCREEN_NAME="YOUR_MINECRAFT_SCREEN"
MC_MEMORY="6G"
MC_JAR_URL="" /* You can add your own jar via ftp or something
```

# Usage

```
./server.sh {start|stop|restart|send <nachricht>|download}
```

# Authors

* [evarioooo](https://github.com/evarioooo)

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
