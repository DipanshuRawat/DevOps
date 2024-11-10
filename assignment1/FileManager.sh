#!/bin/bash
#echo "First arg: $1"
#echo "Second arg: $2"

# Assign variables
COMMAND=$1       # Command to execute (e.g., addDir, addFile)
TARGET_DIR=$2    # Directory path (e.g., /tmp/dir1)
FILE_NAME=$3     # Optional file name (e.g., file1.txt)
CONTENT=$4       # Optional content or additional arguments
OPTION=$5        # Additional options like line numbers for file operations

# Use case statement for different operations
case "$COMMAND" in

  # Create a Directory
  addDir)
    mkdir "$TARGET_DIR/$FILE_NAME"
    echo "Directory created"
    ;;

  # Delete a Directory
  deleteDir)
    rmdir "$TARGET_DIR/$FILE_NAME"
    echo "Directory deleted"
    ;;

  # List all (files and directories)
  listAll)
    ls -la "$TARGET_DIR"
    ;;

  # List only files
  listFiles)
    find "$TARGET_DIR"  -type f
    ;;

  # List only directories
  listDirs)
    find "$TARGET_DIR"  -type d
    ;;

  # Create a File
  addFile)
    echo "$CONTENT" > "$TARGET_DIR/$FILE_NAME"
    echo "File created"
    ;;

  # Add content to an existing file
  addContentToFile)
    echo "$CONTENT" >> "$TARGET_DIR/$FILE_NAME"
    echo "Content added to file"
    ;;

  # Add content at the beginning of the file
  addContentToFileBeginning)
    TEMP_FILE="$TARGET_DIR/temp.txt"
    echo "$CONTENT" > "$TEMP_FILE"
    cat "$TARGET_DIR/$FILE_NAME" >> "$TEMP_FILE"
    mv "$TEMP_FILE" "$TARGET_DIR/$FILE_NAME"
    echo "Content added to the beginning of the file"
    ;;

  # Show top n lines of a file
  showFileBeginningContent)
    head -n "$CONTENT" "$TARGET_DIR/$FILE_NAME"
    ;;
 #show last n lines of a file
 showFileEndContent)
    tail -n "$CONTENT" "$TARGET_DIR/$FILE_NAME"
    ;;
# Show content at a specific line number (using head and tail)
  showFileContentAtLine)
    head -n "$CONTENT" "$TARGET_DIR/$FILE_NAME" | tail -n 1
    ;;
  # Show content in a specific line number range (using head and tail)
  showFileContentForLineRange)
    head -n "$CONTENT" "$TARGET_DIR/$FILE_NAME" | tail -n "$OPTION" "$TARGET_DIR/$FILE_NAME"
    ;;
  # Move a file
  moveFile)
    mv "$TARGET_DIR/$FILE_NAME" "$CONTENT"
    echo "File moved from $TARGET_DIR/$FILE_NAME to $CONTENT"
    ;;
  # Copy a file
  copyFile)
    cp "$TARGET_DIR/$FILE_NAME" "$CONTENT"
    echo "File copied to $CONTENT"
    ;;
  # Delete a file
  deleteFile)
    rm "$TARGET_DIR/$FILE_NAME"
    echo "File deleted: $TARGET_DIR/$FILE_NAME"
    ;;
esac
