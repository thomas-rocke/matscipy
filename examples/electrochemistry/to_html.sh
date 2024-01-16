#!/bin/bash
# Read input file names either from cmd line arguments or from stdin,
# loop over input files, sync .py with .ipynb, then convert to .html.
# Call with
#   ls -1 *.py | grep -v to_html.py | bash to_html.sh
#
infiles="$@"
if [ "${infiles}" = "" ]; then
    while IFS= read -r line; do
        infiles="${infiles} $line"
    done
fi

echo "Convert ${infiles}..."

for file in ${infiles}; do
    BASENAME=$(basename "${file}" .py)
    echo "${BASENAME}.py to ${BASENAME}.ipynb"
    jupytext --sync "$file"
    echo "${BASENAME}.ipynb to ${BASENAME}.html"
    python to_html.py "${BASENAME}.ipynb"
done
