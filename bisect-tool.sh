#!/bin/bash

trap handler SIGINT

INTERRUPTED=0

handler() {
    echo "Heard interrupt"
    INTERRUPTED=1
}

# Takes the program to run as the first argument. Everything else is passed onto that script.
validater=$1
shift

# The validater program should trap SIGINT (Ctrl-C) and return zero on GOOD and non-zer for BAD.
eval "$validater $@"

result=$?

if [ $INTERRUPTED -ne 0 ]; then
    exit 1
elif [ $? -ne 0 ]; then
    exit $result
fi

read -r -p "Did it work? [Ny]" work
case "$work" in
    Y|y)
        exit 0
        ;;
    *)
        exit 1
        ;;
esac
