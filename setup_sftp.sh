#!/bin/bash
set -e

# Script khoi tao sftp-user va thiet lap thu muc log

USER_NAME="sftp-user"
LOG_DIR="/var/log/app-backup"
LOG_FILE="$LOG_DIR/backup-check.log"

echo "=== 1. Tao nguoi dung $USER_NAME neu chua ton tai ==="
if id "$USER_NAME" &>/dev/null; then
    echo "Nguoi dung $USER_NAME da ton tai."
else
    sudo adduser --disabled-password --gecos "" "$USER_NAME"
    echo "$USER_NAME:Password123!" | sudo chpasswd
    echo "Da tao nguoi dung $USER_NAME voi mat khau mac dinh: Password123!"
fi

echo "=== 2. Tao thu muc log va file log gia lap ==="
sudo mkdir -p "$LOG_DIR"
sudo touch "$LOG_FILE"
sudo bash -c "echo 'Backup status: SUCCESS at \$(date)' > '$LOG_FILE'"

echo "=== 3. Phan quyen cho thu muc va file log ==="
sudo chown -R root:"$USER_NAME" "$LOG_DIR"
sudo chmod 750 "$LOG_DIR"
sudo chmod 640 "$LOG_FILE"

echo "=== 4. Kiem tra va hien thi thong tin ==="
echo "[+] Thong tin id cua $USER_NAME:"
id "$USER_NAME"

echo "[+] Thong tin quyen va thu muc log:"
ls -ld "$LOG_DIR"
ls -l "$LOG_FILE"

echo "=== Hoan thanh thiet lap thanh cong ==="
