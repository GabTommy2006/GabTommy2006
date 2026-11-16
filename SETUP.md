# Đưa README lên profile GitHub

Profile đã được chuẩn bị trong `README.md`; banner nằm trong `assets/profile-banner.svg`.

## Hiển thị trên trang cá nhân

GitHub hiển thị profile README từ repository **public có tên trùng với username**. Với tài khoản này, tên cần dùng là `GabTommy2006`.

1. Đổi tên repository `Personal-Profile` thành `GabTommy2006` trong **Settings → General → Repository name**, hoặc tạo repository public mới có tên `GabTommy2006`.
2. Đưa `README.md` và thư mục `assets` lên nhánh mặc định của repository đó. Giữ README ở thư mục gốc để đường dẫn banner hoạt động.
3. Mở <https://github.com/GabTommy2006> để kiểm tra kết quả.

Nếu đổi tên repository hiện tại, cập nhật địa chỉ remote trong bản sao trên máy:

```powershell
git remote set-url origin https://github.com/GabTommy2006/GabTommy2006.git
```

## Cá nhân hóa tiếp

- Thêm ngành học hoặc công việc và phần giới thiệu ngắn.
- Thêm những công nghệ bạn thực sự sử dụng.
- Gắn liên kết tới 2–3 dự án tiêu biểu cùng mô tả ngắn.
- Chỉ thêm email hoặc mạng xã hội nếu bạn muốn công khai.

Các ghi chú HTML trong README gợi ý vị trí bổ sung và không hiển thị trên GitHub.
