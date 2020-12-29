[![Price](https://img.shields.io/badge/price-FREE-0098f7.svg)](https://raw.githubusercontent.com/mkowsiak/minecraft-server/master/LICENSE.md)
[![GitHub](https://img.shields.io/badge/license-MIT-green.svg)](https://raw.githubusercontent.com/mkowsiak/minecraft-server/master/LICENSE.md)
[![Download](https://img.shields.io/badge/download-click%20here-red.svg)](https://github.com/mkowsiak/minecraft-server/archive/master.zip)

<p align="center">
  <img src="https://raw.githubusercontent.com/mkowsiak/minecraft-server/master/img/minecraft.gif">
</p>

# I put a spell on you because you're mine

or Everything You Always Wanted to Know About Hosting Minecraft Server (*But Were Afraid to Ask*).

So, you want to have your own, personal, `Minecraft` server. Server, where you can be the master of puppets. One that you can call "*- My precious*". I can help you with that. It's easy, once you know how.

# Content of the repository

```
.
|-- LICENSE.md                                           - License
|-- README.md                                            - This file
|-- img                                                  - Images used in readme
|   |-- minecraft.gif                                    - Cool image at the top of repo
|   `-- tree.png                                         - Our biggest creation so far
|                                                        - Here is the structure of filesystem
|                                                          you have to put on your server
|-- etc                                                  
|   `-- systemd
|       `-- system
|           `-- minecraft.service                        - systemctl based service
`-- var                                                  
    `-- minecraft                                        - your Minecraft server
        |-- backup
        |   `-- script.sh
        `-- server
            |-- eula.txt
            |-- mcrcon                                   - console based Minecraft rcon client
            |                                              you can download it from this 
            |                                              location
            |
            |                                              https://github.com/Tiiffi/mcrcon
            |
            |
            |-- server.jar                               - This file should be downloaded
            |                                              from official Minecraft pages.
            |                                              In this project this file contains
            |                                              location of the Minecraft server.
            |
            |-- server.properties
            `-- stop_server.sh                           - This file is used for stopping the
                                                           the server by the system service
                                                            
                                                           Note! Remember to set rcon password
                                                           inside this script!
```

# Preparing your system

First of all, you need operating system on your target machine. You have plenty of choices, but here, I assume that you are going to use `Debian 10`. You can get it from: [Debian](https://www.debian.org/distrib). Once it is in place and you can start up your host machine, you have to do small preparations.

## Configure Debian repositories

Make sure to add

```
deb http://deb.debian.org/debian buster main
deb-src http://deb.debian.org/debian buster main

deb http://deb.debian.org/debian-security/ buster/updates main
deb-src http://deb.debian.org/debian-security/ buster/updates main

deb http://deb.debian.org/debian buster-updates main
deb-src http://deb.debian.org/debian buster-updates main
```

to your `apt` repositories list: `/etc/apt/sources.list`. Once locations are in place, make sure to run

```
> sudo apt update
```

## Install packages that will be required by server.

You need two things: `OpenJDK` and tools for compiling stuff using `gcc`.

```
> sudo apt-get install openjdk-11-jdk
> sudo apt-get install build-essential
> sudo apt-get install git
> sudo groupadd -r minecraft
> sudo useradd -r -g minecraft -d "/var/minecraft" -s "/bin/bash" minecraft
```

At this stage, copy everything from `var/minecraft` into `/var/minecraft/` on your server. Make sure to change the ownership of the directory.

```
> sudo chown -R minecraft.minecraft /var/minecraft
```

## Install mcrcon

`mcrcon` allows you to send commands to your `Minecraft` server. It's a `rcon` client specially crafted for `Minecraft`. To get it running you have to download it, compile it and put it in proper place.

```
> mkdir -p /tmp
> cd /tmp
> git clone https://github.com/Tiiffi/mcrcon.git
> cd mcrcon
> make
> sudo cp mcrcon /var/minecraft/server
> sudo chown minecraft.minecraft /var/minecraft/server/mcrcon
```

# Make sure Minecraft is started at boot time

In order to run your newly set up `Minecraft` server at boot time you have to create system service. You can do that by copying

```
etc/systemd/system/minecraft.service
```

into

```
/etc/systemd/system/minecraft.service
```

on your `Minecraft` server. Make sure to enable it:

```
> sudo systemctl enable minecraft
```

You can always start/stop `Minecraft` service by calling `systemctl start minecraft` and `systemctl stop minecraft` respectively.

# Enabling automatic backups

> There are two kinds of people in the world - those who do backups and those who will do.

So, you don't do backups, ha? You are oh so smart. But I want you to be safe with your newly setup server. The truth is, it's freaking easy to create scheduled backups. The easiest way to run daily backups is to use `crontab`. You can find lots of resources related to `crontab` on the web. I suggest following approach.

```
> sudo crontab -e
```

and then, put following line insde editor

```
0 1 * * * /var/minecraft/backup/script.sh
```

It will run the backup each day at `1am`. The script will stop the server, perform the backup, and start the server after backup process is finished. Basically the rules to define what to run and at what time follows

<p align="center">
  <img src="https://raw.githubusercontent.com/mkowsiak/minecraft-server/master/img/crontab.png" width="600">
</p>

If you want to fine tune your `crontab` settings, take a look here: [crontab.guru](https://crontab.guru)

# To sum up what you have read so far

After following this tutorial you should have:

- new host with `Debian 10`,
- `Minecraft` server,
- system service that brings your server up each time you system is restarted,
- `crontab` based backup of your world.

# Bonus - adding users to whitelist using mcrcon

Once you have your server up and running you can use `mcrcon` to add/remove users from whitelist. It's super easy

```
/var/minecraft/server/mcrcon -H localhost \
                             -P 8080 -p YOUR_RCON_PASSWORD \
                             "whitelist on"

/var/minecraft/server/mcrcon -H localhost \
                             -P 8080 -p YOUR_RCON_PASSWORD \
                             "whitelist add user_name"

/var/minecraft/server/mcrcon -H localhost \
                             -P 8080 -p YOUR_RCON_PASSWORD \
                             "whitelist reload"
```

# "I only want you to listen to this commercial if you are under 25"

It's time for some advertisement ;) Once you set up your own server, you can easily build things like this one :) Our first, biggest tree ever. The Mother of all Trees.

<p align="center">
  <a href="https://youtu.be/PLY_UsT2-n8"><img src="https://raw.githubusercontent.com/mkowsiak/minecraft-server/master/img/tree.png"></a>
</p>

[![Download](https://img.shields.io/badge/download-click%20here-red.svg)](https://github.com/mkowsiak/minecraft-server/archive/master.zip)

