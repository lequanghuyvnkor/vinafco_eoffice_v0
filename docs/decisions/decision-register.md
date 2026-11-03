# Sổ quyết định E Office Vinafco

Trạng thái: bản làm việc, chưa được Vinafco xác nhận. Cập nhật người quyết định, ngày hiệu lực, lựa chọn và các feature bị ảnh hưởng trước khi đổi một mục thành baseline.

| Mã | Cần quyết định | Trạng thái | Chủ xử lý | Đầu vào còn thiếu | Mốc cần chốt | Phạm vi bị chặn |
| --- | --- | --- | --- | --- | --- | --- |
| QD-01 | Pháp nhân, quy trình ưu tiên, phạm vi pilot và thứ tự phân kỳ | Open | Chưa phân công | Chủ sản phẩm xác nhận danh sách và tiêu chí hoàn thành | Chưa thống nhất | Phạm vi, UAT, kế hoạch |
| QD-02 | Loại hồ sơ, chứng từ, hạn mức, ngoại lệ, người duyệt và cách ký theo pháp nhân | Open | Chưa phân công | Ma trận quy trình và thẩm quyền | Chưa thống nhất | Workflow, tài chính, chữ ký |
| QD-03 | Bravo: phiên bản, cách trao đổi, dữ liệu nhận, chống lặp và phản hồi | Open | Chưa phân công | Khảo sát Bravo và tài khoản thử | Chưa thống nhất | Adapter, kế toán, vận hành |
| QD-04 | SSO/HR, TMS/WMS, CA/HSM và mức duyệt trên mobile | Open | Chưa phân công | Nhà cung cấp, API/SDK và sandbox | Chưa thống nhất | Đăng nhập, nguồn nghiệp vụ, ký |
| QD-05 | Phân loại dữ liệu, thời hạn lưu, legal hold và quyền kiểm toán | Open | Chưa phân công | Chính sách được duyệt | Chưa thống nhất | Kho dữ liệu, export, retention |
| QD-06 | Hạ tầng, khối lượng, người dùng, hiệu năng, backup và vận hành | Open | Chưa phân công | Số liệu đo và lựa chọn triển khai | Chưa thống nhất | Sizing, NFR, chi phí |
| QD-07 | KPI, tiến độ dự án, xe/phòng/công tác và quan hệ với payroll | Open | Chưa phân công | Chủ nghiệp vụ và phạm vi ưu tiên | Chưa thống nhất | Phân hệ hành chính |

## Giả định chỉ dùng để dựng nền

- Hệ thống dùng modular monolith với API và web riêng trong một workspace; lựa chọn framework cần qua spike feat-002.
- Mọi fixture phát triển là dữ liệu tổng hợp. Chưa nhập dữ liệu người dùng hoặc bí mật môi trường thật.
- Tích hợp ngoài chưa được coi là sẵn sàng cho tới khi có API, sandbox và người xác nhận.
- Accent teal trong UI spec là phương án thiết kế đang chờ review thương hiệu, không phải quyết định nhận diện cuối.

Không dùng các giả định này để publish quy trình, ký giao dịch thật hoặc nghiệm thu nghiệp vụ.
