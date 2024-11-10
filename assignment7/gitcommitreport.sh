#!/bin/bash

# git URL and days
git_url=$1
days=$2

# directory clone path
dir=./clone

# Clone the repository
git clone "$git_url" "$dir"

# Change to the temporary directory
cd "$dir" || exit
echo "Changed to directory: $dir"

# HTML file to store the report
REPORT_FILE=../report.csv

echo "Date,Author Name,Author Email,Commit Message,Commit Hash" > $REPORT_FILE
git log --pretty=format:"%ad,%an,%ae,%s,%H" --since="$days days ago" >> $REPORT_FILE
sed -i s/,/"|"/g $REPORT_FILE