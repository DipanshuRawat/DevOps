#!/bin/bash

set -x

action=$1
file=$2

case "$action" in 
    addLineTop)
        line=$3
        sed -i "1i ${line}" ${file} && echo "Line added at Top"
    ;;

    addLineBottom)
        line=$3
        sed -i "$ a\\${line}" ${file} && echo "Line added at bottom"
    ;;
    
    addLineAt)
        lineNumber=$3
        line=$4
        sed -i "${lineNumber} a ${line}" ${file} && echo "Line added"
    ;;

    updateFirstWord)
        word1=$3
        word2=$4
        sed -i "0,/${word1}/s//${word2}/" ${file} && echo "Updated First Occurence of word"
    ;;

    updateAllWords)
        word1=$3
        word2=$4
        sed -i "s/${word1}/${word2}/g" ${file} && echo "Word Updated"
    ;;

    insertWord)
        WORD1=$3
        WORD2=$4
        WORD_TO_INSERT=$5
        sed -i "s/\(${WORD1}\) \(${WORD2}\)/\1 ${WORD_TO_INSERT} \2/" ${file} && echo "Word inserted"
    ;;

    deleteLine)
        lineNumber=$3
        if [ "$#" -eq 3 ]; then
            sed -i "${lineNumber}d" ${file} && echo "line Deleted"
        elif [ "$#" -eq 4 ]; then
            word=$4
            sed -i "${lineNumber}s/${word}//g" ${file} && echo "Word deleted"
        fi
    ;;
esac