# Brief thiết kế UI E Office Vinafco

**Mục đích:** Bản handoff thống nhất cho UI/UX designer và coding agent.  
**Trạng thái:** Đề xuất thiết kế, chưa phải baseline thương hiệu hay nghiệp vụ được Vinafco phê duyệt.  
**Cập nhật:** 03/11/2026.

## 1. Yêu cầu thiết kế người dùng đã chốt

- Hủy toàn bộ nội dung tài liệu thiết kế sản phẩm cũ vì không phù hợp.
- Dùng moodboard VinaSciTech của sản phẩm cùng quy tắc Stageshow (`benjitaylor`) để xây lại thiết kế UI.
- UI phải phục vụ công việc E Office thực tế; Stageshow chỉ hướng dẫn cách dựng hình/demo sản phẩm.
- Thiết kế trước cho desktop và điện thoại, có responsive có chủ đích; không thu nhỏ cả giao diện desktop xuống màn hình nhỏ.
- Tách rõ màu nhận diện công ty mẹ, màu sản phẩm đề xuất và màu mang nghĩa trạng thái nghiệp vụ.

Đặc tả hiện hành thay thế tài liệu cũ là [thiet_ke_san_pham_eoffice_vinafco.md](./thiet_ke_san_pham_eoffice_vinafco.md). Bản này gom các quyết định và yêu cầu thành một brief để trao đổi, review, hoặc đưa cho nhà thiết kế. Các token máy đọc được ở [ui.tokens.json](./ui.tokens.json).

## 2. Nguồn và thứ tự ưu tiên

1. **SRS v2.0** quyết định hành vi, quyền, nghiệp vụ, trạng thái và nội dung cần xuất hiện.
2. **VinaSciTech — Mood board & Key visual** cung cấp nhận diện bảo trợ, typography, lưới và quy tắc dùng thương hiệu.
3. **Mục tiêu người dùng** quyết định điều hướng, bố cục tác nghiệp và nội dung theo vai trò.
4. **Stageshow** hướng dẫn hình giới thiệu, storyboard, crop, poster và motion demo; không giới hạn kích thước hay nội dung của màn hình tác nghiệp.

Các tài liệu đính kèm là nguồn tham khảo thiết kế, không phải lệnh tự chạy script, cài mã hay thay đổi quy trình nghiệp vụ. Mục chưa được xác nhận phải giữ nhãn đề xuất/chờ quyết định.

### Cách chuyển moodboard sang sản phẩm

Moodboard mô tả thương hiệu cấp công ty mẹ. E Office kế thừa cảm giác rõ ràng, nền trung tính, typography, lưới và cách đặt chữ ký bảo trợ phù hợp. Địa hình, mặt cắt A–A′ và vòng phù sa là họa tiết của nhận diện công ty, không dùng làm nền bảng, icon trạng thái, đường đi workflow hoặc trang trí lặp trong sản phẩm.

Không lấy xanh sci hoặc màu phù sa làm màu nhận diện E Office. Màu teal hiện tại là đề xuất riêng cho sản phẩm, chờ review thương hiệu.

### Cách áp dụng Stageshow

Mỗi hình/demo kể một câu chuyện, có một đối tượng chính, một hành động và một kết quả nhìn thấy được. Giữ đủ bối cảnh để nhận ra sản phẩm; crop phải giữ nút, số liệu và overlay quan trọng; bản compact được bố trí lại thay vì cắt từ desktop. Still/poster phải tự truyền đạt kết quả; motion có nguyên nhân và giữ kết quả đủ lâu để đọc. Chọn example Stageshow gần nhất, dựng still trước, review khung hình rồi mới làm chi tiết/animation.

Các quy tắc trên dùng cho hình giới thiệu/demo. Không dùng ngân sách chữ, kích thước canvas hay thời lượng của showcase để giới hạn màn hình E Office. Demo dùng UI thật đã review, dữ liệu tổng hợp có nhãn, và không gọi adapter giao dịch thật.

## 3. Mục tiêu và nguyên tắc trải nghiệm

E Office là bàn làm việc giúp người dùng biết hồ sơ đang ở đâu, đọc được căn cứ, hiểu đúng trạng thái và thực hiện bước tiếp theo trên đúng phiên bản.

- **Chứng từ ở trung tâm:** Tài liệu, revision, nguồn dữ liệu và căn cứ quyết định luôn có thể truy cập từ hồ sơ.
- **Context rõ trước hành động:** Người dùng luôn thấy vai trò/pháp nhân đang thao tác; context không được ẩn trong menu.
- **Trạng thái trung thực:** “Đã gửi”, “đã nhận”, “đã xác nhận”, “đã ký” và “đã thanh toán” là các trạng thái khác nhau.
- **Một hành động chính mỗi vùng:** CTA chính rõ ràng; hành động phụ ghi bằng chữ và không cạnh tranh thị giác.
- **Mật độ vừa đủ:** Chỉ dùng card khi cần nhóm thông tin; không biến trang nghiệp vụ thành dashboard đầy thẻ.
- **Lỗi có đường phục hồi:** Giữ dữ liệu đã nhập; nêu lỗi gần field/vùng liên quan và chỉ rõ bước kế tiếp.
- **Quyền được phản ánh trong UI:** Không để lộ tên, số lượng, quan hệ hay metadata của đối tượng người dùng không được phép xem.

## 4. Hệ thống thị giác và tokens

### Màu

| Token | Giá trị | Dùng cho |
| --- | --- | --- |
| Canvas | `#F5F4EF` | Nền tổng thể, sắc giấy trung tính |
| Surface | `#FFFFFF` | Hồ sơ, bảng, form, tài liệu |
| Surface subtle | `#F0F3F6` | Vùng hỗ trợ, hàng hover |
| Navigation | `#001A45` | Thanh điều hướng biển sâu |
| Text | `#1B2233` | Nội dung chính |
| Text secondary | `#526174` | Nội dung phụ cần đọc |
| Text on dark | `#F5F4EF` | Chữ trên navigation |
| Border | `#D6DDE5` | Phân nhóm bề mặt |
| Input border | `#718096` | Viền control cần nhận biết |
| Product accent | `#0F766E` | CTA chính, active; **đề xuất chờ duyệt** |
| Product accent hover | `#115E59` | Hover/focus cùng họ màu |
| Product accent soft | `#E6F4F1` | Vùng chọn, kèm nhãn/dấu hiệu |
| Product accent on dark | `#5EEAD4` | Accent trên nền tối khi cần |
| Success | `#166534` / `#DCFCE7` | Kết quả xác nhận, luôn kèm chữ/icon |
| Warning | `#854D0E` / `#FEF3C7` | Cần kiểm tra/bổ sung |
| Danger | `#B91C1C` / `#FEE2E2` | Lỗi, chặn hoặc sai lệch |
| Info | `#1E40AF` / `#DBEAFE` | Thông tin trung tính/chờ nguồn |

Màu không phải dấu hiệu duy nhất: badge và trạng thái luôn có chữ, icon/hình học nhất quán. Không dùng màu xanh/vàng/đỏ để ngụ ý “đạt” khi nghiệp vụ chưa xác nhận.

### Typography

- **Be Vietnam Pro:** chữ giao diện, body 14–16px, line-height 1.5; body 400, tiêu đề 600.
- **Tiêu đề:** desktop 24–28px; mobile 20–24px.
- **IBM Plex Mono:** mã hồ sơ, định danh và chuỗi cần so sánh; số tiền dùng tabular numerals, căn phải.
- **Source Serif 4:** trích dẫn trong nội dung dài; không dùng cho nút hoặc tiêu đề bảng.
- Nhãn form dùng sentence case, khoảng 14px. Không áp chữ IN HOA/mono của key visual cho mọi nhãn.

### Kích thước và nhịp

- Spacing: `4, 8, 12, 16, 24, 32, 48px`; nhịp chính 8px, 4px là bước phụ.
- Sidebar desktop: `224px`; header: `64px`; content padding đề xuất `24–32px`.
- Control desktop: cao `40px`; mục tiêu vùng chạm mobile tối thiểu `44px`.
- Radius: control `8px`, panel `12px`; pill chỉ cho badge.
- Shadow dành cho overlay/bề mặt nổi thật sự; không trang trí card bằng shadow dày.
- Không dùng gradient lớn, glass, glow, hạt sáng hoặc icon AI để lấp khoảng trống.

### Trạng thái token

Toàn bộ token hiện là **đề xuất engineering**. Teal `#0F766E` không xuất hiện trong moodboard và chưa phải màu thương hiệu được duyệt. Logo Vinafco chỉ dùng file gốc do chủ sản phẩm cung cấp; khi chưa có, dùng tên sản phẩm bằng chữ, không tự dựng lại wordmark. Dòng “một sản phẩm của VinaSciTech” chỉ đặt gọn ở đăng nhập, Giới thiệu và ấn phẩm; cần review nhận diện trước phát hành.

## 5. Điều hướng và khung ứng dụng

### Desktop

Sidebar rộng 224px; header 64px. Nhóm điều hướng dự kiến: Bàn làm việc, Hồ sơ, Chờ tôi duyệt, Tài liệu, Tài chính, Văn bản, Công việc & dự án, Tiện ích. Mục quản trị chỉ xuất hiện theo quyền. Tối đa hai cấp; breadcrumb chỉ dùng khi giúp định vị hồ sơ hoặc quản trị lồng nhau.

Header hiển thị tên pháp nhân/vai trò hiện tại, bộ chuyển context, tìm kiếm và menu người dùng. Thông báo/số lượng/kết quả tìm chỉ tính dữ liệu được phép.

### Mobile

Không thu nhỏ sidebar desktop. Dùng drawer hoặc điều hướng gọn theo trang; ba đích thường dùng là Chờ duyệt, Hồ sơ và Tài khoản. Không hiện drawer và bottom navigation đồng thời. CTA cố định phải tránh safe-area và bàn phím; action bar không che tài liệu hay nội dung cần quyết định.

### Context pháp nhân/vai trò

Context đang dùng phải luôn nhìn thấy trước khi duyệt hoặc quyết định. Chuyển context phải xóa/đóng dữ liệu không còn quyền xem. Khi hết quyền, phiên hoặc ủy quyền, UI giải thích hành động tiếp theo mà không để lộ hồ sơ ngoài quyền.

## 6. Màn hình ưu tiên

### Hộp duyệt — Inbox

- Desktop: bố cục danh sách–chi tiết. Ở khung 1440px, nav khoảng 224px, danh sách khoảng 360px, phần chi tiết linh hoạt.
- Tiêu đề “Chờ tôi duyệt”; lọc theo pháp nhân, loại hồ sơ, hạn và trạng thái.
- Hàng danh sách: tên việc, mã hồ sơ, người trình, số tiền khi có, hạn và trạng thái.
- Chi tiết theo thứ tự: tên/context → điều cần quyết định → cảnh báo → căn cứ/tệp → lịch sử → hành động.
- CTA đổi theo bước (“Phê duyệt”, “Tiếp tục ký số”); “Trả bổ sung” và “Từ chối” là action phụ có nhãn rõ. Lý do nhập theo policy.
- Mobile: danh sách và chi tiết là màn riêng. Trước khi gửi luôn thấy vai trò, pháp nhân và revision.

### Hồ sơ tổng hợp — Dossier

- Header: tên, mã, pháp nhân, trạng thái; meta gồm chủ hồ sơ, kỳ và cập nhật gần nhất.
- Tab: Tổng quan, Chứng từ, Quy trình, Lịch sử. Việc cần làm và quyết định mới nhất ở Tổng quan.
- Chứng từ có loại, tên, phiên bản, chất lượng, trạng thái ký và nguồn.
- Timeline có actor, hành động, thời điểm và kết quả; mặc định sự kiện quan trọng, có thể lọc toàn bộ.
- Khi bản trình đổi, hiển thị “Hồ sơ đã thay đổi”, diff tiền/đối tác/thụ hưởng/tài liệu; vô hiệu hành động duyệt trên revision cũ.

### Đối soát tài chính — Match

- Desktop: tài liệu/bản thể hiện bên trái; kết quả đối chiếu bên phải. Header có mã hồ sơ, tổng tiền và trạng thái.
- Bảng: Trường, Hợp đồng/đơn mua, Nghiệm thu, Hóa đơn, Kết quả. Mở rộng một dòng để đọc nguồn và rule/ngưỡng.
- Kết quả riêng biệt: Khớp, Trong ngưỡng, Vượt ngưỡng, Thiếu dữ liệu, Không áp dụng, Chưa xác nhận.
- Chênh lệch phải có số cụ thể, đơn vị, nguồn và cách xử lý; ngoại lệ không được hiển thị thành đạt chuẩn.
- Mobile: xếp từng trường dọc có nhãn nguồn; tách tab Chứng từ/Đối chiếu, tránh ép hai cột desktop lên điện thoại.

### Upload, XML và OCR

- Kéo thả/tải lên nêu định dạng và dung lượng tối đa từ cấu hình.
- Trạng thái: Đang tải, Đang kiểm tra, Cần bổ sung, Cần xác nhận, Đã xác nhận, Không đọc được.
- Viewer nguồn và field cạnh nhau; chọn field làm nổi vùng tương ứng nếu có tọa độ.
- Hiển thị nguồn và confidence OCR khi có; lưu giá trị trước/sau khi sửa.
- Parse thành công, người xác nhận dữ liệu và xác minh chữ ký là ba trạng thái riêng.

### Tìm kiếm và kho tài liệu — Search/DMS

- Toolbar gọn: từ khóa, loại, pháp nhân, đối tác/kỳ; bộ lọc nâng cao mở khi cần.
- Bảng: tên, loại, version, hiệu lực, người quản lý, cập nhật. Viewer riêng với zoom/download có nhãn.
- Ngoài quyền: kết quả hoàn toàn vắng mặt—không hàng mờ, tên che, count bí mật hay liên kết đồ thị tới hồ sơ ẩn.
- Empty state chỉ nói không tìm thấy trong phạm vi được phép; không xác nhận hồ sơ bị cấm có tồn tại.
- Quan hệ tài liệu mặc định là danh sách; graph là góc nhìn tùy chọn khi thực sự hữu ích. Bản hoàn tất ghim version và manifest.

### Mobile duyệt/ký

- Tóm tắt trước: việc cần quyết định, người trình, tiền khi áp dụng, hạn, cảnh báo.
- Ngân sách chỉ hiện khi có nguồn và kỳ; tài liệu, lịch sử, căn cứ ủy quyền mở theo nhóm.
- Trạng thái gửi gồm: Đang gửi, Đang chờ xác nhận, Đã xác nhận, Chưa xác định kết quả—Kiểm tra trạng thái, Không gửi được.
- Timeout phải tra operation ID trước khi cho gửi lại; offline chỉ đọc phần cho phép và có nhãn thời điểm cập nhật.
- Không hiện “thành công” chỉ vì request đã gửi; “đã ký” chỉ sau xác minh kết quả đúng revision.

### Các nhóm màn hình tiếp theo

Hợp đồng/công văn dùng list-detail-viewer-timeline; công việc/dự án dùng list hoặc board theo tác vụ; xe/phòng/công tác dùng lịch + danh sách; quản trị dùng form/version/diff/publish; vận hành tích hợp dùng issue table + timeline; kiểm toán là danh sách chỉ đọc và manifest. Mỗi nhóm giữ context, quyền và trạng thái nguồn theo SRS.

## 7. Component dùng chung

`AppShell`, `ContextSwitcher`, `PageHeader`, `FilterBar`, `DataTable`, `StatusBadge`, `MoneyValue`, `DocumentViewer`, `VersionBadge`, `SourceReference`, `Timeline`, `DiffPanel`, `FormField`, `ValidationSummary`, `ApprovalActionBar`, `ConfirmDialog`, `AsyncOperationStatus`, `EmptyState`.

- DataTable: header/body cùng track; tiền căn phải; nhãn cột không biến mất; sorting có chỉ báo. Mã/đơn vị không bị cắt mất; tên dài wrap hoặc ellipsis có cách xem đầy đủ.
- Hover khác selection; row action có tên truy cập, không chỉ icon ba chấm.
- Form có label thường trực, bắt buộc/helper/error cạnh field và summary lỗi có thể focus; lỗi lưu không xóa nội dung đã nhập.
- Dialog quản lý focus và trả focus về trigger; toast không là nơi duy nhất chứa kết quả nghiệp vụ.
- Một icon family nhất quán (ví dụ Heroicons, chờ review); không dùng emoji điều hướng, không bịa logo bằng ký tự.

## 8. Ma trận trạng thái UI

| Tình huống | Phản hồi | Hành động phục hồi |
| --- | --- | --- |
| Loading | Skeleton đúng cấu trúc nội dung | Không bịa số liệu |
| Empty ban đầu | Giải thích và CTA tạo nếu có quyền | Tạo hồ sơ/xem hướng dẫn |
| Empty do lọc | Giữ filter và nêu chưa có kết quả | Sửa/xóa lọc |
| Validation error | Lỗi tại field + summary, giữ dữ liệu | Sửa field |
| Forbidden | Thông báo chung, không lộ metadata | Quay lại vùng hợp lệ |
| Stale revision | Banner thay đổi + diff nếu có quyền | Lấy bản mới và review lại |
| Mất mạng | Gắn nhãn dữ liệu cũ/thao tác chưa xác nhận | Kiểm tra trạng thái/kết nối lại |
| Chờ Bravo/CA | Pending, operation ID, giờ cập nhật | Theo dõi; chưa coi là hoàn tất |
| Unknown | Nêu chưa rõ và cách kiểm tra | Tra nguồn/đối soát, không retry mù |
| Thành công | Chỉ ghi kết quả đã được xác nhận đúng nghĩa | Mở hồ sơ hoặc việc tiếp theo |

## 9. Responsive, accessibility và motion

- Review tại `1440`, `1280`, `768`, `390` và `320px`; breakpoint gợi ý: `1024px` sang một cột, `768px` sang navigation drawer. Điều chỉnh sau khi thử nội dung tiếng Việt thật.
- Không dùng transform để thu desktop. Bảng có nhãn và đơn vị; trên mobile đổi bố cục khi hai cột không còn đọc được.
- Mục tiêu tương phản: chữ thường `4.5:1`, chữ lớn `3:1`, viền control/focus cần nhận biết `3:1`; kiểm từng cặp token thực dùng.
- Focus rõ, tab order hợp lý, keyboard và screen reader đọc được label/status/error. Dùng HTML semantic trong UI thật.
- Kiểm zoom 200%, dấu tiếng Việt, tên dài, số tiền lớn, format ngày, keyboard và safe-area. Hỗ trợ reduced motion; không phụ thuộc animation để hiểu trạng thái.
- Motion tác nghiệp có lý do: mở panel/tab, báo lỗi, kết quả; timing đề xuất `120–180ms` hover/focus và `180–240ms` overlay, cần review.
- Không chạy animation nền trên bảng tài chính. Busy chặn double click ở UI; chống lặp thật thuộc API. Giữ kết quả đọc được trong cùng vùng sau phản hồi.

## 10. Showcase/demo theo Stageshow

| Cảnh minh họa | Hành động duy nhất | Kết quả phải thấy |
| --- | --- | --- |
| Hồ sơ cần bổ sung | Mở cảnh báo và trả lại có lý do | Chờ bổ sung cùng lý do |
| Đối chiếu lệch một trường | Mở chênh lệch số lượng | Giá trị từng nguồn và độ lệch |
| Nhận xác nhận nguồn | Theo dõi thao tác gửi đến ack | Đã xác nhận cùng ID nguồn mẫu |

Chỉ chọn cảnh sau khi UI thật được review; không mặc định giữ showcase cũ. Gói demo gồm still desktop/compact, poster reduced-motion, contact sheet/loop nếu có animation, example tham khảo và nội dung đã kiểm. Dữ liệu demo phải có nhãn mô phỏng; không gọi adapter thật, không trình bày trạng thái chưa xác nhận như sự thật.

## 11. Đầu ra để designer/coding agent bàn giao

1. Sitemap và flow theo người lập, người duyệt, kế toán, quản trị; thể hiện đường quay lại, context pháp nhân/vai trò và action chính.
2. Token/color/type/spacing styles dùng lại; ghi rõ token nào là đề xuất chờ thương hiệu.
3. Màn review đầu: Inbox, Dossier, Match và mobile detail; desktop/mobile dựng theo bố cục riêng.
4. Component dùng chung và trạng thái loading/empty/error/forbidden/stale/pending/unknown/success.
5. Review ảnh tối thiểu `1440px` và `390px`, thêm widths trong mục responsive; nội dung tiếng Việt, tên dài, tiền lớn, dữ liệu stale và timeout.
6. Ghi lại focus/keyboard/contrast/reflow review, các giới hạn chưa kiểm và quyết định thương hiệu/nghiệp vụ còn mở.
7. Chỉ làm showcase sau khi UI tác nghiệp được duyệt; poster và compact phải đọc được mà không cần xem animation.

## 12. Mapping với backlog

| Feature | Đầu ra UI |
| --- | --- |
| `feat-081` | Sitemap, navigation, flow theo vai trò/context |
| `feat-006` | Tokens, AppShell và component foundations |
| `feat-082` | Review Inbox, Dossier, Match, mobile detail |
| `feat-083` | Component UI và ma trận trạng thái |
| `feat-084` | Responsive cho luồng đã triển khai |
| `feat-085` | Review UI toàn phạm vi và accessibility |
| `feat-086` | Demo/visual Stageshow từ UI đã review |

Backlog chi tiết và dependencies ở [feature_list.proposed.json](../planning/feature_list.proposed.json); tài liệu thiết kế đầy đủ hiện hành ở [thiet_ke_san_pham_eoffice_vinafco.md](./thiet_ke_san_pham_eoffice_vinafco.md). UI review đánh giá bố cục, trạng thái và usability; không thay thế nghiệm thu tài chính, phân quyền hoặc tích hợp.

## 13. Những điểm còn chờ xác nhận

- Màu teal sản phẩm và quy tắc chữ ký “một sản phẩm của VinaSciTech” cần brand review.
- Tài sản logo Vinafco gốc chưa có trong workspace; không tự dựng lại.
- QD-01/QD-02 về pháp nhân, vai trò và quy trình ưu tiên chưa được Vinafco duyệt; flow đang là đề xuất.
- Tích hợp SSO/HR, Bravo, TMS/WMS, CA/HSM chưa có sandbox/API; UI dùng trạng thái fixture, không phải trạng thái live.
- Dark mode chưa thuộc phạm vi đã chốt; cần thiết kế/review riêng nếu được bổ sung.

## Nguồn tham khảo

- VinaSciTech — Mood board & Key visual, bản thảo ngày 01/10/2026 (nguồn nhận diện bảo trợ).
- VFC E-Office SRS v2.0 (hành vi, quyền, trạng thái và yêu cầu nghiệp vụ).
- [Stageshow — skill gốc](https://github.com/benjitaylor/skills/blob/main/stageshow/SKILL.md), [Craft](https://github.com/benjitaylor/skills/blob/main/stageshow/references/craft.md), [Framing](https://github.com/benjitaylor/skills/blob/main/stageshow/references/framing.md).
- [Đặc tả UI E Office](./thiet_ke_san_pham_eoffice_vinafco.md) và [UI tokens](./ui.tokens.json).
