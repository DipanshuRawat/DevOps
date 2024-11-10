#!/bin/bash
                    #part-B of assignment 6
set -x

file=./service_file.service 

registerProcess () {
    local path=$1
    local alias=$2

    if grep -q "^$alias:" "$file"; then
        echo "Error: Alias '$alias' is already registered."
        exit 1
    fi

    echo "$alias:$path" >> "$file"
    echo "Service registered with alias '$alias'."
}


startProcess() {
    local alias=$1

    if ! grep -q "^$alias:" "$file"; then
        echo "Error: Alias '$alias' is not registered."
        exit 1
    fi

    local path=$(grep "^$alias:" "$file" | cut -d ':' -f 2)
    nohup bash "$path" &> /dev/null & 
    echo "Service '$alias' started ."
}


statusProcess() {
    local alias=$1

    if ! grep -q "^$alias:" "$file"; then
        echo "Error: Alias '$alias' is not registered."
        exit 1
    fi
       local service_name=$(grep -w "$alias:" "$file" | cut -d ':' -f 2)
       local pid=$(ps -ef | grep $service_name | awk '{print $2}')
        if [ -z "$pid" ]; then
                echo "Service '$alias' is not running."
        else
                echo "Service '$alias' (PID: $pid) is running."
        fi
}


stopProcess() {
    local alias=$1

    if ! grep -q "^$alias:" "$file"; then
        echo "Error: Alias '$alias' is not registered."
        exit 1
    fi
       local service_name=$(grep -w "$alias:" "$file" | cut -d ':' -f 2)
       local pid=$(ps -ef | grep $service_name | awk '{print $2}')
        #echo $pid
    if [ "$pid" -ne 0 ]; then
        kill -9 "$pid"
        echo "Service '$alias' stopped."
    else
        echo "Service '$alias' is not running."
    fi
}

changePriority() {
    local alias=$1
    local priority=$2

    if ! grep -q "^$alias:" "$file"; then
        echo "Error: Alias '$alias' is not registered."
        exit 1
    fi
     local service_name=$(grep -w "$alias:" "$file" | cut -d ':' -f 2)
       local pid=$(ps -ef | grep $service_name | awk '{print $2}')
    if [ "$pid" -eq 0 ]; then
        echo "Error: Service '$alias' is not running."
        exit 1
    fi

    case $priority in
        low)
            sudo renice 19 "$pid"
            echo "Priority of service '$alias' set to low."
            ;;
        med)
            sudo renice 0 "$pid"
            echo "Priority of service '$alias' set to medium."
            ;;
        high)
            sudo renice -20 "$pid"
            echo "Priority of service '$alias' set to high."
            ;;
        *)
            echo "Error: Invalid priority. Use low, med, or high."
            exit 1
            ;;
    esac
}

listProcess() {
    if [ -f $file ]; then
    cat $file | awk -F ":" '{print $1}'
    else 
        echo "file not found "
    fi
}

topProcess() {

    local service_name=$(grep -w "$alias:" "$file" | cut -d ':' -f 2)
    local pid=$(ps -ef | grep $service_name | awk '{print $2}')
    if [ -z "$pid" ]; then
        echo "No running service found with alias '$alias'."
    else
        ps -p "$pid" -o  "pid,stat,pri,ni,cmd" 
    fi
}