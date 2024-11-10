#!/bin/bash

set -x
#variable initialization
action=$1
position=$2
dataFile="/home/luffy/linux/assignment4/file.txt"

Name="" Hostname="" Username="" Port="" Pem_key="" SSH="ssh"
     
# Function to add new user connection details
     	
addConnection(){
	while getopts "n:h:u:p:i:" opt;
	do
    	case $opt in
		n)
    		Name=$OPTARG;;
    	h)
    		Hostname=$OPTARG;;
    	u)
    		Username=$OPTARG;;
    	p)
    		Port=$OPTARG;;
    	i)
    	    Pem_key=$OPTARG;;
    		esac
    	done
    if grep -q "$Name" "$dataFile"; then
        echo "Connection '$Name' already exists."
    else
        #If pem key is provided add it to variacle 'ssh'
        [ -n "$Pem_key" ] && SSH="$SSH -i $Pem_key"
        
        #If port is provided add it to variable 'ssh'
        [ -n "$Port" ] && SSH="$SSH -p $Port"
        
        #Finally completing the ssh output
        SSH="$SSH $Username@$Hostname"
            
        echo "$Name: $SSH" >> "$dataFile"

        echo "Connection Added"
    fi
}
    	
    	

#List Connections
    	
listConnection(){
	if [[ $position == "-d" ]]; 
	then
        cat "dataFile"

    	else
        awk '{print $1}' "$dataFile"

    	fi
    		
}
    	
    	
# Function to update user details
    	
updateConnection(){
    	
	while getopts "n:h:u:p" opts;
    	do
    		case $opts in
    			n)
    				Name=$OPTARG
    				;;
    			h)
    				Hostname=$OPTARG
    				;;
    			u)
    				Username=$OPTARG
    				;;
    			p)
    				Port=$OPTARG
    				;;
    		esac
    	done
    	
    	[ -n "$Port" ] && SSH="$SSH -p $Port"
    	
    	SSH="$SSH $Username@$Hostname"
    	
    	sed -i "/^$Name:/c\\$Name: $SSH" "$dataFile"

    	
}
    	
#Delete a user entry

delConnection(){
	sed -i "/^$position../d" "$dataFile"
}

#Connect to server

setConnection(){
	server_details=$(grep "^$action:" "$dataFile" | cut -d ' ' -f2-)
	if [ -z "$server_details" ]; then
		echo "[ERROR]: Server information is not available, please add the server first"
	else
		echo "Connecting to $action..."
		eval "$server_details"
	fi
}

#Main Utility
    	
case $action in
    -a)
		shift
    	    addConnection "$@"
   		;;
   	-u)
		shift
   		    updateConnection "$@" && echo "Connection Updated"
   		;;
	ls)
		    listConnection
		;;
	rm)
		    delConnection && echo "Connection Deleted"
		;;
	*)				 
		    setConnection
		;;
esac
