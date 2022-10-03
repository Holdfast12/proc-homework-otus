#!/bin/bash
#без выравнивания столбцов
ls /proc/ | grep ^[0-9] | while read -r line; do echo $line | tr '\n' ' '; file /proc/$line/fd/0 | grep -q symbolic && realpath /proc/$line/fd/0 | tr '\n' ' ' || echo '?' | tr '\n' ' '; sed -n '3 p' /proc/$line/status 2>/dev/null | awk '{print $2}' | tr '\n' ' ' || echo ? | tr '\n' ' '; cat /proc/$line/cmdline 2>/dev/null | tr '\n' ' '; echo -en "\n";done;

#с выравниванием
ls /proc/ | grep ^[0-9] | while read -r line; do echo $line | tr '\n' ' '; file /proc/$line/fd/0 | grep -q symbolic && realpath /proc/$line/fd/0 | tr '\n' ' ' || echo '?' | tr '\n' ' '; sed -n '3 p' /proc/$line/status 2>/dev/null | awk '{print $2}' | tr '\n' ' ' || echo ? | tr '\n' ' '; cat /proc/$line/cmdline 2>/dev/null | tr '\n' ' '; echo -en "\n";done | awk 'BEGIN {printf "%-8s %40s %10s %-60s\n", "Pid", "TTY", "Status", "cmd"}{ printf "%-8s %40s %10s %-60s\n", $1, $2, $3, $4 }';