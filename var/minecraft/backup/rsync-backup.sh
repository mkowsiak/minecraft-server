#!/bin/bash

# We need -rt for rsyncing with vfat
# I have found it here: https://www.clug.org/rsync-to-fat32-drives/

rsync --ignore-existing -rt /var/minecraft/backup/* /media/minecraft-backup/

