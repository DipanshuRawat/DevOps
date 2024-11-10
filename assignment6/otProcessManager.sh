#!/bin/bash

set -x
action=$1

case "$action" in
    topProcess)
        n=$2
        metric=$3

        if [ "$metric" == "memory" ];then
            ps aux --sort=-%mem| head -n "$n" && echo "done"
        elif [ "$metric" == "cpu" ]; then
            ps aux --sort=-%cpu | head -n "$n" && echo "done"
        fi
    ;;

    killLeastPriorityProcess)
        a=$(ps -eo pid,ni --sort=ni | tail -n 2)  # Get the least priority process info
        pid=$(echo "$a" | awk '{print $1}')  

        if [ ! -z "$pid" ]; then                  
            kill -9 "$pid"                        
            echo "Killed process with PID $pid"
        else
            echo "No process found to kill."
        fi
    ;;

    RunningDurationProcess)
        n=$2        # "name" or "pid"
        target=$3   # actual process name or PID

        if [ "$n" = "name" ]; then
            ps -eo pid,comm,etime | grep "$target"
        elif [ "$n" = "pid" ]; then 
            ps -p "$target" -o etime
        else
            echo "Invalid input. Please specify either 'name' or 'pid'."
        fi
    ;;

    ListOrphanProcess)
        echo "Listing orphan processes (adopted by init):"
        ps -eo pid,ppid,comm | awk '$2 == 1 {print $0}'
    ;;

    listZoombieProcess)
        ps -eo pid,ppid,stat,comm | awk '$3 ~ /^Z/ {print $0}'
    ;;

   	killProcess)
		pid="$2"
		if [[ "$2" =~ [^0-9] ]];then
			read -p "are you sure you want to kill process $pid? (y/n):" answer
			if [[ "$answer" == "y" ]]; then
				if pkill -9 "$pid" 2>/dev/null; then
					echo "process $pid has been killed"
				else
					echo "process $pid could not be killed or dose not exist"
				fi
			else
				echo "kill process cancelled"
			fi
		elif [ -n "$pid" ]; then
			read -p "are you sure you want to kill process $pid? (y/n):" answer
			if [[ "$answer" == "y" ]]; then
				if kill -9 "$pid" 2>/dev/null; then
					echo "process $pid has been killed"
				else
					echo "process $pid could not be killed or dose not exist"
				fi
			else
				echo "kill process cancelled"
			fi
		fi
		;;
	ListWaitingProcess)
		orphan=$(ps -eo pid,ppid,stat,comm | awk '$3 ~ /^D/')
		if [[ -n "$orphan" ]]; then
			echo "$orphan"
		else
			echo "Waiting process not found"
		fi
		;;
    *)
		echo "invalid action"
    done
esac