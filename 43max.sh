#!/bin/sh
# Maximizes current window to a ratio of 4:3

WMSTR=$(xprop -root | awk 'BEGIN{FS = "[=,]"} 
/_NET_WORKAREA.CARDINAL/{
	xmin=$2; ymin=$3; xmax=$4; ymax=$5;
	width=int(((ymax-ymin)*4)/3);
	xpos=int( (xmax-xmin-width) / 2);
	printf "0,%d,%d,%d,%d", xpos,ymin,width,ymax
}')

WINID=$(xprop -root|grep _NET_ACTIVE_WINDOW\(WINDOW\) | cut -d'#' -f2)

wmctrl -i -r $WINID -b remove,maximized_vert,maximized_horz
wmctrl -i -r $WINID -e $WMSTR 
wmctrl -i -r $WINID -b add,maximized_vert

