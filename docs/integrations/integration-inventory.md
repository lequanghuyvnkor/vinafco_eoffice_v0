# Danh mục tích hợp cần khảo sát

**Trạng thái:** Chưa có thông tin nhà cung cấp hoặc sandbox được cấp. Bộ fixture tĩnh đã được chuẩn bị tại [`tests/fixtures/integrations/`](../../tests/fixtures/integrations/); chúng chỉ phục vụ phát triển/kiểm thử, không chứng minh kết nối thật.

| Hệ thống | Mức hiện tại | Cần có để spike | Ranh giới cần giữ |
| --- | --- | --- | --- |
| Bravo | Chưa khảo sát; có fixture JSON | Phiên bản, chủ dữ liệu, tài liệu API/file, môi trường thử, mã mẫu và đầu mối | Không tự giả định REST; ack trong fixture là mô phỏng; cần idempotency/đối soát thật |
| SSO/HR | Chưa khảo sát; có fixture JSON | IdP/HRIS cụ thể, giao thức, test tenant, nhóm/role và quy tắc thu hồi | Identity fixture chỉ dùng dev/test; chốt nguồn chuẩn trước sync |
| TMS/WMS | Chưa khảo sát; có fixture JSON | Tên hệ thống, API/SDK, mẫu dữ liệu và sandbox | Fixture không phải đồng bộ nguồn |
| CA/HSM | Chưa khảo sát; có fixture JSON | Nhà cung cấp, SDK/API, chứng thư test, chính sách ký và người xác nhận | Không có chữ ký/chứng thư thật; kiểm hash/version đầu vào và kết quả trên sandbox |
| Object storage | Chưa chọn | Hạ tầng đích, chính sách dữ liệu, credentials sandbox, retention/legal hold nếu cần | Chỉ kiểm backend thử sau khi môi trường được cấp |
| OCR | Chưa chọn | Dữ liệu được phép, nhà cung cấp hoặc thư viện, vị trí xử lý và dữ liệu mẫu | Kết quả trích xuất luôn chờ người xác nhận |

## Rào cản mở

Không có API spec, sandbox, tài khoản thử hoặc đầu mối hệ thống trong workspace hiện tại. Các điểm này cần cung cấp trước khi kiểm thử adapter thật. Fixture giúp phát triển trạng thái UI và luồng lỗi, nhưng không thể đánh dấu tích hợp thành công.
