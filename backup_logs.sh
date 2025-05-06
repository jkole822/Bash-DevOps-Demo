# backup_logs.sh - Archive and back up logs from /var/log to a backup folder

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="./backups"
SOURCE_DIR="/var/log"
ARCHIVE_FILE="$BACKUP_DIR/logs_backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czf "$ARCHIVE_FILE" "$SOURCE_DIR"

echo "Logs backed up to $ARCHIVE_FILE"
