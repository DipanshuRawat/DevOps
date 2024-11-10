#!/bin/bash
action=$1
name=$2
gname=$3
case $action in
    addTeam)
        sudo groupadd $name && echo "Group Created"
        echo "$name" >> /home/luffy/team.txt        
        ;;
    addUser)
        if id "$name" &>/dev/null; then
            echo "User already exists"
        else 
        sudo useradd -m $name -G $gname,ninjagrp  && echo " User created"  # Use -g for primary group assignment
        sudo chmod 751 /home/$name        # Set correct permissions for home directory
        sudo mkdir /home/$name/{team,ninja}
        sudo chown $name:$gname /home/$name/team
        sudo chown $name:ninjagrp /home/$name/ninja
        sudo chmod 770 /home/$name/team
        sudo chmod 770 /home/$name/ninja
        echo "$name" >> /home/luffy/user.txt
        fi
        ;;
    changeShell)
        sudo usermod -s $gname $name && echo "ho gaya bhai" # Use $gname as shell
        ;;
    changePasswd)
        sudo passwd $name && echo " Password changed"
        ;;
    delUser)
        sudo userdel $name  && echo "Deleted"
        sudo sed -i "/$name/d" /home/luffy/user.txt
        ;;
    delTeam)
        sudo groupdel $name && echo "Group deleted"
        sudo sed -i "/$name/d" /home/luffy/team.txt
        ;;
    ls)
        if [ "$name" == "User" ]; then
            cat /home/luffy/user.txt
        elif [ $name == "Team" ]; then  # Add quotes around 'Team'
            cat /home/luffy/team.txt
        else
            echo "invalid option"
        fi
        ;;
esac
