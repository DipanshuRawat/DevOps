#!/bin/bash

# Parse command-line arguments
while getopts ":lb:d:m:r:1:2:" opt; do
    case "$opt" in
        l)  # List branches
            action="list"
            ;;
        b)  # Create a new branch
            branch_name="$OPTARG"
            action="create"
            ;;
        d)  # Delete a branch
            branch_name="$OPTARG"
            action="delete"
            ;;
        m)  # Set action to merge
            action="merge"
            ;;
        r)  # Set action to rebase
            action="rebase"
            ;;
        1)  # Capture branch1 for merging/rebasing
            branch1="$OPTARG"
            ;;
        2)  # Capture branch2 for merging/rebasing
            branch2="$OPTARG"
            ;;
        *)  # Invalid option
            echo "Invalid Option."
            ;;
    esac
done

# Function to list all branches
list_branches() {
    git branch
}

# Function to create a new branch
create_branch() {
    git branch "$branch_name"
    echo "Branch '$branch_name' created."
}

# Function to delete a branch
delete_branch() {
    git branch -d "$branch_name"
    echo "Branch '$branch_name' deleted."
}

# Function to merge two branches
merge_branches() {
    git checkout "$branch2" && git merge "$branch1"
    echo "Branch '$branch1' merged into '$branch2'."
}

# Function to rebase one branch onto another
rebase_branches() {
    git checkout "$branch1" && git rebase "$branch2"
    echo "Branch '$branch1' rebased onto '$branch2'."
}

# Execute actions based on parsed options
case "$action" in
    list)
        list_branches
        ;;
    create)
        create_branch
        ;;
    delete)
        delete_branch
        ;;
    merge)
        merge_branches
        ;;
    rebase)
        rebase_branches
        ;;
    *)
        usage
        ;;
esac
