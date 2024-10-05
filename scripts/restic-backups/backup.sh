#!/bin/bash

# Check if the restic command is available
if ! command -v restic &> /dev/null; then
    echo "Error: restic command not found. Please make sure restic is installed."
    exit 1
fi

# Load the environment variables
BUCKET=$(op read op://HomeLab/Restic/Bucket)
REPO=$(op read op://HomeLab/Restic/Repository)

export RESTIC_PASSWORD=$(op read op://HomeLab/Restic/Password)
export B2_ACCOUNT_ID=$(op read op://HomeLab/Restic/B2AccountID)
export B2_ACCOUNT_KEY=$(op read op://HomeLab/Restic/B2AccountKey)

B2REPO="-r b2:$BUCKET:$REPO"
BACKUP_ARGS="$B2REPO --verbose backup --exclude-caches --exclude-file=/home/maxi/dotfiles/scripts/restic-backups/restic-exclude.txt --files-from=/home/maxi/dotfiles/scripts/restic-backups/restic-files.txt"
RESTORE_ARGS="$B2REPO --verbose=3 -t restored/"

# # Determine the action based on the first argument
case "$1" in
    init)
        # Initialize the repository
        restic $B2REPO init
        ;;
    backup)
        # Perform backup
        restic $BACKUP_ARGS backup
        ;;
    backup-dry)
        # Perform backup
        restic $BACKUP_ARGS --dry-run backup
        ;;
    list)
        # List snapshots
        restic $B2REPO snapshots
        ;;
    forget)
        # Forget snapshots
        restic $B2REPO forget $2
        ;;
    cleanup)
        # Delete snapshots
        restic $B2REPO forget --prune --keep-last 5 --keep-daily 7 --keep-weekly 4 --keep-monthly 6
        ;;
    restore)
        # Restore backup
        restic $RESTORE_ARGS restore $2
        ;;
    *)
        echo "Invalid argument. Usage: $0 <backup|restore>"
        exit 1
        ;;
esac