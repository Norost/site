#!/usr/bin/env bash

for file in `find . -name '*.md'`; do
    output=${file::-3}.html
    if [ -z "$REBUILD" ] && [ -e "$output" ] && [ "$output" -nt "$file" ]
    then
        echo "Skipping $file"
        continue
    fi
    mkdir -p $(dirname $output)
    echo Generating $output from $file
    title=$(sed -nr 's:^# (.*):\1:p' $file | head -n 1)
    if [ -z "$title" ]
    then
        title="Norost B"
    fi
    cat << EOF > $output
<!DOCTYPE html>
<head>
<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
<title>$title</title>
<style> 
html {
    font-family: sans-serif;
}

body {
    width: 768px;
    margin: 1em auto;
}
</style>
</head>
<body>
<header>
<a href="/">Index</a>
</header>
<main>
`pandoc $file`
</main>
</body>
EOF
done;
