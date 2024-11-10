#!/bin/bash
##Define the log file
LOG_FILE="/tmp/process_log.txt"

##Function to log the current running processes
log_processes() {
    ps aux > "$LOG_FILE"
    echo "Current running processes logged to $LOG_FILE."
}

##Call the function to log processes
log_processes

##Function to delete the log file
delete_log_file() {
    if [[ -f "$LOG_FILE" ]]; then
        read -p "Are you sure you want to delete the log file $LOG_FILE? (y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
            rm "$LOG_FILE"
            echo "Log file $LOG_FILE deleted."
        else
            echo "Log file deletion canceled."
        fi
    else
        echo "Log file $LOG_FILE does not exist."
    fi
}
##Call the function to delete the log file
delete_log_file

##Verify the status of the log file
if [[ -f "$LOG_FILE" ]]; then
    echo "Log file still exists."
else
    echo "Log file has been successfully deleted.!"
fi

##Function to elevate the priority of a process
elevate_priority() {
    read -p "Enter the PID of the process to elevate its priority: " pid
    read -p "Enter the new priority value (-20 to 19): " priority

    # Check if the process is running
    if ps -p "$pid" > /dev/null; then
        # Change the priority using renice
        echo "Changing priority of process $pid to $priority."
        renice "$priority" -p "$pid"
        echo "Priority of process $pid changed to $priority."
    else
        echo "Process $pid is not running."
    fi
}

##Call the function to elevate the priority of a process
elevate_priority