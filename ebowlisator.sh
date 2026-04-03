#!/bin/bash
EBOWLA_DIR="/opt/pentest_tools/3bowla"
FILE_INPUT="$1"
FILE_CONFIG="$2"
FILE_OUTPUT="$3"

DIR_TMP=$(mktemp -d)
DIR_CWD=$(pwd)

cp "$FILE_INPUT" "$DIR_TMP"
cp "$FILE_CONFIG" "$DIR_TMP"

cd "$EBOWLA_DIR"
source venv/bin/activate
python3 ebowla.py "$DIR_TMP/$FILE_INPUT" "$DIR_TMP/$FILE_CONFIG"

FILE_GO="output/go_symmetric_$FILE_INPUT.go"

./build_go.sh x86_64 "$FILE_GO" "$FILE_OUTPUT" --hidden
rm "$FILE_GO"
mv "output/$FILE_OUTPUT" "$DIR_CWD"

cd "$DIR_CWD"
rm -rf "$DIR_TMP"
