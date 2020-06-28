#!/bin/bash

/var/minecraft/server/mcrcon -H localhost -P 8080 -p YOUR_RCON_PASSWORD -w 5 "say Server is restarting!" save-all stop

