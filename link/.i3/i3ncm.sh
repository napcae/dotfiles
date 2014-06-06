#!/bin/bash
i3status | while :
do
        read line
        playing=$(mpc current)
        echo "$playing | $line" || exit 1
done

