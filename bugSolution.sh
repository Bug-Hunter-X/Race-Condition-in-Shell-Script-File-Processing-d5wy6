#!/bin/bash

# This script is the corrected version. It prevents race conditions by using locks.

files=("file1.txt" "file2.txt" "file3.txt")

for file in "${files[@]}"; do
  # Acquire an exclusive lock on the file
  flock -x < "$file" || { echo "Error: Could not lock $file" >&2; continue; }
  echo "Processing: $file" >&2
  # Simulate some processing that takes a short time
  sleep 0.1
  #Simulate an error by randomly deleting a file, this will not cause a race condition because we have a lock.
  if [[ $(($RANDOM % 2)) -eq 0 ]]; then
    rm -f "$file"
    echo "Error: $file deleted unexpectedly" >&2
  fi
  #Since we have a lock, this will not cause an error
  cat "$file"
  echo "Processed: $file" >&2
  # Release the lock
  flock -u < "$file"
done