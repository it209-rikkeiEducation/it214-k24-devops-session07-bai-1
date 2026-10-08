# Bài 1: Quản lý người dùng giới hạn và Truyền tải dữ liệu qua SFTP trên Windows

## Giới thiệu
Bài tập này hướng dẫn cách khởi tạo tài khoản người dùng hạn chế quyền (`sftp-user`) trên máy chủ Linux/VPS, cấp quyền đọc tệp tin nhật ký giả lập (`/var/log/app-backup/backup-check.log`), và sử dụng công cụ SFTP Client trên Windows (WinSCP / Bitvise SSH Client) để tải tệp tin về máy cục bộ an toàn.

## Cấu trúc thư mục
- `setup_sftp.sh`: Script Shell tự động hóa việc tạo tài khoản, thư mục log, và phân quyền.
- `README.md`: Báo cáo bài tập và hướng dẫn thực hiện.

## Chức năng của Script (`setup_sftp.sh`)
1. Tạo người dùng `sftp-user` không thuộc nhóm `sudo` / `wheel`.
2. Khởi tạo thư mục `/var/log/app-backup/` và tệp log `/var/log/app-backup/backup-check.log`.
3. Phân quyền `root:sftp-user` (thư mục: `750`, tệp log: `640`) đảm bảo `sftp-user` chỉ có quyền đọc.
4. Kiểm tra ID người dùng và thông tin phân quyền.

## Hướng dẫn sử dụng

### 1. Chạy script thiết lập trên Linux/VPS
```bash
chmod +x setup_sftp.sh
./setup_sftp.sh
```

### 2. Kiểm tra lại thông tin trên VPS
```bash
id sftp-user
ls -l /var/log/app-backup/backup-check.log
```

### 3. Kết nối SFTP từ Windows (Bitvise SSH Client / WinSCP)
1. Khởi động **Bitvise SSH Client** hoặc **WinSCP** trên máy tính Windows.
2. Nhập các thông tin kết nối:
   - **Host**: Địa chỉ IP VPS của bạn.
   - **Port**: `22`
   - **Username**: `sftp-user`
   - **Password**: `Password123!`
3. Nhấn **Log in** / **Connect**.
4. Khi kết nối thành công, di chuyển đến đường dẫn `/var/log/app-backup/` trên khung tệp từ xa (Remote files).
5. Chọn tệp `backup-check.log` và kéo thả về thư mục máy tính cục bộ (Local files).
6. Mở file đã tải về trên Windows để xác nhận nội dung trùng khớp với VPS.


## Ảnh chụp màn hình kết quả thực nghiệm
![Kết quả thực nghiệm](git_verification_result.png)
