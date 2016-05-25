#!/bin/sh
# This a kind of dirty fix for the nautilus desktop
#if ($3 == "desktop_window.Nautilus" && $5 == "Desktop") next;
# if ($2 == "-1") might be a more general fix. At least with LXDE.

WMCTRL=$(wmctrl -lxi |sort -k 3)
DMENU_PATH=$(dmenu_path)
echo "$WMCTRL\n$DMENU_PATH" | awk 'BEGIN{nr=1}
{
    if ($3 == "N/A") next 
    if ($2 == "-1") next
    if ($3 == "desktop_window.Nautilus" && $5 == "Desktop") next
    if ($2 != "") {
        title=substr($0, index($0, $5)) 
        progs[nr" "$3]=$1 
        list=list nr" "$3" - "title "\n"
        nr=nr+1
    } else {
        list=list "run: " $1 "\n"
    }
} 
END{
    cmd = "echo -n \"" list "\" | dmenu -i -l " nr
    cmd | getline res 
    sub_res=substr(res, 0, index(res, " - "))
    if (progs[sub_res] != "") {
        system("wmctrl -i -a " progs[sub_res])
    } else {
        system(substr(res, 6)"&")
    }
}'  



