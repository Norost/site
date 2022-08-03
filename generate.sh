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
    title=$(sed -nr 's:^= (.*):\1:p' $file | head -n 1)
    if [ -z "$title" ]
    then
        title="Norost B"
    fi
    asciidoctor $file -o $output
done;

exit
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

img {
    width: 100%;
    margin: 0.4em;
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
