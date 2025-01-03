# Shell Script Race Condition

This repository demonstrates a race condition in a simple shell script that processes a list of files.  The script simulates file processing, introducing a random chance of a file being deleted during processing. This can lead to errors or unexpected behavior.

## Bug Description
The script iterates through a list of files, simulating processing with a `sleep` command. A critical section introduces randomness; there is a chance a file is deleted before processing finishes.  This causes the `cat` command to fail. This race condition can make it difficult to ensure the data integrity of the script.

## How to Reproduce
1. Clone this repository.
2. Ensure the `file1.txt`, `file2.txt`, and `file3.txt` files exist in the directory. They can be empty files.
3. Run the `bug.sh` script. Observe that the error messages and the success messages are unpredictable due to the race condition.

## Solution
The solution involves using file locking mechanisms to ensure exclusive access to each file during processing. See `bugSolution.sh` for an improved implementation.