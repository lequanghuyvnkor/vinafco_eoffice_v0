# ADR-0001: Stack ứng viên cho nền E Office

- Trạng thái: **Đề xuất, chưa được xác minh bằng spike chạy ứng dụng**.
- Ngày: 03/11/2026.
- Phạm vi: chọn nền web/API/database/worker để thử tiếp; không phải quyết định triển khai production.

## Bối cảnh

Kế hoạch đề xuất web React/Next.js, API NestJS, PostgreSQL và worker riêng. Môi trường hiện tại có Node.js `v24.15.0` và pnpm `11.25.0`. Chưa tìm thấy Docker, Podman, PostgreSQL client/server trong PATH. Package registry không trả kết quả trong lần dò phiên bản, nên chưa có lockfile hoặc bằng chứng cài dependency.

## Ứng viên

- Workspace TypeScript dùng pnpm; khóa phiên bản runtime/package manager trong cấu hình repo.
- Web: Next.js App Router.
- API: NestJS REST/OpenAPI, modular monolith.
- Database: PostgreSQL với migration SQL; worker bắt đầu từ outbox, chỉ thêm queue riêng sau khi spike chứng minh cần.
- Tệp: giao diện `StoragePort`; chọn backend sau khi có môi trường và yêu cầu triển khai.

Node.js 24.15.0 đáp ứng ngưỡng Next.js 20.9 và ngưỡng Nest CLI được tài liệu chính thức công bố tại ngày kiểm tra. Tài liệu tham khảo: [Next.js installation](https://nextjs.org/docs/app/getting-started/installation), [NestJS first steps](https://docs.nestjs.com/first-steps). Major PostgreSQL phải còn trong thời hạn hỗ trợ theo [chính sách phiên bản PostgreSQL](https://www.postgresql.org/support/versioning/).

## Bằng chứng và giới hạn

| Hạng mục | Kết quả | Bằng chứng |
| --- | --- | --- |
| Node.js | Có `v24.15.0` | Phiên shell của môi trường coding ngày 03/11/2026 |
| pnpm | Có `11.25.0` | Phiên shell của môi trường coding ngày 03/11/2026 |
| Docker/Podman | Không tìm thấy | `Get-Command` trên Windows |
| PostgreSQL local/client | Không tìm thấy | `Get-Command` trên Windows |
| Registry/dependency install | Chưa xác minh | Lệnh tra cứu registry không trả kết quả |
| Build Next.js/NestJS | Chưa chạy | Chưa cài dependencies |
| DB transaction, auth, upload | Chưa chạy | Cần runtime DB/storage và app scaffold |

Vì vậy stack vẫn là ứng viên. Chưa xác nhận phiên bản package cụ thể, khả năng build, giao dịch DB, auth, upload, hiệu năng, hay vận hành. Không dùng tài liệu này làm bằng chứng nghiệm thu feat-002.

## Quyết định kế tiếp

Khi registry và PostgreSQL khả dụng: khóa các phiên bản đang được hỗ trợ; scaffold tối thiểu web/API; xác minh build, giao dịch rollback/commit, kiểm soát quyền cơ bản và upload qua StoragePort; lưu lệnh/kết quả. Sau đó cập nhật ADR thành `Accepted` hoặc ghi lựa chọn khác cùng căn cứ.
