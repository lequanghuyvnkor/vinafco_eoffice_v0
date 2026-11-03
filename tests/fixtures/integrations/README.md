# Bộ dữ liệu mô phỏng tích hợp

Toàn bộ bản ghi ở thư mục này là dữ liệu tổng hợp, viết để phát triển UI, API contract và kiểm thử. Không dùng tên, mã số thuế, tài khoản, email thật; email dùng miền `.invalid`. Không có URL dịch vụ, token, khóa riêng, chứng thư thật hay dữ liệu doanh nghiệp Vinafco.

## Quy ước bắt buộc

- Mọi file mang `datasetType: "synthetic-integration-fixture"`, `isSimulation: true` và `simulationOnly: true`.
- Các kết quả nguồn có tiền tố `simulated-`. Chúng chỉ mô tả kịch bản, không phải ack, trạng thái ký, hạch toán hay kết nối thật.
- Thời điểm được cố định ở UTC để kết quả dùng lại ổn định; không chứa credential hoặc endpoint để gửi ra ngoài.
- Tiền biểu diễn bằng chuỗi thập phân và currency code; không dùng số thực nhị phân.
- Chỉ tạo/sử dụng trong môi trường development/test. Không import vào production.

## Tệp

| Tệp | Nội dung |
| --- | --- |
| `scenario-catalog.json` | Pháp nhân và người dùng giả, context vai trò, kịch bản và trạng thái bao phủ |
| `sso-hr.json` | Đồng bộ nhân sự, đổi đơn vị, nghỉ việc/thu hồi, người có hai vai trò và lỗi dữ liệu |
| `tms-wms.json` | Chuyến hoàn tất, thiếu nghiệm thu, sửa revision và truy vấn không rõ kết quả |
| `bravo.json` | Bản ghi gửi mô phỏng, ack giả, timeout chưa rõ, mã trùng, từ chối và đối soát lệch |
| `ca-hsm.json` | Yêu cầu ký giả, chờ xác thực, mô phỏng hoàn tất/lỗi, sai hash và chứng thư hết hạn |

Đọc từng `expectedHandling` để dựng trạng thái UI. Ví dụ `simulated-acknowledged` không được chuyển thành `paid` hoặc `posted`; `simulated-signature-produced` không được coi là ký số hợp lệ.

## Giới hạn

Các tệp này là fixture tĩnh, không gọi adapter, không ký, không gửi giao dịch và không thay thế hợp đồng tích hợp. Khi có API spec/sandbox thật, tạo bộ dữ liệu riêng đã được chủ hệ thống cho phép, không sửa nhãn của fixture này để giả thành kết quả thật.
