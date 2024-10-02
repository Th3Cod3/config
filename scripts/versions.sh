#!/usr/bin/bash
langs_runtimes="node python3 java php"

for lang in $langs_runtimes; do
    echo "Checking $lang version"
    which $lang
    type $lang
    echo "---------------------"
    $lang --version
    echo -e "=====================\n\n"
done
