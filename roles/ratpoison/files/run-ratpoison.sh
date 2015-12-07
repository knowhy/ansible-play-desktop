#!/usr/bin/bash

# Check if emacs is running
if ps aux | grep "[e]macs" > /dev/null
then
    echo "Running"
else
    emacs
fi

# Check if conkeror is running
if ps aux | grep "[c]onkeror" > /dev/null
then
    echo "Running"
else
    conkeror
fi

# Check if pulseaudio is running
if ps aux | grep "[p]ulseaudio" > /dev/null
then
    echo "Running"
else
    pulseaudio
fi

# run XDG autostart via dex
dex -a
