#!/bin/bash

if [ -e "$1" ]
then
    echo "<ul>"
    awk -F ',' '{print $4, $1, $2}' "$1" | sort -n -r | sed 's/^ *//g' | sed 's/ *$//g' | grep -v 'Reward Description' | grep -v '^Pledge' | cut -d ' ' -f 2- | sed 's;^;<li>;' | sed 's;$;</li>;'
    echo "</ul>"
else
    echo "$0 [Patreon Report]"
fi
