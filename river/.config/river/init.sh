#!/bin/sh

# This is the example configuration file for river.
#
# If you wish to edit this, you will probably want to copy it to
# $XDG_CONFIG_HOME/river/init or $HOME/.config/river/init first.
#
# See the river(1), riverctl(1), and rivertile(1) man pages for complete
# documentation.

# Note: the "Super" modifier is also known as Logo, GUI, Windows, Mod4, etc.

export XDG_CURRENT_SESSION=wlr
export MOZ_ENABLE_WAYLAND=1 
export XDG_CURRENT_DESKTOP=sway
export QT_QPA_PLATFORM="wayland;xcb"

XDG_CURRENT_SESSION=wlr
XDG_CURRENT_DESKTOP=sway
MOZ_ENABLE_WAYLAND=1 
QT_QPA_PLATFORM="wayland;xcb"

riverctl spawn "sh -c '/usr/lib/xdg-desktop-portal -r & /usr/lib/xdg-desktop-portal-wlr'"
riverctl spawn waybar
riverctl spawn dunst
riverctl spawn ~/scripts/way-bg.sh
riverctl spawn ~/scripts/set-theme.sh

MOD=Super
riverctl map normal ${MOD} Return spawn kitty
riverctl map normal ${MOD} D spawn "rofi -show drun"
riverctl map normal ${MOD} Tab spawn ~/scripts/screenshot.sh

# ${MOD}+Q to close the focused view
riverctl map normal ${MOD} Q close

# ${MOD}+Shift+E to exit river
riverctl map normal ${MOD}+Shift Q exit

# ${MOD}+J and ${MOD}+K to focus the next/previous view in the layout stack
riverctl map normal ${MOD} Up    focus-view up
riverctl map normal ${MOD} Left  focus-view left
riverctl map normal ${MOD} Down  focus-view down
riverctl map normal ${MOD} Right focus-view right

riverctl map normal ${MOD}+Shift Up    swap up
riverctl map normal ${MOD}+Shift Left  swap left
riverctl map normal ${MOD}+Shift Down  swap down
riverctl map normal ${MOD}+Shift Right swap right

riverctl map normal ${MOD} J  focus-view next
riverctl map normal ${MOD} K focus-view previous

# ${MOD}+Shift+J and ${MOD}+Shift+K to swap the focused view with the next/previous
# view in the layout stack

# riverctl map normal ${MOD} J swap next
# riverctl map normal ${MOD} K swap previous

# ${MOD}+Period and ${MOD}+Comma to focus the next/previous output
riverctl map normal ${MOD} Period focus-output next
riverctl map normal ${MOD} Comma focus-output previous

# ${MOD}+Shift+{Period,Comma} to send the focused view to the next/previous output
riverctl map normal ${MOD}+Shift Period send-to-output next
riverctl map normal ${MOD}+Shift Comma send-to-output previous

# ${MOD}+Return to bump the focused view to the top of the layout stack
riverctl map normal ${MOD}+Shift Tab zoom

# ${MOD}+H and ${MOD}+L to decrease/increase the main ratio of rivertile(1)
riverctl map normal ${MOD} H send-layout-cmd rivertile "main-ratio -0.05"
riverctl map normal ${MOD} L send-layout-cmd rivertile "main-ratio +0.05"

# ${MOD}+Shift+H and ${MOD}+Shift+L to increment/decrement the main count of rivertile(1)
riverctl map normal ${MOD} I send-layout-cmd rivertile "main-count +1"
riverctl map normal ${MOD} U send-layout-cmd rivertile "main-count -1"

# ${MOD}+Alt+{H,J,K,L} to move views
riverctl map normal ${MOD}+Alt Left  move left 100
riverctl map normal ${MOD}+Alt Down  move down 100
riverctl map normal ${MOD}+Alt Up    move up 100
riverctl map normal ${MOD}+Alt Right move right 100

# ${MOD}+Alt+Control+{H,J,K,L} to snap views to screen edges
riverctl map normal ${MOD}+Alt+Control H snap left
riverctl map normal ${MOD}+Alt+Control J snap down
riverctl map normal ${MOD}+Alt+Control K snap up
riverctl map normal ${MOD}+Alt+Control L snap right

# ${MOD}+Alt+Shift+{H,J,K,L} to resize views
riverctl map normal ${MOD}+Alt+Shift Left  resize horizontal -100
riverctl map normal ${MOD}+Alt+Shift Down  resize vertical 100
riverctl map normal ${MOD}+Alt+Shift Up    resize vertical -100
riverctl map normal ${MOD}+Alt+Shift Right resize horizontal 100

# ${MOD} + Left Mouse Button to move views
riverctl map-pointer normal ${MOD} BTN_LEFT move-view

# ${MOD} + Right Mouse Button to resize views
riverctl map-pointer normal ${MOD} BTN_RIGHT resize-view

# ${MOD} + Middle Mouse Button to toggle float
riverctl map-pointer normal ${MOD} BTN_MIDDLE toggle-float

for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1)))

    # ${MOD}+[1-9] to focus tag [0-8]
    riverctl map normal ${MOD} $i set-focused-tags $tags

    # ${MOD}+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal ${MOD}+Shift $i set-view-tags $tags

    # ${MOD}+Control+[1-9] to toggle focus of tag [0-8]
    riverctl map normal ${MOD}+Control $i toggle-focused-tags $tags

    # ${MOD}+Shift+Control+[1-9] to toggle tag [0-8] of focused view
    riverctl map normal ${MOD}+Shift+Control $i toggle-view-tags $tags
done

# ${MOD}+0 to focus all tags
# ${MOD}+Shift+0 to tag focused view with all tags
all_tags=$(((1 << 32) - 1))
riverctl map normal ${MOD} 0 set-focused-tags $all_tags
riverctl map normal ${MOD}+Shift 0 set-view-tags $all_tags

# ${MOD}+Space to toggle float
riverctl map normal ${MOD} Space toggle-float

# ${MOD}+F to toggle fullscreen
riverctl map normal ${MOD} F toggle-fullscreen

# ${MOD}+{Up,Right,Down,Left} to change layout orientation
riverctl map normal ${MOD}+Shift K send-layout-cmd rivertile "main-location top"
riverctl map normal ${MOD}+Shift L send-layout-cmd rivertile "main-location right"
riverctl map normal ${MOD}+Shift J send-layout-cmd rivertile "main-location bottom"
riverctl map normal ${MOD}+Shift H send-layout-cmd rivertile "main-location left"

# Declare a passthrough mode. This mode has only a single mapping to return to
# normal mode. This makes it useful for testing a nested wayland compositor
riverctl declare-mode passthrough

# ${MOD}+F11 to enter passthrough mode
riverctl map normal ${MOD} F11 enter-mode passthrough

# ${MOD}+F11 to return to normal mode
riverctl map passthrough ${MOD} F11 enter-mode normal

# Various media key mapping examples for both normal and locked mode which do
# not have a modifier
for mode in normal locked
do
    # Eject the optical drive (well if you still have one that is)
    riverctl map $mode None XF86Eject spawn 'eject -T'

    # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
    riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
    riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
    riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

    # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
    riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
    riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

    # Control screen backlight brightness with brightnessctl (https://github.com/Hummer12007/brightnessctl)
    riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
    riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
done

# Set background and border color
riverctl background-color 0x333333
riverctl border-color-focused 0xaaeeff
riverctl border-color-unfocused 0x444444

# Set keyboard repeat rate
riverctl set-repeat 50 300

# Make all views with an app-id that starts with "float" and title "foo" start floating.
# riverctl rule-add -app-id 'float*' -title 'foo' float

# Make all views with app-id "bar" and any title use client-side decorations
# riverctl rule-add -app-id "bar" csd

# Set the default layout generator to be rivertile and start it.
# River will send the process group of the init executable SIGTERM on exit.

# riverctl default-layout rivertile
riverctl default-layout bsp-layout

riverctl keyboard-layout pl
mMOUSE="pointer-1133-49298-Logitech_G102_LIGHTSYNC_Gaming_Mouse"
riverctl input $mMOUSE accel-profile flat
riverctl input $mMOUSE pointer-accel -0.3
# rivertile -view-padding 0 -outer-padding 0 &

river-bsp-layout --inner-gap 0 --outer-gap 0 --split-perc 0.5 &
