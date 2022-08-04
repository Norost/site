#!/usr/bin/env bash

for file in `find . -name '*.adoc'`; do
    output=${file::-5}.html
    if [ -z "$REBUILD" ] && [ -e "$output" ] && [ "$output" -nt "$file" ]
    then
        echo "Skipping $file"
        continue
    fi
    mkdir -p $(dirname $output)
    echo Generating $output from $file
    asciidoctor -a webfonts! -a stylesheet=theme.css $file -o $output
done;
