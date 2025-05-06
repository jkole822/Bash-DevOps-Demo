# backup_logs.sh - Archive and back up logs from /var/log to a backup folder

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="./backups"
SOURCE_DIR="/var/log"
LOG_FILE="./backup.log"
DRY_RUN=false

mkdir -p "$BACKUP_DIR"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "[$TIMESTAMP] ERROR: Source directory '$SOURCE_DIR' does not exist." | tee -a "$LOG_FILE"
  exit 1
fi

if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "[$TIMESTAMP] INFO: Running in dry mode." | tee -a "$LOG_FILE"
fi

if [ "$DRY_RUN" = false ]; then
  ARCHIVE_FILE="$BACKUP_DIR/logs_backup_$TIMESTAMP.tar.gz" 

  tar -czf "$ARCHIVE_FILE" "$SOURCE_DIR" 2>> "$LOG_FILE"

  if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] SUCCESS: Logs archived to $ARCHIVE_FILE" | tee -a "$LOG_FILE"
  else
    echo "[$TIMESTAMP] ERROR: Failed to archive logs." | tee -a "$LOG_FILE"
  fi
else
  echo "[$TIMESTAMP] INFO: Skipping archive creation (dry run)." | tee -a "$LOG_FILE"
fi

find "$BACKUP_DIR" -type f -mtime +7 -print -delete | tee -a "$LOG_FILE"
