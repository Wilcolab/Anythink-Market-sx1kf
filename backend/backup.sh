#!/bin/bash

# A script to back up a log file to a gzipped tar archive in the root directory.
# Usage: ./backup_script.sh /path/to/your/logfile.log
# Note: This script needs to be run with root privileges (e.g., using sudo)
# to create a file in the root directory (/).

# --- Configuration ---
BACKUP_DIR="/"
ARCHIVE_NAME="backup.tar.gz"
BACKUP_PATH="${BACKUP_DIR}${ARCHIVE_NAME}"

# --- Argument Validation ---

# Check if exactly one argument is provided.
if [ "$#" -ne 1 ]; then
    echo "Error: Incorrect number of arguments."
    echo "Usage: $0 <path_to_log_file>"
    exit 1
fi

LOG_FILE=$1

# Check if the provided argument is a file and exists.
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File not found at '$LOG_FILE'"
    exit 1
fi

# --- Main Logic ---

echo "Starting backup of '$LOG_FILE'..."

# Create the compressed archive.
# -c: Create a new archive.
# -z: Compress the archive with gzip.
# -v: Verbosely list files processed.
# -f: Specifies the archive filename.
# The --absolute-names option is used to prevent tar from stripping leading slashes,
# but a better practice is to use -C to change directory to store the relative path.
# However, for this specific request of backing up a single file to a specific location,
# this is straightforward. We will use -C to change the directory to the file's
# location to avoid storing the absolute path in the tarball.

FILE_BASENAME=$(basename "$LOG_FILE")
FILE_DIR=$(dirname "$LOG_FILE")

tar -czvf "$BACKUP_PATH" -C "$FILE_DIR" "$FILE_BASENAME"

# --- Verification and Cleanup ---

# Check if the tar command was successful.
if [ $? -eq 0 ]; then
    echo "Backup successful!"
    echo "Archive created at: $BACKUP_PATH"
else
    echo "Error: Backup failed."
    exit 1
fi

# You can optionally list the contents of the new archive to verify.
echo "Verifying archive contents:"
tar -tzf "$BACKUP_PATH"

exit 0