#!/bin/bash

# A script to back up a log file to a gzipped tar archive.
# The archive will be saved in the same directory where this script is located.
# Usage: ./backup_script.sh /path/to/your/logfile.log

# --- Configuration ---
# Get the absolute path of the directory where the script is located. This works even
# if the script is called from a different directory or through a symbolic link.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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

# Get just the filename from the input path (e.g., "syslog.log")
FILE_BASENAME=$(basename "$LOG_FILE")
# Get the directory containing the log file.
FILE_DIR=$(dirname "$LOG_FILE")

# Set a fixed archive name as requested.
ARCHIVE_NAME="backup.tar.gz"
BACKUP_PATH="${SCRIPT_DIR}/${ARCHIVE_NAME}"

echo "Backup file will be saved as: ${BACKUP_PATH}"
echo "Warning: This will overwrite any existing file named 'backup.tar.gz' in the script's directory."

# Create the compressed archive.
# -c: Create a new archive.
# -z: Compress the archive with gzip.
# -v: Verbosely list files processed.
# -f: Specifies the archive filename.
# -C: Change to the specified directory before performing any operations.
#     This ensures the archive contains relative paths, not absolute ones.
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
