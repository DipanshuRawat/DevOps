#!bin/bash
set -x
. function.sh
                    #part B of Assignment 6


    while getopts ":o:s:a:p:" opt; do
        case $opt in
            o)
                operation=$OPTARG
                ;;
            s)
                path=$OPTARG
                ;;
            a)
                alias=$OPTARG
                ;;
            p)
                priority=$OPTARG
                ;;
            *)
                echo "Invalid option"
                exit 1
                ;;
        esac
    done

    case $operation in
        register)
            if [ -z "$path" ] || [ -z "$alias" ]; then
                echo "Error: Script path and alias are required."
                exit 1
            fi
            registerProcess "$path" "$alias"
            ;;
        start)
            if [ -z "$alias" ]; then
                echo "Error: Alias is required."
                exit 1
            fi
            startProcess "$alias"
            ;;
        status)
            if [ -z "$alias" ]; then
                echo "Error: Alias is required."
                exit 1
            fi
            statusProcess "$alias"
            ;;
        kill)
            if [ -z "$alias" ]; then
                echo "Error: Alias is required."
                exit 1
            fi
            stopProcess "$alias"
            ;;
        priority)
            if [ -z "$priority" ] || [ -z "$alias" ]; then
                echo "Error: Priority and alias are required."
                exit 1
            fi
            changePriority "$alias" "$priority"
            ;;
        list)
            listProcess
            ;;
        top)
            if [ -z "$alias" ]; then
                echo "Error: Alias is required."
                exit 1
            fi        
            topProcess
            ;;
        *)
            echo "Error: Invalid operation."
            exit 1
            ;;
    esac