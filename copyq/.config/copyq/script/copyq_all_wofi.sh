#!/usr/bin/env bash

SOURCE_DIR="$(dirname ${BASH_SOURCE[0]})"
SELECTED_INDEX="$($SOURCE_DIR/copyq_all.sh | wofi --dmenu -print_line_num | cut -d  '('  -f2 | cut -d  ')'  -f1)"

if [ "$SELECTED_INDEX" -eq "$SELECTED_INDEX" ] 2>/dev/null; then
   copyq select "$SELECTED_INDEX"
   copyq read 0 | wl-copy -p
   copyq read 0 | wl-copy
fi
