#!/bin/bash
set -x

action=$1

add_connection() {
    nname="$1"
    hhost="$2"
    uuser="$3"
    poort="$4"
    sssh_key="$5"
if grep -q "$nname" ./connection; then
    echo "Connection '$nname' already exists."
else
    if [[ -z "$poort" ]]; then
        poort=22
    fi
    if [[ -n "$sssh_key" ]]; then
       m="$nname: ssh -i $sssh_key -p $poort $uuser@$hhost"
    else
        if [[ "$poort" != "22" ]]; then
            m="$nname: ssh -p $poort $uuser@$hhost"
        else
           m="$nname: ssh $uuser@$hhost"
        fi
    fi
    echo "$m" >> ./connection
    echo "Connection '$nname' for user '$uuser' added."
fi
}
list_connection() {
    if [[ "$1" == "-d" ]]; then
        cat ./connection
    else
        cut -d ':' -f1 ./connection
    fi
}
update_connection() {
    nname="$1"
    hhost="$2"
    uuser="$3"
    pport="$4"
    sssh_key="$5"
        if [[ ! -z "$pport" && ! -z "$hhost" ]]; then
        sed -i "/^$nname:/s|ssh .*@.*|ssh -p $pport $uuser@$hhost|" ./connection
    elif [[ -z "$pport" && ! -z "$hhost" ]]; then
        sed -i "/^$nname:/s|ssh .*@.*|ssh $uuser@$hhost|" ./connection
    fi
}

delete_connection() {
    nname="$1"
 sed -i "/^$nname:/d" ./connection
}

search_connection() {
    server_details=$(grep "^$action:" ./connection | cut -d ' ' -f2-)
	if [ -z "$server_details" ]; then
		echo "[ERROR]: Server information is not available, please add the server first"
	else
		echo "Connecting to $action..."
		eval "$server_details"
	fi
}

#for making  our positin argumnet match
    if [[ "$1" != "" && "$2" == "" ]]; then
        search_connection "$1"
    fi

case "$1" in
    -a)
        shift
        while getopts "n:h:u:p:i:" opt; do
            case "$opt" in
                n) name=$OPTARG ;;
                h) host=$OPTARG ;;
                u) user=$OPTARG ;;
                p) port=$OPTARG ;;
                i) ssh_key=$OPTARG ;;
            esac
        done
        add_connection "$name" "$host" "$user" "$port" "$ssh_key"
        ;;
    ls)
        list_connection "$2"
        ;;
    -u)
        shift
        while getopts "n:h:u:p:i:" opt; do
            case "$opt" in
                n) name=$OPTARG ;;
                h) host=$OPTARG ;;
                u) user=$OPTARG ;;
                p) port=$OPTARG ;;
                i) ssh_key=$OPTARG ;;
            esac
        done
        update_connection "$name" "$host" "$user" "$port" "$ssh_key"
        ;;
    rm)
        name="$2"
        delete_connection "$name";;
    *)
        search_connection;;
esac