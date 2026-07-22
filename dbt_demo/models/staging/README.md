
## Staging thường thực hiện:

- Đổi tên cột.
- Ép kiểu dữ liệu.
- Chuẩn hóa chuỗi hoặc enum đơn giản.
- Loại các cột không cần thiết.
- Không join nhiều bảng.
- Không chứa logic nghiệp vụ tổng hợp phức tạp.

## Lưu ý:
Trong trường hợp muốn overwrite materialized của staging (mặc định là view đã cấu hình trong dbt_project.yml), ta thêm vào đầu file kiểu
```
{{
     config(
         materialized='table'
     )
}}
```
