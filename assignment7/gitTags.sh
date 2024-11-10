#!/bin/bash

# Function to create a new tag
create_tag() {
    tag_name=$1
    git tag "$tag_name"
    echo "Tag '$tag_name' created."
}

# Function to list all tags
list_tags() {
    git tag
}

# Function to delete a tag
delete_tag() {
    tag_name=$1
    git tag -d "$tag_name"
    echo "Tag '$tag_name' deleted."
}


# Parse command-line arguments
while getopts ":c:ld:" opt; do
    case "$opt" in
        c)  # Create a new tag
            tag_name="$OPTARG"
            action="create"
            ;;
        l)  # List tags
            action="list"
            ;;
        d)  # Delete a tag
            tag_name="$OPTARG"
            action="delete"
            ;;
        *)  # Invalid option
            echo "Invalid option."
            ;;
    esac
done

# Execute actions based on parsed options
case "$action" in
    create)
        create_tag "$tag_name"
        ;;
    list)
        list_tags
        ;;
    delete)
        delete_tag "$tag_name"
        ;;
    *)
        echo "Invalid Option."
        ;;
esac
