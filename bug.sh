#!/bin/bash

# This script attempts to process a list of files,
# but it has a subtle race condition.

files=("file1.txt" "file2.txt" "file3.txt")

for file in "${files[@]}"; do
  # Simulate some processing that takes a short time
  sleep 0.1
  # Here is a critical section. Multiple processes could try to process the same file concurrently.
  echo "Processing: $file" >&2
  #Simulate an error by randomly deleting a file, this will cause a race condition.
  if [[ $(($RANDOM % 2)) -eq 0 ]]; then
    rm -f "$file"
    echo "Error: $file deleted unexpectedly" >&2
  fi
  #The issue is that the file could be deleted before it is processed.
  #If the processing takes longer the file will not exist.
  cat "$file" # This line may fail if the file is deleted
  echo "Processed: $file" >&2
done