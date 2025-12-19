#!/usr/bin/bash

CMD=$1

case $CMD in

    "up")
        systemctl set-default graphical.target
        ;;

    "down")
        systemctl set-default multi-user.target
        ;;
esac
