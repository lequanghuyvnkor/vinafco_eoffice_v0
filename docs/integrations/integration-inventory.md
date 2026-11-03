# Danh mục tích hợp cần khảo sát

**Trạng thái:** Chưa có thông tin nhà cung cấp hoặc sandbox được cấp. Mọi adapter và dữ liệu giả lập sau này chỉ phục vụ phát triển/kiểm thử, không chứng minh kết nối thật.

| Hệ thống | Mức hiện tại | Cần có để spike | Ranh giới cần giữ |
| --- | --- | --- | --- |
| Bravo | Chưa khảo sát | Phiên bản, chủ dữ liệu, tài liệu API/file, môi trường thử, mã mẫu và đầu mối | Không tự giả định REST; cần idempotency/đối soát và xác nhận ack |
| SSO/HR | Chưa khảo sát | IdP/HRIS cụ thể, giao thức, test tenant, nhóm/role và quy tắc thu hồi | Identity local chỉ dùng dev; chốt nguồn chuẩn trước sync |
| TMS/WMS | Chưa khảo sát | Tên hệ thống, API/SDK, mẫu dữ liệu và sandbox | Không coi nhập mẫu là đồng bộ |
| CA/HSM | Chưa khảo sát | Nhà cung cấp, SDK/API, chứng thư test, chính sách ký và người xác nhận | Chưa ký giao dịch thật; kiểm hash/version đầu vào và kết quả |
| Object storage | Chưa chọn | Hạ tầng đích, chính sách dữ liệu, credentials sandbox, retention/legal hold nếu cần | Chỉ kiểm backend thử sau khi môi trường được cấp |
| OCR | Chưa chọn | Dữ liệu được phép, nhà cung cấp hoặc thư viện, vị trí xử lý và dữ liệu mẫu | Kết quả trích xuất luôn chờ người xác nhận |

## Rào cản mở

Không có API spec, sandbox, tài khoản thử hoặc đầu mối hệ thống trong workspace hiện tại. Các điểm này cần cung cấp trước khi kiểm thử adapter thật. Khi chưa có, chỉ có thể xây contract/port và fixture tổng hợp; không thể đánh dấu tích hợp thành công.
