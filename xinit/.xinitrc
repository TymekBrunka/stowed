#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

case "$2" in
    dwm)
        echo "dwm $2" >> ~/xlog
        dwm
        ;;
    nxwm)
        echo "nxwm $2" >> ~/xlog
        sx kitty -c NONE -o placement_strategy=top-left -e nvim -c 'lua require("nxwm").start()'
        ;;
    hm)
        echo "hackmatrix $2" >> ~/xlog
        cd /home/tymek/HackMatrix/
        ./matrix
        ;;
    xwm)
        echo "xwm $2" >> ~/xlog
        cd /home/tymek/Documents/x-wm/
        ./xwm >> ~/xwm.log
        ;;
    xcswm)
        echo "x cswm $2" >> ~/xlog
        cd /home/tymek/Documents/cswm/build/
        ./xcswm >> ~/xwm.log
        ;;
    *)
        echo "whatever $2" >> ~/xlog
        dwm
        ;;
esac
