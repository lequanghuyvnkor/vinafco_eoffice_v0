# Backlog coding E Office Vinafco

Cập nhật UI ngày 02/11/2026. Có 86 công việc đề xuất, toàn bộ chưa bắt đầu. Giữ ID feat-001 đến feat-080; bổ sung feat-081 đến feat-086 và xếp chúng theo dependency/phase.

Dùng [kế hoạch tổng thể](./IMPLEMENTATION_PLAN_VI.md), [đặc tả UI thay thế](../design/thiet_ke_san_pham_eoffice_vinafco.md) và [JSON](./feature_list.proposed.json). UI-* trỏ tới mục tương ứng trong UI spec; BRAND-MOODBOARD là PDF nguồn, STAGESHOW là skill gốc. Thiết kế cũ không còn làm nguồn.

Đường dẫn và lệnh kiểm tra là dự kiến. Evidence/commit để trống; ngày công chưa gồm chờ nhà cung cấp. Cần review trực quan thực tế để nghiệm thu UI.

## Danh mục theo giai đoạn

| Giai đoạn | Feature | Số việc | Ngày công dự kiến | Đầu ra |
| --- | --- | --- | --- | --- |
| P0 | feat-001 đến feat-006, feat-081, feat-082 | 8 | 8,5–17 | Khởi tạo harness và thiết kế UI |
| P1 | feat-007 đến feat-018, feat-083 | 13 | 21–37 | Tổ chức quyền và tài liệu nền |
| P2 | feat-019 đến feat-034 | 16 | 31–57 | Biểu mẫu quy trình và pilot |
| P3 | feat-035 đến feat-049 | 15 | 32–61 | Tài chính hợp đồng và Bravo |
| P4 | feat-050 đến feat-059 | 10 | 20–37,5 | Kho dữ liệu và kiểm toán |
| P5 | feat-060 đến feat-066, feat-084 | 8 | 14,5–29 | Mobile và responsive |
| P6 | feat-067 đến feat-073 | 7 | 13,5–26 | Văn bản công việc và tiện ích |
| P7 | feat-074 đến feat-080, feat-085, feat-086 | 9 | 19–36,5 | Review UI demo và phát hành |
| Tổng | 86 feature giữ nguyên ID cũ và thêm feat-081 đến feat-086 | 86 | 159,5–301 | Toàn bộ phạm vi đề xuất |

## P0 Khởi tạo harness và thiết kế UI

### feat-001 Chốt phạm vi và sổ quyết định

Lập danh mục quy trình, pháp nhân pilot, chủ nghiệp vụ và sổ quyết định. Giữ riêng điều đã xác nhận, giả định và nội dung cần khảo sát.

- Phụ thuộc: Không có.
- Nguồn: QD-01, QD-02, QD-03, QD-04, QD-05, QD-06, QD-07.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `docs/requirements/`, `docs/decisions/`, `scripts/verify-decisions.ps1`.
- Ước lượng: 0,5–1 ngày công.

Tiêu chí nghiệm thu:

1. Mỗi QD có chủ xử lý, đầu vào, mốc cần chốt và phạm vi bị chặn.
2. Phạm vi pilot có danh sách chức năng và tiêu chí ra khỏi pilot; giả định không tự chuyển thành baseline.

Kiểm tra dự kiến: `powershell -File ./scripts/verify-decisions.ps1`.
Tạo cùng feature: kiểm đủ QD, owner, trạng thái, đầu vào và phạm vi pilot; kết hợp review nội dung của BA.

### feat-002 Thử nghiệm kỹ thuật và hợp đồng kết nối

Chọn phiên bản công cụ bằng thử nghiệm nhỏ; kiểm tra giao dịch DB, xác thực, upload và build. Lập inventory API Bravo, SSO, TMS/WMS, CA/HSM cùng phương án sandbox và dữ liệu mẫu.

- Phụ thuộc: feat-001.
- Nguồn: INT-01, INT-04, QD-03, QD-04, QD-06.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `docs/architecture/`, `docs/integrations/`, `spikes/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. ADR ghi stack và phiên bản đã chạy thử, cách triển khai và các giới hạn đã biết.
2. Mỗi hệ thống ngoài có mức tích hợp, đầu mối và trạng thái khảo sát; thiếu API được ghi rõ, không coi mock là kết nối thành công.

Kiểm tra dự kiến: `powershell -File ./spikes/verify-stack.ps1`.
Tạo cùng spike; lưu kết quả thử stack và inventory kết nối, phân biệt verified với unavailable.

### feat-003 Khởi tạo monorepo và môi trường phát triển

Tạo web, API, worker, thư viện hợp đồng API, migration DB và cấu hình môi trường. Dựng dịch vụ local bằng dữ liệu giả lập và khóa phiên bản dependency.

- Phụ thuộc: feat-002.
- Nguồn: NFR-01, NFR-04.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `apps/web/`, `apps/api/`, `apps/worker/`, `packages/`, `infra/`, `package.json`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Fresh checkout khởi động được theo README, health/readiness phản ánh đúng trạng thái DB và storage.
2. Có migration đầu tiên, seed riêng cho dev/test, mẫu biến môi trường không chứa bí mật và build tái lập.

Kiểm tra dự kiến: `pnpm verify:bootstrap`.
Tạo script này trong feat-003: build, khởi động local và smoke health bằng dữ liệu thử, trước khi chuẩn hóa runner ở feat-004.

### feat-004 Chuẩn hóa harness và cổng xác minh

Đưa harness đã điều chỉnh vào dự án khi bắt đầu code; dùng duy nhất AGENTS.md và feature_list.json. Sửa bắt lỗi native command, kiểm tra bắt buộc và bộ kiểm tra đồ thị phụ thuộc.

- Phụ thuộc: feat-003.
- Nguồn: HARNESS.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `AGENTS.md`, `feature_list.json`, `feature_list.schema.json`, `init.ps1`, `init.sh`, `scripts/verify-harness/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Lệnh giả lập exit 1 khiến cả runner PowerShell và Bash thất bại; thiếu manifest hoặc script bắt buộc không báo PASS.
2. Validator bắt ID trùng, dependency thiếu/vòng, nhiều feature đang làm và done thiếu evidence; progress ban đầu ghi NOT RUN.

Kiểm tra dự kiến: `powershell -ExecutionPolicy Bypass -File ./init.ps1`.
Dùng kiểm tra thật đã có từ feat-003; bổ sung kiểm runner thất bại đúng. Feat-005 mở rộng nền kiểm thử và dispatcher theo feature.

### feat-005 Dữ liệu mẫu và nền kiểm thử

Tạo fixture hai pháp nhân, người kiêm nhiệm, ủy quyền, hồ sơ, tài liệu và lỗi tích hợp. Thiết lập kiểm thử unit, DB integration, API contract và hành trình trình duyệt.

- Phụ thuộc: feat-003, feat-004.
- Nguồn: AUTH-01, NFR-01, UAT-01, UAT-02, UAT-03, UAT-04, UAT-05, UAT-06.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `tests/fixtures/`, `tests/integration/`, `tests/e2e/`, `scripts/verify-feature/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Fixture sinh lặp được, không dùng dữ liệu thật và bao gồm hồ sơ ngoài quyền.
2. CI chạy được một kiểm thử thật ở mỗi tầng cần thiết; không dùng test rỗng làm bằng chứng.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-005`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-006 Design tokens và khung ứng dụng

Xây token và AppShell theo docs/design/thiet_ke_san_pham_eoffice_vinafco.md: nền sáng, navigation biển sâu, accent sản phẩm teal đề xuất; typography và nhịp spacing từ moodboard. Không đưa địa hình/mặt cắt của công ty mẹ vào UI sản phẩm.

- Phụ thuộc: feat-003, feat-005, feat-081.
- Nguồn: BRAND-MOODBOARD, UI-TOKENS, STAGESHOW, UI-SHELL.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `packages/ui/`, `packages/design-tokens/`, `apps/web/src/app/`, `docs/design/ui.tokens.json`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Tokens phân biệt màu nguồn của công ty và accent sản phẩm đề xuất; component có chữ tiếng Việt, focus, khoảng cách và trạng thái tương tác rõ ràng.
2. Shell desktop/mobile có bộ chọn vai trò/pháp nhân luôn nhận biết được; tài liệu vẫn đọc trên nền trắng, không thu nhỏ cả desktop xuống điện thoại.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-006`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-081 Sitemap và luồng UI theo vai trò

Thiết kế điều hướng, context và luồng inbox → bản trình → quyết định cho người lập, người duyệt, kế toán và quản trị.

- Phụ thuộc: feat-002, feat-005.
- Nguồn: UI-SHELL, WF-04, MOB-02.
- Điều kiện xác nhận: QD-01, QD-02.
- Vùng code dự kiến: `docs/design/flows/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Sitemap và user flow ghi rõ đích đến, đường quay lại, scope vai trò/pháp nhân và hành động chính.
2. Review luồng bằng các tình huống SRS; menu ngoài quyền không xuất hiện và context luôn thấy trước quyết định.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-081`.
Lệnh tự động kiểm phần có thể kiểm; UI review cần ảnh và biên bản quan sát thật, không coi build pass là UI đã đạt.

### feat-082 Review bố cục bốn màn hình trọng tâm

Dựng bản review dùng fixture cho inbox, hồ sơ tổng hợp, đối soát và chi tiết duyệt mobile; giữ context, căn cứ và action rõ ràng.

- Phụ thuộc: feat-006, feat-081.
- Nguồn: UI-INBOX, UI-DOSSIER, UI-MATCH, UI-MOBILE.
- Điều kiện xác nhận: QD-01.
- Vùng code dự kiến: `docs/design/reviews/`, `apps/web/src/features/ui-preview/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Có hình/bản xem ở 1440 và 390px với dữ liệu tiếng Việt thực tế, tên dài và số tiền lớn; dùng cùng tokens.
2. Review đủ pending, thiếu dữ liệu, stale revision và thao tác mất mạng; người review xác nhận luồng trước triển khai inbox.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-082`.
Lệnh tự động kiểm phần có thể kiểm; UI review cần ảnh và biên bản quan sát thật, không coi build pass là UI đã đạt.


## P1 Tổ chức quyền và tài liệu nền

### feat-007 Cơ cấu tổ chức và vai trò có hiệu lực

Mô hình hóa pháp nhân, đơn vị, người, quan hệ cấp trên và role assignment theo khoảng thời gian; cung cấp màn hình quản trị cơ cấu.

- Phụ thuộc: feat-005, feat-006.
- Nguồn: ORG-01.
- Điều kiện xác nhận: QD-01.
- Vùng code dự kiến: `apps/api/src/modules/organization/`, `apps/web/src/features/organization/`, `packages/database/migrations/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Một người có hai vai trò ở hai pháp nhân và chuyển ngữ cảnh rõ ràng.
2. Không tạo cây vòng; thay cơ cấu có hiệu lực và lưu lịch sử.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-007`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-008 Đăng nhập SSO và thu hồi phiên

Tích hợp nguồn định danh được chọn qua adapter; quản lý phiên, logout, MFA theo khả năng IdP và vô hiệu hóa tài khoản. Đăng nhập giả chỉ tồn tại ở dev/test.

- Phụ thuộc: feat-007.
- Nguồn: NFR-02, MOB-05.
- Điều kiện xác nhận: QD-04, QD-06.
- Vùng code dự kiến: `apps/api/src/modules/identity/`, `apps/web/src/features/auth/`.
- Ước lượng: 2–3 ngày công.

Tiêu chí nghiệm thu:

1. Luồng đăng nhập thật chạy trên sandbox IdP và từ chối token sai audience/issuer/hết hạn.
2. Khóa tài khoản hoặc thu hồi phiên ngăn request tiếp theo trong ngưỡng đã chốt; không còn dev login trong cấu hình production.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-008`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-009 Phân quyền tập trung và cô lập dữ liệu

Xây policy service theo vai trò, phạm vi, hành động, độ mật, hạn mức và hiệu lực; áp dụng cho API/repository. Thử nghiệm RLS ở các bảng nhạy cảm và đường đi của worker.

- Phụ thuộc: feat-007, feat-008.
- Nguồn: AUTH-01, NFR-01.
- Điều kiện xác nhận: QD-02, QD-05.
- Vùng code dự kiến: `apps/api/src/modules/authorization/`, `packages/database/policies/`, `tests/security/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. List/detail/count/export/download và truy cập ID trực tiếp đều từ chối ngoài quyền.
2. DB application role không có quyền bypass; connection pool không giữ ngữ cảnh pháp nhân của request trước.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-009`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-010 Ủy quyền và kiểm tra thẩm quyền tại giao dịch

Quản lý căn cứ, thời gian, hạn mức, phạm vi và thu hồi ủy quyền. Kiểm tra lại thẩm quyền trong transaction khi thực hiện quyết định.

- Phụ thuộc: feat-009.
- Nguồn: AUTH-02.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/authority/`, `apps/web/src/features/delegations/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Ủy quyền hết hạn hoặc bị thu hồi sau khi mở màn hình khiến thao tác duyệt thất bại.
2. Lịch sử giữ người thực hiện thực tế, người giao quyền và căn cứ tại thời điểm quyết định.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-010`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-011 Nhật ký nghiệp vụ và truy cập

Ghi audit có actor, phạm vi, đối tượng, phiên bản, kết quả và correlation ID; bổ sung log xem/tải, đổi quyền và tích hợp. Giới hạn quyền sửa/xóa log.

- Phụ thuộc: feat-009.
- Nguồn: AUD-01, NFR-04.
- Điều kiện xác nhận: QD-05.
- Vùng code dự kiến: `apps/api/src/modules/audit/`, `packages/database/migrations/`, `apps/web/src/features/audit/`.
- Ước lượng: 1,5–2,5 ngày công.

Tiêu chí nghiệm thu:

1. Một hồ sơ truy ra được chuỗi sự kiện thành công và thất bại; truy cập audit cũng có kiểm soát.
2. Log không chứa token/bí mật; audit nghiệp vụ quan trọng được ghi cùng transaction hoặc cơ chế bền vững tương đương.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-011`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-012 Nhận tệp và lưu bản gốc an toàn

Upload qua vùng cách ly, kiểm MIME/kích thước, quét tệp theo hạ tầng, tính SHA-256 và lưu object version. Tạo StoragePort để thay nhà cung cấp.

- Phụ thuộc: feat-009, feat-011.
- Nguồn: DMS-03, FIN-02, NFR-01.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `apps/api/src/modules/files/`, `apps/worker/src/jobs/file-inspection/`, `infra/storage/`.
- Ước lượng: 2–3 ngày công.

Tiêu chí nghiệm thu:

1. Tệp chưa qua kiểm tra không được phát hành; tên tệp hoặc MIME giả không vượt kiểm tra.
2. Bản gốc có object key/version, hash, nguồn và người nộp; tải lại luôn kiểm quyền và ghi log.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-012`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-013 Mẫu siêu dữ liệu có phiên bản

Khai báo trường metadata theo loại tài liệu, kiểu dữ liệu, điều kiện bắt buộc, danh mục nguồn, quyền sửa và trạng thái xác minh.

- Phụ thuộc: feat-012.
- Nguồn: DMS-02, CFG-01.
- Điều kiện xác nhận: QD-02, QD-05.
- Vùng code dự kiến: `apps/api/src/modules/metadata/`, `apps/web/src/features/metadata-admin/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Thiếu trường bắt buộc tạo hàng đợi bổ sung và chặn xuất bản theo quy tắc.
2. Sửa mẫu tạo phiên bản mới; tài liệu cũ vẫn hiển thị đúng mẫu gốc.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-013`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-014 Tài liệu phiên bản và tham chiếu

Tách Document, DocumentVersion, StoredObject và DocumentReference; hỗ trợ góc nhìn thư mục/nghiệp vụ, chủ sở hữu và tham chiếu đúng phiên bản.

- Phụ thuộc: feat-012, feat-013.
- Nguồn: DMS-01, DMS-04, DOS-01.
- Điều kiện xác nhận: QD-05.
- Vùng code dự kiến: `apps/api/src/modules/documents/`, `apps/web/src/features/documents/`.
- Ước lượng: 2–3 ngày công.

Tiêu chí nghiệm thu:

1. Một bản tài liệu phục vụ nhiều hồ sơ mà không nhân bản tệp; quyền không tự lan qua liên kết.
2. Tạo bản mới không ghi đè bản cũ hoặc bản đã ký; tra được nguồn và người sửa.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-014`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-015 Tra cứu metadata và xem tài liệu theo quyền

Tra cứu theo pháp nhân, loại, kỳ, đối tác và thư mục; tạo viewer/download gateway. Lọc quyền trước phân trang, đếm và trả metadata.

- Phụ thuộc: feat-009, feat-014.
- Nguồn: DMS-05, AUTH-01.
- Điều kiện xác nhận: QD-05.
- Vùng code dự kiến: `apps/api/src/modules/search/`, `apps/web/src/features/document-search/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Tài liệu ngoài quyền không xuất hiện qua kết quả, tổng số, gợi ý, preview hoặc URL tải.
2. Thu hồi quyền ngăn tải mới; cache được phân theo danh tính/phạm vi và vô hiệu hóa phù hợp.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-015`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-016 Danh mục đối tác và ánh xạ mã ngoài

Quản lý BusinessPartner và ExternalCodeMap theo nguồn, hiệu lực và trạng thái xác minh; hỗ trợ lịch sử gộp/tách có kiểm soát.

- Phụ thuộc: feat-007, feat-009, feat-011.
- Nguồn: DMS-06.
- Điều kiện xác nhận: QD-03, QD-04.
- Vùng code dự kiến: `apps/api/src/modules/master-data/`, `apps/web/src/features/partners/`.
- Ước lượng: 1,5–2,5 ngày công.

Tiêu chí nghiệm thu:

1. Mã Bravo và TMS của cùng đối tác được ánh xạ và truy nguyên người xác nhận.
2. Không dùng MST làm ID duy nhất cho mọi cá nhân/pháp nhân; gộp sai có quy trình điều chỉnh.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-016`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-017 Outbox hàng đợi và xử lý lặp

Ghi outbox cùng transaction nghiệp vụ; dispatch sang worker, inbox dedup, retry/backoff, dead-letter và operation ID. Phân biệt thất bại chắc chắn với kết quả chưa rõ.

- Phụ thuộc: feat-003, feat-011.
- Nguồn: INT-02, INT-01.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `apps/api/src/modules/integration-core/`, `apps/worker/src/`, `packages/database/migrations/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Dừng worker giữa commit và gửi không mất sự kiện; nhận lặp không tạo tác dụng phụ thứ hai.
2. Timeout sau khi nguồn có thể đã xử lý chuyển unknown/reconcile; không gửi lại mù với nguồn thiếu chống lặp.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-017`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-018 Thông báo và nhắc hạn

Tạo thông báo trong ứng dụng, lịch nhắc hạn, kênh email/push qua adapter và tùy chọn người dùng. Kiểm tra quyền người nhận khi phát và khi mở.

- Phụ thuộc: feat-009, feat-017.
- Nguồn: WF-02, MOB-01, NFR-04.
- Điều kiện xác nhận: QD-04.
- Vùng code dự kiến: `apps/api/src/modules/notifications/`, `apps/worker/src/jobs/reminders/`, `apps/web/src/features/notifications/`.
- Ước lượng: 1,5–2,5 ngày công.

Tiêu chí nghiệm thu:

1. Job chạy lặp không gửi trùng ngoài chính sách; người đã mất quyền không nhận dữ liệu nhạy cảm.
2. Thông báo dẫn tới đúng hồ sơ/phiên bản; lỗi phát có trạng thái và người vận hành truy được.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-018`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-083 Component UI và trạng thái dùng chung

Hoàn thiện StatusBadge, DocumentViewer, DiffPanel, AsyncOperationStatus, FormField và ApprovalActionBar; quy định status, error, empty, loading và thông báo truy cập.

- Phụ thuộc: feat-006, feat-005.
- Nguồn: UI-STATES, AUTH-01, MOB-03.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `packages/ui/`, `apps/web/src/features/ui-preview/`, `docs/design/states/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Ma trận trạng thái trong UI spec có ví dụ, nhãn và hành động khôi phục; không coi chờ nguồn hoặc unknown là thành công.
2. Field giữ dữ liệu khi lỗi; focus, keyboard và text status hoạt động; forbidden/search không lộ metadata đối tượng ngoài quyền.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-083`.
Lệnh tự động kiểm phần có thể kiểm; UI review cần ảnh và biên bản quan sát thật, không coi build pass là UI đã đạt.


## P2 Biểu mẫu quy trình và pilot

### feat-019 Runtime biểu mẫu có phiên bản

Render và validate biểu mẫu từ schema; hỗ trợ danh mục nguồn, điều kiện, công thức giới hạn và quyền từng bước. Tính toán lại ở máy chủ.

- Phụ thuộc: feat-013, feat-016, feat-083.
- Nguồn: WF-01, CFG-01.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/forms/`, `apps/web/src/features/form-runtime/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Hồ sơ lưu form_version và quy tắc; sửa schema không làm hỏng hồ sơ cũ.
2. Payload cố sửa trường chỉ đọc hoặc giả kết quả công thức bị máy chủ từ chối.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-019`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-020 Trình cấu hình và xuất bản biểu mẫu

Cung cấp editor theo danh sách trường, preview, kiểm tra schema, nháp và xuất bản phiên bản. Giới hạn công thức bằng DSL được kiểm tra, không chạy mã tùy ý.

- Phụ thuộc: feat-019.
- Nguồn: WF-01, CFG-01.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/web/src/features/form-builder/`, `apps/api/src/modules/forms/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Quản trị nghiệp vụ tạo một form mới mà không sửa source.
2. Form lỗi điều kiện vòng, kiểu dữ liệu hoặc thiếu nguồn không được publish; có lịch sử xuất bản.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-020`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-021 Định nghĩa và kiểm tra quy trình

Định nghĩa node, edge, điều kiện, người xử lý, timeout và join; có version publish và mô phỏng người nhận. Editor tối thiểu dạng cấu hình, chưa làm BPMN đầy đủ.

- Phụ thuộc: feat-019, feat-010.
- Nguồn: WF-02, CFG-01.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/workflows/definitions/`, `apps/web/src/features/workflow-admin/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Definition thiếu điểm bắt đầu/kết thúc, nhánh không đến đích hoặc join sai bị từ chối.
2. Mô phỏng theo số tiền/pháp nhân tìm đúng người nhận; phiên bản đang chạy không bị sửa ngầm.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-021`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-022 Thực thi quy trình tuần tự bền vững

Lưu WorkflowInstance, StepInstance, ApprovalTask và transitions trong DB; submit, resolve người duyệt và hoàn tất bước bằng transaction có kiểm soát phiên bản.

- Phụ thuộc: feat-021, feat-017, feat-011.
- Nguồn: WF-02, WF-04.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/workflows/runtime/`, `tests/integration/workflows/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Khởi động lại API/worker không mất bước đang chờ.
2. Hai request cạnh tranh chỉ hoàn tất một lần và sinh đúng bước kế tiếp.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-022`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-023 Nhánh song song và rẽ nhánh điều kiện

Bổ sung fork/join theo policy, nhánh theo hạn mức và lịch nhắc/quá hạn. Ghi lý do chọn nhánh và dữ liệu quy tắc đầu vào.

- Phụ thuộc: feat-022.
- Nguồn: WF-02.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/workflows/runtime/`, `apps/worker/src/jobs/workflow-deadlines/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Luồng hai phòng kiểm tra chỉ đi tiếp khi đúng điều kiện join; callback lặp không đếm hai lần.
2. Đổi số tiền dẫn tới nhánh đúng; thiếu người nhận vào hàng chờ xử lý, không tự bỏ bước.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-023`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-024 Hồ sơ tổng hợp và liên kết nguồn

Tạo mã hồ sơ, loại, chủ sở hữu, kỳ, trạng thái và CaseLink tới quy trình/tài liệu/hệ thống ngoài. Xây danh sách, timeline và trang chi tiết hồ sơ.

- Phụ thuộc: feat-014, feat-022.
- Nguồn: DOS-01, FIN-01.
- Điều kiện xác nhận: QD-01, QD-02.
- Vùng code dự kiến: `apps/api/src/modules/dossiers/`, `apps/web/src/features/dossiers/`.
- Ước lượng: 2–3 ngày công.

Tiêu chí nghiệm thu:

1. Tra theo mã hồ sơ, chuyến hoặc hợp đồng tới đúng nguồn có quyền.
2. Một hồ sơ chứa nhiều quy trình con; tham chiếu không nhân bản tài liệu hoặc mở rộng quyền.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-024`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-025 Bảng quy tắc theo loại hồ sơ và pháp nhân

Cấu hình chứng từ bắt buộc, hạn mức, người kiểm tra, loại xác nhận, ngoại lệ và SLA theo loại việc. Publish phiên bản gắn vào hồ sơ khi trình.

- Phụ thuộc: feat-024, feat-019, feat-010.
- Nguồn: CFG-01, WF-01, SIG-01.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/business-rules/`, `apps/web/src/features/rule-admin/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Cùng khoản tiền ở hai pháp nhân có thể có chuỗi duyệt/chứng từ khác nhau.
2. Đổi rule chỉ tác động hồ sơ mới; chuyển phiên bản hồ sơ cũ là thao tác riêng có audit.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-025`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-026 Hộp duyệt và quyết định có snapshot

Xây inbox, chi tiết bản trình và API quyết định. Lưu snapshot, người thực hiện, thẩm quyền, ý kiến và operation ID trong transaction.

- Phụ thuộc: feat-023, feat-024, feat-025, feat-018, feat-083, feat-082.
- Nguồn: WF-04, AUTH-02, MOB-02.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/approvals/`, `apps/web/src/features/approval-inbox/`.
- Ước lượng: 2–3 ngày công.

Tiêu chí nghiệm thu:

1. Người duyệt xem đúng bản dữ liệu/tài liệu được gắn vào quyết định.
2. Nhấn hai lần hoặc retry cùng operation ID trả cùng kết quả; request sai snapshot hoặc hết quyền không duyệt được.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-026`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-027 Vô hiệu hóa phê duyệt khi thay đổi trọng yếu

Phân loại trường trọng yếu và diff; tăng revision, thu hồi task cũ, đánh dấu quyết định bị thay thế và khởi tạo trình lại theo policy.

- Phụ thuộc: feat-026.
- Nguồn: WF-05, MOB-04.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/approvals/`, `apps/web/src/features/dossier-diff/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Đổi số tiền, đối tác, thụ hưởng hoặc hóa đơn khiến nút duyệt bản cũ trả lỗi STALE_SNAPSHOT.
2. Giữ được chuỗi trước/sau và so sánh thay đổi; giao dịch đổi dữ liệu cạnh tranh với duyệt không tạo bản duyệt sai.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-027`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-028 Trả lại rút trình và đổi người xử lý

Xử lý yêu cầu bổ sung, từ chối, rút trình và reassign theo quyền; bảo toàn lịch sử và sinh lại task khi trình lại.

- Phụ thuộc: feat-027.
- Nguồn: WF-02, WF-04.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/workflows/actions/`, `apps/web/src/features/approval-actions/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Rút trình hoặc trả lại đóng đúng task và không để người cũ duyệt được.
2. Đổi người xử lý có căn cứ/audit, không xóa ý kiến cũ và không vượt thẩm quyền.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-028`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-029 Điều phối quy trình con

Kích hoạt quy trình con từ kết quả quy trình trước; cấu hình dữ liệu kế thừa, điều kiện chờ và xử lý phụ thuộc khi hủy/lỗi.

- Phụ thuộc: feat-024, feat-028, feat-017.
- Nguồn: WF-03, FIN-01.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/dossier-orchestration/`, `apps/worker/src/jobs/dossier-events/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Sự kiện hoàn tất mua sắm chỉ tạo một bước hợp đồng hoặc việc kế tiếp với dữ liệu đã xác nhận.
2. Hủy quy trình nguồn cảnh báo hồ sơ phụ thuộc và yêu cầu xử lý theo policy; không tự xóa chứng từ đã chốt.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-029`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-030 Duyệt trên web điện thoại

Hoàn thiện inbox và chi tiết responsive cho pilot; hiển thị trạng thái gửi/xác nhận/lỗi và tra operation khi mất kết nối.

- Phụ thuộc: feat-026, feat-027, feat-006.
- Nguồn: MOB-01, MOB-02, MOB-03, MOB-05.
- Điều kiện xác nhận: QD-01.
- Vùng code dự kiến: `apps/web/src/features/mobile-approval/`, `apps/web/src/features/approval-inbox/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Điện thoại xem được tài liệu, cảnh báo, lịch sử và đúng bản trình trước khi duyệt.
2. Mất mạng sau bấm duyệt không hiển thị hoàn tất giả; không thực hiện quyết định offline.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-030`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-031 Phân loại chữ ký và bằng chứng nội bộ

Tách xác nhận người lập, ý kiến kiểm tra, phê duyệt nội bộ, ký điện tử và ký số thành hành vi có bằng chứng riêng.

- Phụ thuộc: feat-025, feat-026.
- Nguồn: SIG-01.
- Điều kiện xác nhận: QD-02, QD-04.
- Vùng code dự kiến: `apps/api/src/modules/signatures/policies/`, `apps/web/src/features/signature-evidence/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Tờ trình nội bộ và công văn ban hành có policy ký khác nhau.
2. Ảnh chữ ký hoặc animation con dấu không được ghi là kết quả ký số đã xác minh.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-031`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-032 Ký số qua nhà cung cấp và xác minh kết quả

Triển khai SignatureProviderPort với nhà cung cấp được chọn; khóa hash phiên bản đầu vào, xử lý yêu cầu/callback, xác minh và lưu artifact đã ký riêng.

- Phụ thuộc: feat-031, feat-014, feat-017.
- Nguồn: SIG-02, INT-01, INT-02.
- Điều kiện xác nhận: QD-02, QD-04.
- Vùng code dự kiến: `apps/api/src/modules/signatures/providers/`, `apps/worker/src/jobs/signatures/`, `docs/integrations/signing/`.
- Ước lượng: 3–6 ngày công.

Tiêu chí nghiệm thu:

1. Sandbox nhà cung cấp trả tài liệu ký thật và kết quả xác minh, chứng thư, thời điểm, người ký/căn cứ.
2. Callback giả/lặp hoặc bản gốc đã thay đổi không được ghi hoàn tất; kết quả chưa rõ được đối soát.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-032`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-033 Chốt hồ sơ khóa kỳ và điều chỉnh

Tạo snapshot danh mục, phiên bản tài liệu, quyết định và trạng thái ký; triển khai khóa kỳ, phụ lục/điều chỉnh và quan hệ thay thế.

- Phụ thuộc: feat-029, feat-027, feat-031, feat-014.
- Nguồn: DOS-02, DOS-03.
- Điều kiện xác nhận: QD-02, QD-05.
- Vùng code dự kiến: `apps/api/src/modules/dossiers/snapshots/`, `apps/web/src/features/dossier-close/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Chỉ hoàn tất khi đủ kết quả bắt buộc theo policy; bản snapshot truy được chính xác sau khi tài liệu phát sinh phiên bản mới.
2. Sau khóa chỉ bổ sung bằng điều chỉnh có người chấp thuận và căn cứ; bản chốt không bị ghi đè.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-033`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-034 Nghiệm thu pilot trình duyệt hồ sơ

Chạy pilot tờ trình nội bộ trong phạm vi pháp nhân/quy trình đã chọn, gồm rẽ nhánh, song song, ủy quyền và thay đổi bản trình. Đây là nghiệm thu một phần UAT, trước luồng tài chính và native mobile.

- Phụ thuộc: feat-020, feat-030, feat-033.
- Nguồn: UAT-02, UAT-04, WF-01, WF-02, WF-03, WF-04, WF-05.
- Điều kiện xác nhận: QD-01, QD-02.
- Vùng code dự kiến: `tests/e2e/pilot/`, `docs/uat/pilot/`, `docs/runbooks/pilot/`.
- Ước lượng: 2–3 ngày công.

Tiêu chí nghiệm thu:

1. Chủ nghiệp vụ ký nhận các tình huống pilot, người dùng thực hiện lại được theo hướng dẫn.
2. Báo cáo nêu rõ phần UAT-02/UAT-04 còn chờ tài chính, mobile native hoặc CA; không gọi là nghiệm thu toàn bộ SRS.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-034`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.


## P3 Tài chính hợp đồng và Bravo

### feat-035 Hợp đồng và phụ lục

Quản lý chủ trì, đối tác, giá trị, hiệu lực, rà soát, ký, phụ lục và gia hạn; gắn hợp đồng khung vào nhiều hồ sơ.

- Phụ thuộc: feat-014, feat-029, feat-016.
- Nguồn: CON-01, DMS-04, FIN-01.
- Điều kiện xác nhận: QD-02, QD-04.
- Vùng code dự kiến: `apps/api/src/modules/contracts/`, `apps/web/src/features/contracts/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Một hợp đồng khung dùng cho nhiều hồ sơ có quyền và phân biệt ký nội bộ/đối tác.
2. Phụ lục không sửa bản ký; hợp đồng hết hiệu lực cảnh báo các hồ sơ liên quan.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-035`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-036 Hồ sơ tài chính theo loại giao dịch

Cấu hình các luồng thanh toán, tạm ứng, hoàn ứng, nhiều đợt, dịch vụ không PO và chứng từ đến muộn; liên kết kết quả quy trình theo hồ sơ tổng hợp.

- Phụ thuộc: feat-024, feat-025, feat-035.
- Nguồn: FIN-01, FIN-05, FIN-07.
- Điều kiện xác nhận: QD-02, QD-03.
- Vùng code dự kiến: `apps/api/src/modules/finance/dossiers/`, `apps/web/src/features/finance-dossiers/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Mỗi loại giao dịch dùng đúng ma trận chứng từ/ngoại lệ; không ép có PO/hợp đồng cho mọi trường hợp.
2. Theo mã hồ sơ truy được đề xuất, hợp đồng, chứng từ, yêu cầu thanh toán và tham chiếu Bravo.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-036`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-037 Tiếp nhận và phân tích hóa đơn XML

Giữ nguyên byte hóa đơn gốc; parser XML theo phiên bản mẫu được khảo sát, tắt thực thể ngoài và giới hạn tài nguyên. Tách parsing, kiểm tra toàn vẹn và xác minh chữ ký hóa đơn.

- Phụ thuộc: feat-012, feat-016, feat-036.
- Nguồn: FIN-02, FIN-03, UI-MATCH, UI-EXTRACTION.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/finance/invoices/`, `apps/worker/src/jobs/invoice-parsing/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Có trường hóa đơn kèm nguồn và trạng thái xác minh; XML lỗi/thiếu hoặc chỉ PDF được phân loại rõ.
2. Tệp có XXE hoặc cấu trúc vượt giới hạn bị chặn; parse thành công không tự đồng nghĩa chữ ký/giá trị pháp lý hợp lệ.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-037`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-038 OCR và xác nhận dữ liệu trích xuất

Tích hợp OCR qua port, lưu vùng nguồn và confidence; cung cấp giao diện so sánh tài liệu với trường trích xuất và chỉnh có audit.

- Phụ thuộc: feat-037, feat-017.
- Nguồn: FIN-03.
- Điều kiện xác nhận: QD-02, QD-06.
- Vùng code dự kiến: `apps/api/src/modules/extraction/`, `apps/worker/src/jobs/ocr/`, `apps/web/src/features/extraction-review/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. MST OCR sai được sửa có giá trị trước/sau, người sửa và thời gian.
2. Trường chưa xác nhận không làm đầu vào phê duyệt tự động; lỗi OCR có hàng chờ xử lý thủ công.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-038`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-039 Chống trùng hóa đơn và quan hệ điều chỉnh

Chuẩn hóa khóa nghiệp vụ theo ma trận được chốt; phân biệt nháp, nghi trùng, hủy, thay thế và điều chỉnh. Dùng constraint/locking để chống hai lần nhập cạnh tranh.

- Phụ thuộc: feat-037, feat-009.
- Nguồn: FIN-06.
- Điều kiện xác nhận: QD-02, QD-05.
- Vùng code dự kiến: `apps/api/src/modules/finance/invoice-identity/`, `packages/database/migrations/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Cùng hóa đơn nhập đồng thời không tạo hai bản chính; file khác hash vẫn có thể bị phát hiện trùng nghiệp vụ.
2. Cảnh báo trùng ngoài quyền không lộ tên, số tiền hoặc mã hồ sơ khác; người có thẩm quyền xử lý được nghi trùng.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-039`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-040 Nguồn nghiệm thu chuyến và dịch vụ

Chuẩn hóa dữ liệu nghiệm thu, chuyến, kho/dịch vụ từ TMS/WMS hoặc nhập được xác nhận; giữ ID nguồn, thời điểm và phiên bản chứng cứ.

- Phụ thuộc: feat-036, feat-017, feat-016.
- Nguồn: FIN-04, INT-01, INT-04.
- Điều kiện xác nhận: QD-02, QD-04.
- Vùng code dự kiến: `apps/api/src/modules/operations-evidence/`, `apps/api/src/adapters/tms-wms/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Dữ liệu nguồn có trạng thái xác nhận/freshness và truy được bản chứng từ gốc.
2. Nguồn chưa có API dùng quy trình nhập/đối chiếu được phê duyệt; giao diện ghi đúng mức kết nối.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-040`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-041 Bộ đối soát có giải thích

Đối chiếu các trường áp dụng giữa hợp đồng/đơn mua, nghiệm thu, hóa đơn và yêu cầu thanh toán; lưu căn cứ, ngưỡng và phiên bản rule.

- Phụ thuộc: feat-035, feat-037, feat-040, feat-025, feat-083.
- Nguồn: FIN-04, UI-MATCH, UI-EXTRACTION.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/finance/matching/`, `apps/web/src/features/matching/`.
- Ước lượng: 3–5 ngày công.

Tiêu chí nghiệm thu:

1. Kết quả phân biệt khớp, trong ngưỡng, vượt ngưỡng, thiếu dữ liệu và không áp dụng; chỉ rõ trường/căn cứ.
2. Dịch vụ không PO không bị báo thiếu PO; có kiểm tra thủ công và không dùng nhãn 100% cho dữ liệu chưa xác nhận.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-041`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-042 Phân bổ hóa đơn và thanh toán nhiều đợt

Quản lý allocation theo dòng/chuyến, số dư hợp đồng/hóa đơn và yêu cầu thanh toán. Dùng số thập phân chính xác, currency và transaction kiểm tra giới hạn.

- Phụ thuộc: feat-036, feat-039, feat-041.
- Nguồn: FIN-05.
- Điều kiện xác nhận: QD-02, QD-03.
- Vùng code dự kiến: `apps/api/src/modules/finance/allocations/`, `apps/web/src/features/allocations/`.
- Ước lượng: 3–5 ngày công.

Tiêu chí nghiệm thu:

1. Tổng phân bổ/số dư đúng với thanh toán nhiều đợt, điều chỉnh và hai request đồng thời.
2. Số đã duyệt, đã chuyển Bravo và đã thanh toán được tách riêng, không cộng trùng hoặc suy diễn trạng thái chi.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-042`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-043 Phê duyệt ngoại lệ tài chính

Tạo yêu cầu ngoại lệ cho thiếu chứng từ/hợp đồng, vượt ngân sách hoặc sai lệch; quản lý lý do, chứng từ thay thế, người duyệt và thời hạn bổ sung.

- Phụ thuộc: feat-041, feat-042, feat-028.
- Nguồn: FIN-07.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/api/src/modules/finance/exceptions/`, `apps/web/src/features/finance-exceptions/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Ngoại lệ hợp lệ đi đúng cấp và hiện rõ căn cứ, không đổi nhãn thành hồ sơ đạt chuẩn.
2. Người không đủ quyền không bỏ qua kiểm tra; nghĩa vụ bổ sung còn tồn tại được theo dõi đến khi xử lý.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-043`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-044 Dữ liệu ngân sách và cảnh báo có nguồn

Nhận số liệu ngân sách từ nguồn hoặc bản nhập đã được duyệt; hiển thị kỳ, freshness và quy tắc kiểm tra. Chỉ bổ sung cơ chế giữ chỗ ngân sách nếu được chốt trong phạm vi.

- Phụ thuộc: feat-036, feat-042.
- Nguồn: FIN-07, MOB-02.
- Điều kiện xác nhận: QD-02, QD-03.
- Vùng code dự kiến: `apps/api/src/modules/finance/budget-context/`, `apps/web/src/features/budget-context/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Không có số liệu thì hiển thị chưa có dữ liệu, không tự sinh tỷ lệ ngân sách còn lại.
2. Mốc/kỳ và nguồn truy được; quy tắc vượt ngân sách dẫn tới chặn hoặc ngoại lệ đúng chính sách.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-044`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-045 Tích hợp chuyển hồ sơ sang Bravo

Triển khai adapter theo API, file trao đổi hoặc cơ chế Bravo thực tế hỗ trợ; gửi hồ sơ đã duyệt, nhận ack/số chứng từ và trạng thái. Chốt trách nhiệm vận hành với bên Bravo.

- Phụ thuộc: feat-017, feat-042, feat-043.
- Nguồn: FIN-08, INT-01, INT-02, INT-04.
- Điều kiện xác nhận: QD-03.
- Vùng code dự kiến: `apps/api/src/adapters/bravo/`, `apps/worker/src/jobs/bravo/`, `docs/integrations/bravo/`.
- Ước lượng: 3–6 ngày công.

Tiêu chí nghiệm thu:

1. Sandbox thật nhận đúng đối tượng nghiệp vụ, trả số chứng từ; bản đồ trường và mỗi chiều có test thành công/thất bại.
2. Replay không tạo chứng từ đôi; nếu nguồn thiếu chống lặp/tra cứu thì timeout chưa rõ chặn gửi lại và chuyển đối soát có người xử lý.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-045`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-046 Đối chiếu Bravo và bàn xử lý tích hợp

Đối chiếu số chứng từ, số tiền, trạng thái nhận/phê duyệt/thanh toán theo dữ liệu nguồn cho phép; xây danh sách sai lệch, retry có kiểm soát và audit xử lý.

- Phụ thuộc: feat-045.
- Nguồn: INT-03, FIN-08, NFR-04.
- Điều kiện xác nhận: QD-03.
- Vùng code dự kiến: `apps/api/src/modules/reconciliation/`, `apps/web/src/features/integration-operations/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Cố ý lệch một trạng thái sinh issue có correlation ID và chủ xử lý.
2. Mất kết nối rồi khôi phục không mất dữ liệu; sửa mapping hoặc gửi lại ghi căn cứ và không bỏ qua trạng thái unknown.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-046`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-047 Xuất bộ hồ sơ kiểm tra

Sinh gói hồ sơ theo kỳ/pháp nhân/giao dịch với manifest, bản chứng từ đúng phiên bản, quyết định, kết quả ký và số Bravo; xử lý xuất bất đồng bộ theo quyền.

- Phụ thuộc: feat-033, feat-046, feat-011, feat-015.
- Nguồn: FIN-09, DOS-02.
- Điều kiện xác nhận: QD-05.
- Vùng code dự kiến: `apps/api/src/modules/dossier-export/`, `apps/worker/src/jobs/exports/`, `apps/web/src/features/dossier-export/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Manifest đối chiếu được số lượng, version và hash; bản chốt không bị thay bằng bản mới nhất.
2. Kiểm quyền khi tạo job, khi chạy và khi tải; gói xuất không chứa tài liệu ngoài phạm vi và có hạn truy cập.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-047`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-048 Nghiệm thu tài chính và chuỗi nhiều quy trình

Chạy xuyên suốt vận tải và mua bán nhiều quy trình với dữ liệu mẫu được duyệt, nhà cung cấp sandbox thật, lỗi kết nối và thay đổi chứng từ.

- Phụ thuộc: feat-038, feat-039, feat-044, feat-047.
- Nguồn: UAT-01, UAT-02.
- Điều kiện xác nhận: QD-01, QD-02, QD-03, QD-04.
- Vùng code dự kiến: `tests/e2e/finance/`, `docs/uat/finance/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. UAT-01 và UAT-02 có cả happy path, ngoại lệ, trùng, nhiều đợt, retry và xuất bộ chứng từ.
2. Kế toán xác nhận ranh giới E Office/Bravo và đối chiếu số liệu; mock không được dùng làm bằng chứng tích hợp thật. Nếu policy yêu cầu ký số thì feat-032 cũng phải hoàn tất.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-048`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-049 Báo cáo tài chính và in theo mã nguồn

Tổng hợp tiến độ xử lý, số dư, sai lệch và trạng thái Bravo; truy nguồn từ chỉ tiêu xuống giao dịch và in bộ hồ sơ theo mã/số bút toán.

- Phụ thuộc: feat-046, feat-047.
- Nguồn: FIN-01, FIN-05, FIN-09.
- Điều kiện xác nhận: QD-02, QD-03.
- Vùng code dự kiến: `apps/api/src/modules/finance/reporting/`, `apps/web/src/features/finance-reports/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Chỉ tiêu truy được giao dịch nguồn và phân biệt các trạng thái tiền.
2. Lọc pháp nhân/kỳ theo quyền, in đúng snapshot và không dùng chỉ tiêu mô phỏng như dữ liệu thật.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-049`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.


## P4 Kho dữ liệu và kiểm toán

### feat-050 Các kênh nhận tài liệu và hàng chờ chất lượng

Bổ sung batch upload, scanner/email hoặc nguồn được chọn; chuẩn hóa thông tin nguồn, chống nhập lặp, cách ly và phân công bổ sung metadata.

- Phụ thuộc: feat-012, feat-013, feat-017.
- Nguồn: DMS-03.
- Điều kiện xác nhận: QD-01, QD-04, QD-05.
- Vùng code dự kiến: `apps/api/src/modules/document-intake/`, `apps/worker/src/jobs/intake/`, `apps/web/src/features/intake-queue/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Mỗi kênh được chọn có trace nguồn/người nộp và trạng thái chất lượng.
2. Tệp thiếu trường hoặc bị nghi độc không vào kho chính thức; quét lại cùng batch không nhân bản.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-050`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-051 Tìm nội dung và ngăn lộ dữ liệu qua chỉ mục

Trích xuất và lập chỉ mục nội dung với search port; bắt đầu bằng tìm metadata và full text phù hợp tải. Quyền áp dụng trước kết quả, snippet, facet và tổng số.

- Phụ thuộc: feat-015, feat-038, feat-017, feat-083.
- Nguồn: DMS-05, AUTH-01, UI-DMS, UI-SEARCH.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `apps/api/src/modules/search/`, `apps/worker/src/jobs/indexing/`, `tests/security/search/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Từ khóa chỉ có trong tài liệu ngoài quyền không sinh hàng ẩn, snippet, gợi ý hoặc số đếm gây lộ.
2. Thu hồi quyền chặn trả dữ liệu ngay cả khi chỉ mục chưa cập nhật; tiếng Việt có bộ truy vấn đánh giá.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-051`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-052 Đồ thị tham chiếu hồ sơ và tài liệu

Hiển thị hợp đồng, tài liệu, hồ sơ và nguồn liên quan bằng danh sách hoặc đồ thị; tải từng phần và lọc node/edge theo quyền.

- Phụ thuộc: feat-014, feat-024, feat-051.
- Nguồn: DMS-01, DOS-01, UI-DMS, UI-SEARCH.
- Điều kiện xác nhận: QD-05.
- Vùng code dự kiến: `apps/api/src/modules/document-relations/`, `apps/web/src/features/reference-graph/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Một bản hợp đồng thể hiện nhiều nơi dùng mà không tăng số object lưu.
2. Quan hệ sang hồ sơ ngoài quyền không lộ node, edge, tổng số hoặc metadata bị cấm.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-052`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-053 Hiệu lực thay thế và cảnh báo nơi dùng

Áp dụng phụ lục, ngày hiệu lực, hủy/thay thế và cảnh báo hồ sơ đang dùng tài liệu hết hạn; giữ quan hệ phiên bản và yêu cầu đánh giá lại khi cần.

- Phụ thuộc: feat-035, feat-052, feat-018.
- Nguồn: DMS-04, CON-01, DOS-03.
- Điều kiện xác nhận: QD-02, QD-05.
- Vùng code dự kiến: `apps/api/src/modules/documents/lifecycle/`, `apps/web/src/features/document-impact/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Bản ký cũ giữ nguyên và nơi tham chiếu thấy cảnh báo đúng phạm vi.
2. Việc đổi bản áp dụng có ngày hiệu lực, căn cứ và người chấp thuận; snapshot đã chốt giữ bản lịch sử.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-053`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-054 Hạn lưu legal hold và tiêu hủy có kiểm soát

Cấu hình retention theo loại, giữ để kiểm tra/tranh chấp, đề nghị tiêu hủy và phê duyệt. Thử Object Lock theo version nếu hạ tầng/chính sách yêu cầu WORM.

- Phụ thuộc: feat-014, feat-011, feat-033.
- Nguồn: DMS-07, NFR-05, UI-DMS, UI-SEARCH.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `apps/api/src/modules/retention/`, `infra/storage/`, `docs/runbooks/retention/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Legal hold chặn tiêu hủy dù hết hạn; thẩm quyền gỡ hold và tiêu hủy tách rõ.
2. Nếu chọn WORM, test sandbox chứng minh version khóa không bị xóa/ghi đè; không tự đặt 10 năm hay bật khóa không đảo ngược trên production.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-054`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-055 Khảo sát dữ liệu cũ và chạy thử chuyển đổi

Lập inventory dữ liệu nguồn được cấp, profile metadata/trùng/lỗi và bản đồ ánh xạ; chạy dry run trên một lô mẫu và dự toán khối lượng chuyển đổi.

- Phụ thuộc: feat-013, feat-016, feat-050.
- Nguồn: DMS-08.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `tools/migration/`, `docs/migration/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Mỗi nguồn có số tệp, dung lượng, quyền đọc, trường thiếu và chủ xử lý.
2. Dry run xuất báo cáo nhận/lỗi/trùng mà không xóa hoặc sửa nguồn; có quy tắc xử lý bản không đủ metadata.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-055`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-056 Nhập dữ liệu theo lô và kiểm kê

Xây batch staging, mapping, checkpoint, import idempotent, quarantine lỗi và biên bản đối chiếu từng đợt; quản lý quyền sau nhập.

- Phụ thuộc: feat-055, feat-039, feat-054.
- Nguồn: DMS-08, UAT-05.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `tools/migration/`, `apps/api/src/modules/migration/`, `apps/web/src/features/migration-operations/`.
- Ước lượng: 3–5 ngày công.

Tiêu chí nghiệm thu:

1. Chạy lại lô bị gián đoạn không nhân bản; tổng nguồn bằng nhập thành công cộng lỗi/trùng/loại trừ theo quy tắc.
2. Kiểm hash và lấy mẫu quyền/liên kết; không ghi đè tài liệu đã ký hoặc phá legal hold.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-056`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-057 Quyền kiểm toán theo phạm vi và thời hạn

Cấp AccessGrant cho người/nhóm kiểm tra theo tập hồ sơ, hành động và hạn; dùng mã tra cứu cùng xác thực/quyền, hỗ trợ thu hồi và audit.

- Phụ thuộc: feat-015, feat-047, feat-033.
- Nguồn: DOS-02, FIN-09, AUTH-01.
- Điều kiện xác nhận: QD-05.
- Vùng code dự kiến: `apps/api/src/modules/access-grants/`, `apps/web/src/features/audit-room/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Mã tra cứu đơn lẻ không mở tài liệu ngoài quyền; hết hạn hoặc thu hồi chặn mở/tải mới.
2. Kiểm toán viên chỉ thấy đúng snapshot và phạm vi; xem/tải/xuất có log.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-057`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-058 Bàn giao toàn bộ dữ liệu và nạp lại mẫu

Xuất tài liệu, version, metadata, liên kết, quyền được phép và audit theo schema có tài liệu; tạo công cụ nạp lại một tập mẫu để kiểm tra khả năng chuyển nhà cung cấp.

- Phụ thuộc: feat-047, feat-052, feat-054.
- Nguồn: DMS-09, NFR-05.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `tools/data-portability/`, `docs/data-export/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Gói xuất có schema/version, manifest, kiểm hash và chính sách bảo vệ dữ liệu.
2. Nạp lại mẫu phục hồi quan hệ hồ sơ-tài liệu-version; ghi dung lượng/thời gian và giới hạn bàn giao cần thỏa thuận.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-058`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-059 Nghiệm thu kho dữ liệu và kiểm toán

Chạy các tình huống hợp đồng nhiều nơi dùng, thay phụ lục, tìm kiếm ngoài quyền, nhập dữ liệu thiếu/trùng, sửa OCR, giữ/khóa và cấp quyền kiểm toán.

- Phụ thuộc: feat-050, feat-051, feat-053, feat-056, feat-057, feat-058.
- Nguồn: UAT-03, UAT-05.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `tests/e2e/dms/`, `docs/uat/dms/`.
- Ước lượng: 2–3 ngày công.

Tiêu chí nghiệm thu:

1. UAT-03/UAT-05 có bằng chứng dữ liệu trước/sau, báo cáo nhập và kiểm quyền âm.
2. Người quản lý kho xác nhận kết quả kiểm kê và bên kiểm tra mở được đúng bộ hồ sơ trong hạn.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-059`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.


## P5 Mobile và responsive

### feat-060 Ứng dụng Flutter và nền định danh

Tạo app iOS/Android, ánh xạ UI tokens đã review từ docs/design vào Flutter, API client sinh từ OpenAPI, secure session và build theo môi trường. Framework là đề xuất kỹ thuật tại QD-04, không suy từ thiết kế cũ.

- Phụ thuộc: feat-008, feat-026, feat-006.
- Nguồn: MOB-01, MOB-05, UI-MOBILE.
- Điều kiện xác nhận: QD-01, QD-04, QD-06.
- Vùng code dự kiến: `apps/mobile/`, `packages/api-contracts/`, `docs/mobile/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Android/iOS chạy trên thiết bị thử với đăng nhập sandbox và chọn vai trò/pháp nhân.
2. Token không nằm trong log hoặc cấu hình app; CI phân biệt phần kiểm tra chạy được trên Windows và phần cần macOS.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-060`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-061 Inbox mobile theo mức tích hợp

Hiển thị yêu cầu E Office và nguồn ngoài với ba capability: thông báo, xem/chuyển nguồn, quyết định và đồng bộ hai chiều; lọc theo vai trò, pháp nhân, hạn và số tiền.

- Phụ thuộc: feat-060, feat-018.
- Nguồn: MOB-01.
- Điều kiện xác nhận: QD-04.
- Vùng code dự kiến: `apps/mobile/lib/features/inbox/`, `apps/api/src/modules/unified-inbox/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Mỗi mục ghi rõ chủ luồng và khả năng duyệt; nguồn chưa hỗ trợ không có nút duyệt giả.
2. Đổi vai trò xóa dữ liệu hiển thị sai phạm vi và tải lại bằng quyền mới.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-061`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-062 Xem hồ sơ và quyết định trên mobile

Chi tiết hồ sơ, viewer, cảnh báo, ý kiến và diff; gửi quyết định với snapshot ID, expected revision và operation ID.

- Phụ thuộc: feat-061, feat-027, feat-044, feat-083.
- Nguồn: MOB-02, MOB-04.
- Điều kiện xác nhận: QD-02.
- Vùng code dự kiến: `apps/mobile/lib/features/approvals/`, `apps/mobile/lib/features/documents/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Bản xem và bản được duyệt trùng version/hash; số liệu ngân sách chỉ hiện khi có nguồn hợp lệ.
2. Thay hóa đơn hoặc thụ hưởng làm request cũ thất bại và buộc xem bản mới.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-062`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-063 Mất mạng gửi lại và đối soát quyết định

Quản lý trạng thái chưa gửi/đang gửi/chờ xác nhận/đã xác nhận/lỗi và tra operation sau timeout. Mỗi quyết định cần server kiểm quyền, phiên và bản trình.

- Phụ thuộc: feat-062, feat-017.
- Nguồn: MOB-03, MOB-04, MOB-05.
- Điều kiện xác nhận: QD-02, QD-04.
- Vùng code dự kiến: `apps/mobile/lib/features/approval-sync/`, `tests/mobile/network/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Ngắt mạng trước/sau commit rồi gửi lại không tạo hai quyết định; kết quả chưa rõ không hiển thị thành công.
2. Không ký/duyệt khi offline; server từ chối phiên bị thu hồi hoặc yêu cầu đã thay thế.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-063`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-064 Ký số mobile qua luồng xác thực thật

Tích hợp UX ký của CA/HSM được chọn, step-up theo chính sách và theo dõi operation; hiển thị artifact/kết quả xác minh sau khi nguồn xác nhận.

- Phụ thuộc: feat-032, feat-062, feat-063.
- Nguồn: SIG-02, MOB-02, UI-MOBILE.
- Điều kiện xác nhận: QD-02, QD-04.
- Vùng code dự kiến: `apps/mobile/lib/features/signing/`, `docs/mobile/signing/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Thiết bị thật hoàn thành ký sandbox với đúng hash/phiên bản và căn cứ ủy quyền.
2. Hủy/timeout/từ chối/đổi tài liệu không hiện con dấu hoàn tất; sinh trắc học đơn lẻ không thay bằng chứng CA.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-064`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-065 Cache đọc được phép và quản lý dữ liệu thiết bị

Cấu hình loại dữ liệu được cache, mã hóa, TTL, xóa khi logout/đổi vai trò và nhãn dữ liệu cũ. Hồ sơ nhạy cảm có thể buộc online hoàn toàn.

- Phụ thuộc: feat-060, feat-062.
- Nguồn: MOB-05, NFR-01.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `apps/mobile/lib/core/storage/`, `apps/mobile/lib/features/offline-reading/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Chỉ dữ liệu được phép có cache; hết TTL hoặc đổi vai trò không còn mở được bằng app.
2. Chính sách nêu đúng giới hạn thu hồi khi thiết bị mất kết nối; không cam kết xóa tức thì dữ liệu đã tải offline.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-065`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-066 Push thiết bị và nghiệm thu mobile

Quản lý thiết bị/push token, thu hồi phiên, deep link có kiểm quyền và kiểm thử iOS/Android. Hoàn tất UAT-04 cùng vai trò kiêm nhiệm, ủy quyền và sự cố mạng.

- Phụ thuộc: feat-061, feat-063, feat-064, feat-065.
- Nguồn: MOB-01, MOB-05, UAT-04.
- Điều kiện xác nhận: QD-04, QD-05, QD-06.
- Vùng code dự kiến: `apps/mobile/`, `apps/api/src/modules/devices/`, `tests/mobile/`, `docs/uat/mobile/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Push không lộ nội dung nhạy cảm trên màn hình khóa; thiết bị bị thu hồi không dùng API với phiên cũ.
2. UAT-04 có kiểm thử thiết bị thật, retry, thay dữ liệu và hết hạn ủy quyền; build/phân phối app có hướng dẫn.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-066`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-084 Hoàn thiện responsive và thao tác mobile

Điều chỉnh luồng duyệt, tài liệu, đối soát theo viewport; kiểm safe-area, bàn phím, tên dài, số tiền, offline và pending.

- Phụ thuộc: feat-030, feat-062, feat-063, feat-083.
- Nguồn: UI-MOBILE, MOB-02, MOB-03, MOB-05.
- Điều kiện xác nhận: QD-04.
- Vùng code dự kiến: `apps/web/src/features/`, `apps/mobile/lib/`, `docs/design/reviews/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Review ở 1440/1280/768/390px, reflow 320px và zoom 200%; không che action hoặc cắt mất đơn vị/số tiền.
2. Mobile dùng bố cục riêng, field có label, vùng chạm rõ; kết quả chỉ confirmed khi nguồn xác nhận và có reduced motion.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-084`.
Lệnh tự động kiểm phần có thể kiểm; UI review cần ảnh và biên bản quan sát thật, không coi build pass là UI đã đạt.


## P6 Văn bản công việc và tiện ích

### feat-067 Văn bản đến và giao xử lý

Đăng ký số đến, nguồn, pháp nhân, độ mật, hạn, chủ trì và phối hợp; liên kết hồ sơ/công việc, phản hồi và tiến độ.

- Phụ thuộc: feat-014, feat-024, feat-029.
- Nguồn: DOC-01.
- Điều kiện xác nhận: QD-01, QD-02.
- Vùng code dự kiến: `apps/api/src/modules/correspondence/incoming/`, `apps/web/src/features/incoming-documents/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Một công văn đến được phân công, theo dõi hạn và lưu câu trả lời liên quan.
2. Số đến/pháp nhân và quyền tài liệu được kiểm tra; người phối hợp không được mở tài liệu ngoài quyền.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-067`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-068 Văn bản đi ký và cấp số

Soạn/rà soát/trình ký/phát hành, cấp số theo sổ/pháp nhân, quản lý nơi nhận và xác nhận gửi. Chốt bước cấp số trước/sau ký theo loại văn bản.

- Phụ thuộc: feat-032, feat-033, feat-067.
- Nguồn: DOC-02, SIG-01, SIG-02.
- Điều kiện xác nhận: QD-02, QD-04.
- Vùng code dự kiến: `apps/api/src/modules/correspondence/outgoing/`, `apps/web/src/features/outgoing-documents/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Hai thao tác đồng thời không trùng số; số hủy không tái dùng nếu chính sách cấm.
2. Bản phát hành có số và đúng bản ký; không ghi thêm số trực tiếp vào byte đã ký làm hỏng chữ ký.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-068`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-069 Công việc phối hợp và bằng chứng

Quản lý người giao, chịu trách nhiệm, phối hợp, hạn, ưu tiên, kết quả và bằng chứng; liên kết văn bản, hồ sơ hoặc dự án.

- Phụ thuộc: feat-024, feat-018, feat-009.
- Nguồn: TSK-01, DOC-01.
- Điều kiện xác nhận: QD-01, QD-07.
- Vùng code dự kiến: `apps/api/src/modules/work-management/`, `apps/web/src/features/tasks/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Quá hạn hiện đúng người liên quan và thống kê theo đơn vị.
2. Kết quả và thay đổi người/hạn có lịch sử; ApprovalTask và công việc người dùng không bị nhầm một thực thể.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-069`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-070 Chỉ tiêu công việc có quy tắc và truy nguồn

Cấu hình công thức hoàn thành, quá hạn, chất lượng và quy trình điều chỉnh điểm; tổng hợp tới đơn vị theo quyền.

- Phụ thuộc: feat-069.
- Nguồn: TSK-02.
- Điều kiện xác nhận: QD-07.
- Vùng code dự kiến: `apps/api/src/modules/work-metrics/`, `apps/web/src/features/task-reports/`.
- Ước lượng: 1,5–3 ngày công.

Tiêu chí nghiệm thu:

1. Mỗi số liệu truy được công việc nguồn và version công thức.
2. Điều chỉnh điểm có lý do/người duyệt; không có chức năng tính lương khi chưa được đưa vào phạm vi.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-070`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-071 Dự án giai đoạn và tiến độ

Quản lý thành phần dự án, giai đoạn, mốc, người phụ trách, tài liệu và cách tính phần trăm có cấu hình; phân biệt tiến độ kế hoạch/thực tế.

- Phụ thuộc: feat-069, feat-014.
- Nguồn: PRJ-01.
- Điều kiện xác nhận: QD-07.
- Vùng code dự kiến: `apps/api/src/modules/projects/`, `apps/web/src/features/projects/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Đổi tiến độ công việc cập nhật giai đoạn/dự án đúng công thức đã chốt.
2. Mốc và quyết định/tài liệu truy được; công việc ngoài quyền không lộ qua báo cáo.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-071`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-072 Đặt xe phòng họp và chống xung đột

Quản lý nguồn lực, lịch, đăng ký, duyệt, hủy và thời gian đệm theo chính sách; chống đặt trùng trong transaction và theo trạng thái được xác nhận.

- Phụ thuộc: feat-022, feat-009, feat-018.
- Nguồn: UTL-01.
- Điều kiện xác nhận: QD-07.
- Vùng code dự kiến: `apps/api/src/modules/resource-booking/`, `apps/web/src/features/bookings/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Hai yêu cầu đồng thời cùng phòng/xe và khoảng giờ chỉ một yêu cầu được xác nhận.
2. Hủy giải phóng đúng lịch; timezone được thống nhất và người quản lý thấy xung đột đúng phạm vi.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-072`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-073 Công tác và nghiệm thu phân hệ mở rộng

Liên kết công tác, đề xuất, tạm ứng và quyết toán theo rule; chạy UAT-06 cho văn bản, công việc, dự án và đặt phòng xung đột.

- Phụ thuộc: feat-067, feat-068, feat-070, feat-071, feat-072, feat-036, feat-042.
- Nguồn: UTL-01, UAT-06.
- Điều kiện xác nhận: QD-02, QD-07.
- Vùng code dự kiến: `apps/api/src/modules/business-travel/`, `apps/web/src/features/business-travel/`, `tests/e2e/administration/`, `docs/uat/administration/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Từ chuyến công tác truy được tạm ứng/quyết toán và không tạo giao dịch tiền trùng.
2. UAT-06 xác nhận đủ công văn đến/đi, đúng tư cách ký, cách tính tiến độ và chặn đặt trùng.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-073`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.


## P7 Review UI demo và phát hành

### feat-074 Quyết định hai chiều với nguồn ngoài được chọn

Triển khai capability duyệt hai chiều chỉ cho các hệ thống có API/quyền được xác nhận; kiểm version nguồn, ack, callback, idempotency và đối soát.

- Phụ thuộc: feat-061, feat-063, feat-017, feat-046.
- Nguồn: INT-01, INT-02, INT-03, INT-04, MOB-01.
- Điều kiện xác nhận: QD-04.
- Vùng code dự kiến: `apps/api/src/adapters/external-approvals/`, `docs/integrations/`, `tests/contracts/`.
- Ước lượng: 3–6 ngày công.

Tiêu chí nghiệm thu:

1. Mỗi nguồn được chọn có bản đồ trường, chủ luồng, đầu mối và test lỗi cho cả hai chiều.
2. Kết quả chưa được nguồn xác nhận không hiện hoàn tất; nguồn không hỗ trợ vẫn giữ mức thông báo/chuyển tiếp đã thỏa thuận.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-074`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-075 Giám sát vận hành và cảnh báo

Hoàn thiện dashboard DB/storage, queue, tích hợp, OCR/index và backup; correlation ID từ client tới adapter; cảnh báo có người phụ trách và runbook.

- Phụ thuộc: feat-017, feat-046, feat-051, feat-054.
- Nguồn: NFR-04, AUD-01.
- Điều kiện xác nhận: QD-06.
- Vùng code dự kiến: `infra/observability/`, `apps/api/src/telemetry/`, `apps/worker/src/telemetry/`, `docs/runbooks/`.
- Ước lượng: 2–3,5 ngày công.

Tiêu chí nghiệm thu:

1. Tạo lỗi Bravo, hết quota, lỗi chỉ mục và backup thất bại sinh cảnh báo có thể truy xử lý.
2. Log/trace/metric không chứa bí mật hoặc nội dung tài liệu ngoài chính sách; cảnh báo có ngưỡng và owner.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-075`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-076 Kiểm thử bảo mật xuyên suốt

Kiểm tra ma trận quyền âm, IDOR, session, upload/XML, URL tải, export/job, search/count, cache và API nguồn; rà dependency, cấu hình và quản lý bí mật.

- Phụ thuộc: feat-059, feat-066, feat-073, feat-074, feat-075.
- Nguồn: AUTH-01, AUTH-02, NFR-01, NFR-02, MOB-05.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `tests/security/`, `docs/security/`, `infra/`.
- Ước lượng: 3–5 ngày công.

Tiêu chí nghiệm thu:

1. Tình huống truy chéo pháp nhân, quyền bị thu hồi và worker mất context đều bị chặn mà không lộ metadata.
2. Lỗi nghiêm trọng được sửa và kiểm lại; báo cáo ghi phạm vi/điểm chưa kiểm để người chịu trách nhiệm quyết định phát hành.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-076`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-077 Đo hiệu năng dung lượng và khôi phục tải

Tạo workload theo người dùng, dữ liệu cũ, tăng trưởng, tệp và lịch tích hợp đã chốt; đo p95, tỷ lệ lỗi, throughput và backlog, tối ưu theo nút thắt thực tế.

- Phụ thuộc: feat-075, feat-076.
- Nguồn: NFR-03.
- Điều kiện xác nhận: QD-06.
- Vùng code dự kiến: `tests/performance/`, `docs/performance/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Biên bản ghi hạ tầng, dữ liệu, concurrency, ngưỡng đã duyệt và kết quả, không lấy tốc độ showcase làm SLA.
2. Thử tải kéo dài và phục hồi queue sau sự cố; không tối ưu bằng cách bỏ kiểm quyền hoặc toàn vẹn.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-077`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-078 Sao lưu khôi phục và diễn tập sự cố

Sao lưu DB, object/version, cấu hình, khóa cần thiết và tài liệu phục hồi; diễn tập khôi phục môi trường tách biệt rồi xây lại chỉ mục và đối soát tích hợp.

- Phụ thuộc: feat-054, feat-058, feat-075.
- Nguồn: NFR-01, NFR-03, NFR-04, NFR-05.
- Điều kiện xác nhận: QD-05, QD-06.
- Vùng code dự kiến: `infra/backup/`, `docs/runbooks/disaster-recovery/`, `tests/recovery/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Khôi phục được bộ hồ sơ mẫu với hash, version, liên kết, quyết định và quyền; ghi RPO/RTO đo được.
2. Có cách phục hồi khóa/mã hóa được kiểm soát và xử lý sự kiện đang gửi dở mà không tạo quyết định/bút toán đôi.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-078`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-079 Diễn tập chuyển hệ thống và kế hoạch quay lui

Chạy migration dress rehearsal, chốt cửa sổ dữ liệu, delta import, đối chiếu, cờ bật tích hợp, hỗ trợ pilot và rollback ứng dụng theo migration tương thích.

- Phụ thuộc: feat-056, feat-077, feat-078, feat-048.
- Nguồn: DMS-08, INT-04, NFR-04.
- Điều kiện xác nhận: QD-01, QD-03, QD-04, QD-05, QD-06.
- Vùng code dự kiến: `docs/release/`, `infra/deploy/`, `tools/migration/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Có checklist go/no-go với chủ ký nhận, báo cáo kiểm kê và ngưỡng dừng rõ ràng.
2. Rollback giữ được tài liệu đã ký và giao dịch đã xác nhận tại nguồn; không hứa đảo ngược tự động tác động ngoài hệ thống.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-079`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-080 Nghiệm thu cuối và bàn giao vận hành

Đối chiếu toàn bộ 54 yêu cầu, sáu UAT và các QD thành baseline; bàn giao hướng dẫn, đào tạo, cấu hình, quyền quản trị, export, hỗ trợ và lịch kiểm tra vận hành.

- Phụ thuộc: feat-079, feat-076, feat-077, feat-078, feat-059, feat-066, feat-073, feat-074, feat-049, feat-034, feat-085, feat-086.
- Nguồn: UAT-01, UAT-02, UAT-03, UAT-04, UAT-05, UAT-06, NFR-01, NFR-02, NFR-03, NFR-04, NFR-05.
- Điều kiện xác nhận: QD-01, QD-02, QD-03, QD-04, QD-05, QD-06, QD-07.
- Vùng code dự kiến: `docs/uat/`, `docs/training/`, `docs/operations/`, `README.md`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Mọi feature trong phạm vi được duyệt có bằng chứng thật, commit và người nghiệm thu; mục cắt giảm được xử lý bằng thay đổi phạm vi có xác nhận.
2. Chủ vận hành tiếp nhận và thực hành được backup/restore, xử lý lỗi tích hợp, thu hồi quyền và xuất bộ dữ liệu; go-live theo quyết định phát hành riêng.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-080`.
Lệnh và test tương ứng sẽ được hiện thực ở feat-004/feat-005 và trong feature liên quan; chưa chạy.

### feat-085 Review giao diện và khả năng truy cập

Review toàn bộ màn hình triển khai so với UI spec; sửa sai lệch hierarchy, spacing, component, focus, tương phản và trạng thái.

- Phụ thuộc: feat-082, feat-083, feat-084, feat-073, feat-049, feat-059, feat-066.
- Nguồn: UI-REVIEW, AUTH-01, MOB-02.
- Điều kiện xác nhận: QD-01.
- Vùng code dự kiến: `docs/design/reviews/`, `packages/ui/`, `apps/web/`, `apps/mobile/`.
- Ước lượng: 1–2 ngày công.

Tiêu chí nghiệm thu:

1. Có bảng review và ảnh màn hình thật cho các luồng ưu tiên, kiểm bàn phím/focus/contrast/reflow và ghi rõ phần chưa kiểm.
2. CTA, bảng số, viewer, trạng thái bất đồng bộ và ngôn ngữ nhất quán; lỗi cản trở quyết định được sửa trước nghiệm thu cuối.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-085`.
Lệnh tự động kiểm phần có thể kiểm; UI review cần ảnh và biên bản quan sát thật, không coi build pass là UI đã đạt.

### feat-086 Hình và demo Stageshow theo UI đã review

Dựng hình hoặc demo ngắn từ UI thật đã review và dữ liệu tổng hợp; chọn câu chuyện một hành động, có kết quả rõ và phiên bản compact.

- Phụ thuộc: feat-085.
- Nguồn: STAGESHOW, UI-SHOWCASE.
- Điều kiện xác nhận: Không có QD chặn riêng.
- Vùng code dự kiến: `docs/design/showcase/`, `apps/web/src/showcase/`.
- Ước lượng: 2–4 ngày công.

Tiêu chí nghiệm thu:

1. Đọc skill gốc và references cần thiết, chọn example gần nhất; still/compact có crop hợp lý, CTA và dữ liệu trọng tâm còn nguyên.
2. Nếu làm animation có poster reduced-motion và contact sheet/loop review; giữ kết quả đọc được, dữ liệu có nhãn, adapter giao dịch thật không được gọi.

Kiểm tra dự kiến: `pnpm verify:feature --id feat-086`.
Lệnh tự động kiểm phần có thể kiểm; UI review cần ảnh và biên bản quan sát thật, không coi build pass là UI đã đạt.

## Ma trận truy vết 54 yêu cầu SRS

Các hàng thể hiện phạm vi liên quan; tham chiếu không đồng nghĩa đã nghiệm thu.

| Mã SRS | Hành vi chính | Feature liên quan |
| --- | --- | --- |
| ORG-01 | Hệ thống biểu diễn cây pháp nhân, Tổng công ty, đơn vị thành viên, chi nhánh, khối, phòng ban; lưu mã, quan hệ, ngày hiệu lực, trạng thái; hỗ trợ cá nhân kiêm… | feat-007 |
| AUTH-01 | Quyền được quyết định bởi vai trò, pháp nhân, đơn vị, loại hồ sơ, mức bảo mật, hành động, hạn mức và hiệu lực; kiểm tra ở API, kết quả tìm kiếm, tệp và chức năng… | feat-005, feat-009, feat-015, feat-051, feat-057, feat-076, feat-083, feat-085 |
| AUTH-02 | Ủy quyền ghi người giao, người nhận, căn cứ, phạm vi nghiệp vụ, hạn mức, ngày bắt đầu/kết thúc, trạng thái thu hồi và người đã quyết định thực tế; kiểm tra thẩm… | feat-010, feat-026, feat-076 |
| CFG-01 | Quản trị viên nghiệp vụ cấu hình bảng quy tắc theo loại hồ sơ và pháp nhân: trường bắt buộc, tài liệu, ngưỡng tiền, người kiểm tra, ngoại lệ, chuỗi ký, thời hạn;… | feat-013, feat-019, feat-020, feat-021, feat-025 |
| AUD-01 | Lưu lịch sử tạo, xem, tải, sửa, cấp/thu hồi quyền, trình, phê duyệt, ký, xuất, tích hợp và thay thế; ghi ai, lúc nào, phạm vi, đối tượng, kết quả và phiên bản;… | feat-011, feat-075 |
| WF-01 | Thiết kế biểu mẫu theo loại việc với trường dữ liệu, điều kiện bắt buộc, tệp, công thức có phiên bản, nguồn danh mục và phân quyền xem/sửa từng bước. [YCG] | feat-019, feat-020, feat-025, feat-034 |
| WF-02 | Quy trình hỗ trợ tuần tự, song song, điều kiện, trả lại, rút trình, thay người, nhắc hạn, quá hạn; xác định người xử lý theo cơ cấu và thẩm quyền đang hiệu lực.… | feat-018, feat-021, feat-022, feat-023, feat-028, feat-034 |
| WF-03 | Cho phép quy trình mua sắm, hợp đồng, tạm ứng, quyết toán, thanh toán cùng tham chiếu một hồ sơ tổng hợp; định nghĩa điều kiện kích hoạt, dữ liệu kế thừa, trạng… | feat-029, feat-034 |
| WF-04 | Người duyệt xem dữ liệu, chứng từ, phiên bản, ý kiến trước, cảnh báo và các bước còn lại; có duyệt, từ chối, trả bổ sung, cho ý kiến theo chính sách. [YCG] | feat-022, feat-026, feat-028, feat-034, feat-081 |
| WF-05 | Thay số tiền, đối tác, người thụ hưởng hoặc tài liệu trọng yếu sau khi trình khiến bước duyệt bị vô hiệu hóa hoặc trình lại theo quy tắc được cấu hình; so sánh… | feat-027, feat-034 |
| DOS-01 | Mỗi hồ sơ có mã duy nhất, chủ sở hữu, pháp nhân, loại nghiệp vụ, kỳ, trạng thái và liên kết tới chứng từ từ nhiều đơn vị/hệ thống; cho phép tham chiếu một tài… | feat-014, feat-024, feat-052 |
| DOS-02 | Khi hoàn tất, tạo danh mục chứng từ, phiên bản tại thời điểm chốt, lịch sử phê duyệt và trạng thái ký; cấp mã tra cứu cho người có quyền, kiểm soát phạm vi và… | feat-033, feat-047, feat-057 |
| DOS-03 | Bổ sung sau hoàn tất/kỳ khóa được ghi thành phiên bản hoặc hồ sơ điều chỉnh, có lý do, căn cứ, người chấp thuận và liên kết về bản gốc; không ghi đè lịch sử đã… | feat-033, feat-053 |
| FIN-01 | Liên kết đề xuất, phê duyệt, hợp đồng/đơn mua nếu áp dụng, nghiệm thu/chứng từ dịch vụ, hóa đơn, tạm ứng, hoàn ứng, yêu cầu thanh toán và số bút toán Bravo trên… | feat-024, feat-029, feat-035, feat-036, feat-049 |
| FIN-02 | Nhận tệp hóa đơn gốc XML khi tồn tại, bản thể hiện và metadata; đánh dấu nguồn, người xác nhận; phân biệt tệp không đọc được, thiếu và cần xác minh; không tự suy… | feat-012, feat-037 |
| FIN-03 | Trích xuất trường hóa đơn và chứng từ quét bằng OCR khi cấu hình; hiển thị nguồn, độ tin cậy, cho người có quyền xác nhận/chỉnh trường, lưu giá trị trước và sau.… | feat-037, feat-038 |
| FIN-04 | Đối soát hợp đồng/đơn mua, nghiệm thu, hóa đơn và đề nghị thanh toán theo trường áp dụng; phân loại khớp, chênh lệch trong ngưỡng, vượt ngưỡng, thiếu dữ liệu,… | feat-040, feat-041 |
| FIN-05 | Phân bổ một hóa đơn cho nhiều chuyến/dịch vụ và theo dõi nhiều lần thanh toán theo một hợp đồng; lưu số tiền đã duyệt, đã chuyển Bravo và đã thanh toán tách biệt… | feat-036, feat-042, feat-049 |
| FIN-06 | Phát hiện hóa đơn có bộ trường định danh trùng trong phạm vi được Vinafco phê duyệt; khóa nghiệp vụ không dựa vào MD5; xử lý trường hợp hóa đơn thay thế, điều… | feat-039 |
| FIN-07 | Ngoại lệ thiếu hợp đồng, vượt ngân sách, thiếu chứng từ tại thời điểm trình hoặc sai lệch có quy tắc theo loại việc: chặn, trả bổ sung hoặc cho phép trình ngoại… | feat-036, feat-043, feat-044 |
| FIN-08 | Chuyển thông tin phê duyệt và chứng từ cần thiết cho Bravo bằng cơ chế Bravo thực tế hỗ trợ; lưu ID giao dịch, kết quả nhận, số chứng từ/bút toán, trạng thái và… | feat-045, feat-046 |
| FIN-09 | Xuất bộ hồ sơ theo pháp nhân, kỳ, giao dịch hoặc mã hồ sơ: danh mục, tài liệu và liên kết nguồn, phiên bản, quyết định, chữ ký, số bút toán và nhật ký cần thiết;… | feat-047, feat-049, feat-057 |
| DMS-01 | Kho tài liệu có cây thư mục hoặc góc nhìn theo nghiệp vụ kết hợp metadata; một tài liệu có bản chính, nhiều tham chiếu, chủ sở hữu và phạm vi chia sẻ; tài liệu… | feat-014, feat-052 |
| DMS-02 | Mẫu metadata theo loại tài liệu khai báo tên trường, bắt buộc, kiểu, nguồn, người cập nhật, kiểm tra và trạng thái xác minh; hỗ trợ điều chỉnh mẫu theo phiên… | feat-013 |
| DMS-03 | Thu nhận từ tải lên, quét, thư điện tử và hệ thống nguồn theo kênh được triển khai; kiểm tra tệp, trùng và metadata; ghi nguồn, người nộp, thời điểm, trạng thái… | feat-012, feat-050 |
| DMS-04 | Quản lý phiên bản, phụ lục, hiệu lực, thay thế và tài liệu tham chiếu; giữ bản cũ, lý do, người sửa, dấu kiểm tra toàn vẹn; cảnh báo các hồ sơ dùng hợp đồng hết… | feat-014, feat-035, feat-053 |
| DMS-05 | Tìm theo nhiều trường metadata và nội dung khi có chỉ mục; lọc quyền trước khi hiển thị kết quả, gợi ý, đoạn trích và tải tài liệu; ghi log truy cập nhạy cảm. [YCG] | feat-015, feat-051 |
| DMS-06 | Ánh xạ mã đối tác giữa các hệ thống, quản lý mã nguồn, mã chuẩn, trạng thái đồng nhất và người quản trị danh mục; xử lý cá nhân, pháp nhân nhiều MST hoặc thay… | feat-016 |
| DMS-07 | Cấu hình hạn lưu theo loại và căn cứ được Vinafco xác nhận; áp dụng giữ để thanh tra/tranh chấp, phê duyệt tiêu hủy, xuất dữ liệu và khôi phục khi cần. [YCG] | feat-054 |
| DMS-08 | Chuyển đổi dữ liệu cũ gồm lập danh mục, ánh xạ metadata, phát hiện trùng, xử lý thiếu, kiểm kê số lượng/tính toàn vẹn và nghiệm thu theo đợt. [YCG] | feat-055, feat-056, feat-079 |
| DMS-09 | Hỗ trợ xuất toàn bộ tài liệu, phiên bản, metadata, liên kết và nhật ký được phép theo định dạng bàn giao có tài liệu cấu trúc dữ liệu; giới hạn dung lượng/chi… | feat-058 |
| DOC-01 | Tiếp nhận, đăng ký, phân loại văn bản đến theo pháp nhân, nguồn, số đến, hạn, độ mật; giao đơn vị chủ trì và phối hợp; theo dõi tiến độ và kết quả xử lý. [YCG] | feat-067, feat-069 |
| DOC-02 | Soạn, kiểm tra, trình ký, ban hành, cấp số và gửi văn bản đi theo từng quy trình/pháp nhân; quản lý bản nháp và bản phát hành, nơi nhận và xác nhận gửi. [YCG] | feat-068 |
| CON-01 | Quản lý hợp đồng và phụ lục: chủ trì, đối tác, pháp nhân, giá trị, hiệu lực, mốc gia hạn, luồng rà soát/ký và hồ sơ liên quan; phân biệt hợp đồng nội bộ và ký… | feat-035, feat-053 |
| TSK-01 | Công việc có người giao, chịu trách nhiệm, phối hợp, thời hạn, ưu tiên, kết quả và bằng chứng; nhóm theo cá nhân, phòng, đơn vị; liên kết tới văn bản, hồ sơ hoặc… | feat-069 |
| TSK-02 | Báo cáo tỷ lệ hoàn thành, quá hạn và chất lượng theo tiêu chí do Vinafco xác nhận; thay đổi điểm đánh giá có lý do và người duyệt. [YCG, ĐX] | feat-070 |
| PRJ-01 | Dự án quản lý thành phần, giai đoạn, mốc, công việc, người phụ trách, tiến độ thực tế và phần trăm theo cách tính được cấu hình; gắn tài liệu và quyết định. [YCG] | feat-071 |
| UTL-01 | Đăng ký và duyệt xe, phòng họp, công tác theo lịch, nguồn lực, người quản lý và xung đột; công tác liên kết đề xuất, tạm ứng và quyết toán nếu áp dụng. [YCG, ĐX] | feat-072, feat-073 |
| MOB-01 | iOS/Android hiển thị các yêu cầu E Office, lọc theo vai trò, pháp nhân, hạn, số tiền; yêu cầu từ hệ thống ngoài hiển thị mức kết nối và trạng thái xác nhận. [YCG] | feat-018, feat-030, feat-060, feat-061, feat-066, feat-074 |
| MOB-02 | Hiển thị tóm tắt, số tiền, ngân sách nếu có dữ liệu, tài liệu, ý kiến trước, cảnh báo, bản được trình; cho duyệt, từ chối, trả lại, cho ý kiến và ký theo quyền.… | feat-026, feat-030, feat-044, feat-062, feat-064, feat-081, feat-084, feat-085 |
| MOB-03 | Một yêu cầu duyệt có định danh giao dịch để chống xử lý trùng; hiển thị chưa gửi, đang đồng bộ, nguồn đã xác nhận hoặc lỗi; có gửi lại an toàn và danh sách đối… | feat-030, feat-063, feat-083, feat-084 |
| MOB-04 | Thay đổi dữ liệu trọng yếu vô hiệu hóa yêu cầu cũ theo chính sách; thông báo và yêu cầu xem phiên bản mới; lưu chuỗi phê duyệt trước và sau. [YCG] | feat-027, feat-062, feat-063 |
| MOB-05 | Hỗ trợ xác thực theo phương án SSO/MFA được Vinafco chọn; thiết bị mất phải thu hồi phiên; ngoại tuyến chỉ xem dữ liệu cho phép với biện pháp bảo vệ và không… | feat-008, feat-030, feat-060, feat-063, feat-065, feat-066, feat-076, feat-084 |
| SIG-01 | Phân loại xác nhận của người lập, ý kiến kiểm tra, phê duyệt nội bộ, ký điện tử và ký số của người có thẩm quyền/pháp nhân; gắn từng loại với bước, loại văn bản,… | feat-025, feat-031, feat-068 |
| SIG-02 | Với văn bản ký số, lưu tài liệu đã ký, kết quả xác minh, thời điểm, chứng thư và quan hệ với người được ủy quyền; thay nội dung đã ký phải phát hành bản mới. Nhà… | feat-032, feat-064, feat-068 |
| INT-01 | Mỗi kết nối có tài liệu hợp đồng dữ liệu: trường, kiểu, nguồn chuẩn, chiều đồng bộ, sự kiện, lịch, mã lỗi, xác thực, quyền, thời gian chờ, xử lý lặp và đối soát.… | feat-002, feat-017, feat-032, feat-040, feat-045, feat-074 |
| INT-02 | Sự kiện gửi ra có mã tương quan và khóa chống lặp; ghi trạng thái chờ, nhận, xác nhận, lỗi; thử lại theo chính sách và đưa lỗi kéo dài vào hàng đợi cho người vận… | feat-017, feat-032, feat-045, feat-074 |
| INT-03 | Đối chiếu định kỳ E Office với trạng thái nguồn về số chứng từ, số tiền, trạng thái phê duyệt/thanh toán; hiển thị sai lệch, chủ xử lý và lịch sử sửa. [YCG] | feat-046, feat-074 |
| INT-04 | Từng kết nối với hệ thống ngoài nêu rõ trách nhiệm nhà cung cấp E Office, Vinafco và nhà cung cấp nguồn về API, thử nghiệm, quyền, hỗ trợ lỗi và thay đổi phiên… | feat-002, feat-040, feat-045, feat-074, feat-079 |
| NFR-01 | Truy cập theo nguyên tắc quyền tối thiểu; mã hóa khi truyền và khi lưu theo thiết kế an toàn được phê duyệt; sao lưu và kiểm tra khôi phục định kỳ. [YCG, ĐX] | feat-003, feat-005, feat-009, feat-012, feat-065, feat-076, feat-078, feat-080 |
| NFR-02 | Chính sách mật khẩu/SSO, MFA theo mức rủi ro và thiết bị, giới hạn phiên, thu hồi quyền khi thôi việc được cấu hình và nghiệm thu theo chính sách Vinafco. [YCG] | feat-008, feat-076, feat-080 |
| NFR-03 | Chỉ tiêu tốc độ mở hồ sơ, tìm kiếm, xử lý OCR, người dùng đồng thời, dung lượng, thời gian hoạt động, RPO và RTO được đo trên khối lượng dữ liệu và hạ tầng do… | feat-077, feat-078, feat-080 |
| NFR-04 | Nhật ký ứng dụng, cảnh báo lỗi tích hợp, dung lượng lưu, lỗi lập chỉ mục và tác vụ sao lưu có bảng theo dõi; quy trình hỗ trợ và phân cấp sự cố được xác nhận.… | feat-003, feat-011, feat-018, feat-046, feat-075, feat-078, feat-079, feat-080 |
| NFR-05 | Có khả năng trích xuất dữ liệu phục vụ chuyển nhà cung cấp và đối soát sau chuyển đổi; chính sách thời hạn lưu theo loại tài liệu được pháp chế Vinafco xác nhận.… | feat-054, feat-058, feat-078, feat-080 |

## Truy vết UAT và quyết định

| Mã | Feature liên quan |
| --- | --- |
| UAT-01 | feat-005, feat-048, feat-080 |
| UAT-02 | feat-005, feat-034, feat-048, feat-080 |
| UAT-03 | feat-005, feat-059, feat-080 |
| UAT-04 | feat-005, feat-034, feat-066, feat-080 |
| UAT-05 | feat-005, feat-056, feat-059, feat-080 |
| UAT-06 | feat-005, feat-073, feat-080 |
| QD-01 | feat-001, feat-007, feat-024, feat-030, feat-034, feat-048, feat-050, feat-060, feat-067, feat-069, feat-079, feat-080, feat-081, feat-082, feat-085 |
| QD-02 | feat-001, feat-009, feat-010, feat-013, feat-019, feat-020, feat-021, feat-022, feat-023, feat-024, feat-025, feat-026, feat-027, feat-028, feat-029, feat-031, feat-032, feat-033, feat-034, feat-035, feat-036, feat-037, feat-038, feat-039, feat-040, feat-041, feat-042, feat-043, feat-044, feat-048, feat-049, feat-053, feat-062, feat-063, feat-064, feat-067, feat-068, feat-073, feat-080, feat-081 |
| QD-03 | feat-001, feat-002, feat-016, feat-036, feat-042, feat-044, feat-045, feat-046, feat-048, feat-049, feat-079, feat-080 |
| QD-04 | feat-001, feat-002, feat-008, feat-016, feat-018, feat-031, feat-032, feat-035, feat-040, feat-048, feat-050, feat-060, feat-061, feat-063, feat-064, feat-066, feat-068, feat-074, feat-079, feat-080, feat-084 |
| QD-05 | feat-001, feat-009, feat-011, feat-012, feat-013, feat-014, feat-015, feat-033, feat-039, feat-047, feat-050, feat-051, feat-052, feat-053, feat-054, feat-055, feat-056, feat-057, feat-058, feat-059, feat-065, feat-066, feat-076, feat-078, feat-079, feat-080 |
| QD-06 | feat-001, feat-002, feat-008, feat-012, feat-038, feat-051, feat-054, feat-055, feat-056, feat-058, feat-059, feat-060, feat-065, feat-066, feat-075, feat-076, feat-077, feat-078, feat-079, feat-080 |
| QD-07 | feat-001, feat-069, feat-070, feat-071, feat-072, feat-073, feat-080 |

Nghiệm thu cuối vẫn là feat-080 và phụ thuộc trực tiếp/gián tiếp vào toàn bộ 85 việc còn lại, gồm các việc UI bổ sung. Khi cắt phạm vi phải cập nhật baseline và dependency thay vì đánh dấu done giả.
