#!/bin/bash
# http://unix.stackexchange.com/questions/4489/a-tool-for-automatically-applying-randr-configuration-when-external-display-is-p

# setting up new mode for my VGA
#xrandr --newmode "1920x1080" 148.5 1920 2008 2052 2200 1080 1089 1095 1125 +hsync +vsync
#xrandr --addmode VGA1 1920x1080

# default monitor is LVDS1
MONITOR=LVDS1

# functions to switch from LVDS1 to VGA and vice versa
function ActivateVGA {
    echo "Switching to VGA1"
    xrandr --output VGA1 --mode 1920x1080 --dpi 160 --output LVDS1 --off
    MONITOR=VGA1
}
function DeactivateVGA {
    echo "Switching to LVDS1"
    xrandr --output VGA1 --off --output LVDS1 --auto
    MONITOR=LVDS1
}

# functions to check if VGA is connected and in use
function VGAActive {
    [ $MONITOR = "VGA1" ]
}
function VGAConnected {
    ! xrandr | grep "^VGA1" | grep disconnected
}

# actual script
while true
do
    if ! VGAActive && VGAConnected
    then
        ActivateVGA
    fi

    if VGAActive && ! VGAConnected
    then
        DeactivateVGA
    fi

    sleep 1s
done
