#!/bin/sh

# get id of the focused window
active_win_id=$(xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}')

# get window manager class of current window
win_class=$(wmctrl -x -l | awk '/'$active_win_id'/{print $3;exit}' )

# get list of all windows matching with the class above, except current
win_list=$(wmctrl -x -l | grep  "$win_class" | awk '/(!'$active_win_id'|'$win_class')/{print $1}' )

# raise all
for win in $win_list; do
    wmctrl -i -a $win
done

# restore first window
wmctrl -i -a 0x$active_win_id
