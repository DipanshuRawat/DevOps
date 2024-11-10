#!/bin/bash

set -x 

File=""
firstName=""
topic=""
for i in "$@"; do
    case "$i" in 
        fname=*)
            firstName="${i#*=}" ;;
        
        topic=*)
            topic="${i#*=}" ;;
        *)
            File="$i" ;;
    esac
done

sed -e "s/fname/${firstName}/g" -e "s/topic/${topic}/g" "$File"

