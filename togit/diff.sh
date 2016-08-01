#!/bin/bash
bool=$(cmp -s "$1" "$2")
if ! cmp -s "$1" "$2"; then
	#REM Files are different.
    echo $1
else
	echo "same"
fi
