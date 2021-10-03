#!/bin/bash

set -e

RAW_ASSETS=./krita_raws
COMPILED_ASSETS=./sprites

specific=$1

function export_png() {
    IN=$1
    OUT=$(echo $IN | sed 's/\.kra/.png/')
    cmd="krita $RAW_ASSETS/$IN --export --export-filename $COMPILED_ASSETS/$OUT 2>/dev/null"
    echo $cmd
    $cmd
}

exported=false
for f in $RAW_ASSETS/*.kra
do
	file=$(basename $f)
	if [[ $specific = "" ]] || [[ $file = "$specific.kra" ]]; then
		echo "Exporting $file"
		export_png $file
		exported=true
	fi
done

if [[ !exported ]]; then 
	echo "No .kra files to export"
fi
