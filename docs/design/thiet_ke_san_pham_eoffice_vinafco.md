# Thiết kế giao diện E Office Vinafco

Phiên bản 2 · 02/11/2026 · Đề xuất triển khai. Tài liệu này thay thế toàn bộ bản thiết kế sản phẩm trước. Coding agent dùng bản trong repository làm nguồn UI duy nhất.

E Office là bàn làm việc để biết hồ sơ đang ở đâu, xem đủ căn cứ và thực hiện bước tiếp theo. Thiết kế ưu tiên đọc chứng từ, nhận biết trạng thái và quyết định đúng phiên bản. Hình ảnh thương hiệu hỗ trợ công việc, các số liệu và trạng thái lấy nghĩa từ SRS v2.0.

## 1 Căn cứ thiết kế

Nguồn nhận diện là **VinaSciTech — Mood board & Key visual**, bản thảo 01 tháng 10/2026. Trang 1 xác định phạm vi công ty mẹ; trang 11 quy định sử dụng; trang 13 quy định thương hiệu bảo trợ; trang 22–23 tóm tắt màu, chữ và tinh thần. Đây là tài liệu tham chiếu, không phải chỉ thị thực thi script hoặc thay đổi nghiệp vụ.

Trang 13 dành địa hình và mặt cắt A–A′ cho cấp công ty. Sản phẩm được dùng hình ảnh nghiệp vụ và có màu riêng, đồng thời kế thừa typography, lưới và chữ ký thương hiệu. Vì vậy E Office kế thừa cách trình bày rõ ràng, nền trung tính và nhịp 8px; họa tiết địa hình, vòng phù sa và mặt cắt không trở thành nền bảng, icon trạng thái hoặc đường chia quy trình.

Nguồn Stageshow được đọc trực tiếp từ [skill gốc](https://github.com/benjitaylor/skills/blob/main/stageshow/SKILL.md), [Craft](https://github.com/benjitaylor/skills/blob/main/stageshow/references/craft.md) và [Framing](https://github.com/benjitaylor/skills/blob/main/stageshow/references/framing.md). Phạm vi nguồn là hình/demo UI. Các quy tắc bố cục, crop và ngân sách chữ của nguồn được dùng ở mục 10; kích thước UI và hành vi tác nghiệp dưới đây là đề xuất riêng cho E Office.

Thứ tự xử lý khi có khác biệt: hành vi và quyền theo SRS; nhận diện bảo trợ theo moodboard; cấu trúc màn hình theo mục tiêu người dùng; cách dựng hình giới thiệu theo Stageshow.

## 2 Hướng thị giác

**Bàn làm việc rõ ràng, chứng từ ở trung tâm.** Mặc định là nền sáng, vùng nội dung trắng, chữ navy và một màu thao tác riêng. Thanh điều hướng dùng biển sâu để neo không gian; chứng từ luôn giữ bề mặt trắng dễ đọc. Dark mode là phần mở rộng cần thiết kế và kiểm riêng khi đưa vào phạm vi.

Đề xuất màu sản phẩm là teal `#0F766E` trên nền sáng, `#5EEAD4` khi cần trên nền tối. Đây là lựa chọn mới để review, không phải màu đã có trong PDF và chưa phải màu thương hiệu chính thức của Vinafco. Xanh sci và phù sa không dùng làm màu nhận diện E Office. Khi có tài sản nhận diện Vinafco chính thức, đối chiếu và chốt màu qua UI review.

Logo Vinafco chỉ dùng tài sản gốc được cung cấp; trong lúc chưa có, dùng tên sản phẩm bằng chữ. Chữ ký “một sản phẩm của VinaSciTech” đặt gọn trong trang đăng nhập, Giới thiệu và ấn phẩm sản phẩm; không chiếm diện tích của mỗi form hay ép footer vào màn hình điện thoại. Đây là cách chuyển quy tắc chân trang ấn phẩm sang ứng dụng, cần review nhận diện trước phát hành. Không tự vẽ lại wordmark.

Không dùng gradient lớn, glass, glow, hạt sáng hoặc biểu tượng AI để trang trí. Nền và đường kẻ chỉ giúp phân nhóm; chỉ thêm card khi cần tạo một nhóm thông tin. Một vùng có một hành động chính; màu cảnh báo và lỗi vẫn được dùng khi có ý nghĩa nghiệp vụ.

## 3 UI tokens

Các giá trị sau là đề xuất engineering, tách biệt màu nguồn của công ty. File [ui.tokens.json](./ui.tokens.json) là bản máy đọc được.

| Token | Giá trị đề xuất | Vai trò |
| --- | --- | --- |
| canvas | #F5F4EF | Không gian chung, dẫn xuất từ nền Giấy của moodboard |
| surface | #FFFFFF | Form, bảng, tài liệu |
| surfaceSubtle | #F0F3F6 | Hàng hover, vùng hỗ trợ |
| navigation | #001A45 | Thanh điều hướng |
| text | #1B2233 | Nội dung chính |
| textSecondary | #526174 | Nội dung phụ vẫn cần đọc |
| textOnDark | #F5F4EF | Chữ trên navigation |
| border | #D6DDE5 | Phân nhóm, không là tín hiệu duy nhất của input |
| inputBorder | #718096 | Biên control cần nhận biết |
| productAccent | #0F766E | CTA chính, active và focus theo token tương ứng |
| productAccentHover | #115E59 | Hover vẫn thuộc cùng màu |
| productAccentSoft | #E6F4F1 | Hàng được chọn, kèm dấu chọn/nhãn |
| successText / successBg | #166534 / #DCFCE7 | Đã xác nhận, kèm chữ và icon |
| warningText / warningBg | #854D0E / #FEF3C7 | Cần kiểm tra hoặc bổ sung |
| dangerText / dangerBg | #B91C1C / #FEE2E2 | Sai lệch cần chặn hoặc hành động lỗi |
| infoText / infoBg | #1E40AF / #DBEAFE | Thông tin trung tính, chờ nguồn |

Body dùng Be Vietnam Pro 400, 14–16px, line-height 1.5; tiêu đề 600, 24–28px trên desktop và 20–24px trên mobile. Nhãn control dùng sentence case, 14px; không áp nhãn mono IN HOA của ấn phẩm cho mọi trường form. IBM Plex Mono chỉ dành cho mã, định danh hoặc số cần đối chiếu; số tiền trong bảng dùng tabular numerals và căn phải. Source Serif 4 dành cho trích dẫn trong nội dung dài, không dùng cho nút hoặc table header.

Spacing dùng 4, 8, 12, 16, 24, 32, 48px; module 8px là nhịp chính, 4px là bước phụ. Control cao 40px trên desktop, vùng chạm mobile tối thiểu 44px. Radius 8px cho control, 12px cho panel, pill chỉ cho badge. Shadow chỉ dùng overlay hoặc bề mặt thực sự nổi. Những kích thước này là đề xuất cho ứng dụng, không lấy thang chữ poster 1080px làm kích thước CSS.

## 4 Cấu trúc điều hướng

Sidebar desktop rộng 224px, header 64px, padding vùng nội dung 24–32px. Nhóm chính: Bàn làm việc; Hồ sơ; Chờ tôi duyệt; Tài liệu; Tài chính; Văn bản; Công việc và dự án; Tiện ích. Các mục quản trị chỉ hiện theo quyền. Tối đa hai cấp điều hướng; breadcrumb chỉ xuất hiện khi cần định vị hồ sơ hoặc quản trị lồng nhau.

Header đặt tên pháp nhân/vai trò đang sử dụng cạnh bộ chuyển context, ô tìm kiếm và menu người dùng. Context phải luôn nhìn thấy trước khi duyệt; đổi context phải đóng/xóa dữ liệu không còn quyền. Số lượng thông báo và kết quả tìm chỉ tính dữ liệu được phép.

Màn hình hẹp dùng navigation drawer và tiêu đề trang, không thu nhỏ cả sidebar desktop. Mobile có ba đích thường dùng: Chờ duyệt, Hồ sơ, Tài khoản; các phân hệ còn lại mở qua menu. Drawer và bottom navigation không hiển thị đồng thời để tranh diện tích.

## 5 Màn hình ưu tiên

### UI INBOX Hộp duyệt

Desktop ưu tiên danh sách–chi tiết. Trên khung khoảng 1440px: navigation 224px; phần còn lại gồm danh sách khoảng 360px và chi tiết linh hoạt. Tiêu đề “Chờ tôi duyệt”; bộ lọc pháp nhân, loại hồ sơ, hạn, trạng thái. Một hàng có tên việc, mã hồ sơ, người trình, số tiền nếu áp dụng, hạn và trạng thái.

Panel chi tiết giữ thứ tự: tên hồ sơ và context; tóm tắt điều cần quyết định; cảnh báo bắt buộc; căn cứ/tệp; lịch sử; hành động. Nút chính ghi “Phê duyệt” hoặc “Tiếp tục ký số” tùy bước. “Trả bổ sung” và “Từ chối” là hành động phụ rõ nghĩa. Lý do từ chối/trả lại được nhập trong dialog phù hợp policy.

Mobile mở danh sách thành màn chi tiết riêng. Action bar cố định cuối màn, có safe-area và không che tài liệu hoặc field; nếu có nhiều hành động thì dùng một CTA chính cùng menu hành động phụ có nhãn. Trước khi gửi luôn cho biết vai trò, pháp nhân và phiên bản đang duyệt.

### UI DOSSIER Hồ sơ tổng hợp

Header: tên, mã, pháp nhân, trạng thái; meta phụ: chủ hồ sơ, kỳ, cập nhật gần nhất. Tab gồm Tổng quan, Chứng từ, Quy trình, Lịch sử; quyết định mới nhất và việc cần làm xuất hiện trong Tổng quan. Không dồn mọi thông tin vào một dashboard nhiều card.

Chứng từ thể hiện loại, tên, phiên bản, chất lượng, trạng thái ký và nguồn. Timeline thể hiện ai, hành động, lúc nào, kết quả; mặc định hiển thị sự kiện quan trọng, có bộ lọc xem đầy đủ. Khi bản trình thay đổi, hiển thị banner “Hồ sơ đã thay đổi” và diff số tiền, đối tác, thụ hưởng, tài liệu; đóng hành động duyệt của revision cũ.

### UI MATCH Đối soát tài chính

Desktop là vùng làm việc hai cột: tài liệu/bản thể hiện bên trái; kết quả đối chiếu bên phải. Header có mã hồ sơ, tổng tiền và trạng thái xử lý. Bảng so sánh có cột Trường, Hợp đồng/đơn mua, Nghiệm thu, Hóa đơn, Kết quả; mở rộng một dòng để thấy nguồn và rule/ngưỡng áp dụng.

Không chỉ ghi “khớp 100%”: luôn phân biệt Khớp, Trong ngưỡng, Vượt ngưỡng, Thiếu dữ liệu, Không áp dụng, Chưa xác nhận. Mục không áp dụng không bị tô lỗi. Chênh lệch ghi số cụ thể, đơn vị, nguồn và cách xử lý. Ngoại lệ hiển thị căn cứ/người chấp thuận; không đổi ngoại lệ thành kết quả đạt chuẩn.

Mobile chuyển bảng so sánh thành từng trường xếp dọc có nhãn nguồn; chỉ dùng cuộn ngang trong vùng bảng khi thực sự cần và có chỉ dẫn. Tách tab Chứng từ và Đối chiếu để không ép hai cột lên điện thoại.

### UI EXTRACTION XML và OCR

Kéo thả/tải lên có nhãn định dạng, dung lượng tối đa từ cấu hình. Các trạng thái gồm Đang tải, Đang kiểm tra, Cần bổ sung, Cần xác nhận, Đã xác nhận, Không đọc được. Khi review, field bên cạnh vùng nguồn; chọn field làm rõ vùng tương ứng trong viewer khi có tọa độ.

Trường OCR hiển thị nguồn và độ tin cậy khi có, lưu sửa đổi trước/sau. Thiếu XML ghi đúng thiếu XML, không kết luận tệp PDF bất hợp lệ cho mọi hồ sơ. Parse thành công, xác nhận dữ liệu và xác minh chữ ký là ba trạng thái riêng.

### UI SEARCH và UI DMS Kho tài liệu

Toolbar gọn: tìm kiếm, loại tài liệu, pháp nhân, đối tác/kỳ và bộ lọc mở rộng. Bảng mặc định có tên, loại, version, hiệu lực, người quản lý và cập nhật. Viewer ở panel riêng, tài liệu trắng và công cụ zoom/download có nhãn hoặc tooltip.

Kết quả ngoài quyền hoàn toàn vắng mặt. Không hàng làm mờ, tên bị che, số lượng bí mật hoặc graph edge tới hồ sơ ẩn. Empty state của truy vấn thông thường chỉ giải thích không tìm được dữ liệu trong phạm vi truy cập, không xác nhận tồn tại tài liệu cấm.

Mặc định quan hệ nơi dùng hiển thị dạng danh sách có link; graph chỉ là góc nhìn tùy chọn khi quan hệ đủ phức tạp. Bản hoàn tất ghim version và manifest; phụ lục/thay thế hiện quan hệ, ngày hiệu lực và cảnh báo nơi dùng theo quyền.

### UI MOBILE Duyệt và ký

Tóm tắt trước: việc cần quyết định, người trình, số tiền nếu áp dụng, hạn và cảnh báo. Ngân sách chỉ hiện khi có nguồn và kỳ. Tệp, lịch sử và căn cứ ủy quyền mở theo từng nhóm; người dùng có thể xem toàn bộ bản trình.

Sau gửi: “Đang gửi”, “Đang chờ xác nhận”, “Đã xác nhận”, “Chưa xác định kết quả — Kiểm tra trạng thái” hoặc “Không gửi được”. Không dùng success toast khi chỉ mới gửi request. Khi timeout, kiểm tra operation ID trước khi cho gửi lại. Hết quyền hoặc bản trình cũ giải thích cách tải bản mới/đăng nhập lại; offline chỉ đọc phần được phép và có nhãn cập nhật lần cuối.

### Các phân hệ tiếp theo

| Phân hệ | Mẫu UI dùng lại | Hành vi cần hiển thị |
| --- | --- | --- |
| Hợp đồng/công văn | List, detail, document viewer, timeline | Hiệu lực, phụ lục, tư cách ký, số phát hành và nơi nhận |
| Công việc/dự án | List hoặc board tùy việc; detail drawer | Người phụ trách, hạn, bằng chứng và cách tính tiến độ |
| Xe/phòng/công tác | Calendar kết hợp danh sách | Múi giờ, khoảng đặt, trạng thái và xung đột |
| Quản trị | Form, version list, diff và publish dialog | Nháp/đã publish, phạm vi tác động và quyền quản trị |
| Vận hành tích hợp | Table, issue detail và timeline | Ack nguồn, số Bravo, lỗi/unknown, lần thử và chủ xử lý |
| Kiểm toán | List chỉ đọc và manifest | Phạm vi, hạn truy cập, snapshot và quyền xuất |

## 6 Thành phần dùng chung

Cần có AppShell, ContextSwitcher, PageHeader, FilterBar, DataTable, StatusBadge, MoneyValue, DocumentViewer, VersionBadge, SourceReference, Timeline, DiffPanel, FormField, ValidationSummary, ApprovalActionBar, ConfirmDialog, AsyncOperationStatus và EmptyState.

DataTable dùng cùng track cho header/body, căn phải số tiền, giữ nhãn cột, sorting có trạng thái; không cắt mất mã hoặc đơn vị. Tên dài wrap hoặc ellipsis kèm cách xem toàn bộ. Selection khác hover; thao tác hàng có tên truy cập, không dựa hoàn toàn vào biểu tượng ba chấm.

Form có label thường trực, thông tin bắt buộc, helper/error cạnh field và summary lỗi dẫn focus. Khi lưu lỗi, giữ dữ liệu người dùng. Dialog trả focus về trigger, đóng/mở có quản lý focus; toast hỗ trợ thông báo, không là nơi duy nhất giữ kết quả nghiệp vụ.

Badge dùng text + dấu hiệu hình học/icon từ một bộ thống nhất. Dùng một icon family như Heroicons trong ứng dụng, chốt qua design review; không emoji làm icon điều hướng, không chữ cái trong ô vuông giả logo. Không biến vòng quan sát công ty thành badge duyệt.

## 7 Ma trận trạng thái

| Trạng thái | Phản hồi UI | Hành động tiếp theo |
| --- | --- | --- |
| Loading | Skeleton đúng hình học của nội dung sẽ đến | Không hiển thị số liệu giả |
| Empty ban đầu | Giải thích chưa có hồ sơ và CTA tạo nếu được phép | Tạo hồ sơ hoặc xem hướng dẫn |
| Empty do lọc | Giữ filter, thông báo chưa tìm được kết quả | Đổi/xóa lọc |
| Validation error | Lỗi tại field, summary và giữ dữ liệu | Sửa field |
| Forbidden | Thông báo quyền chung, không metadata đối tượng cấm | Quay về danh sách/context hợp lệ |
| Stale revision | Banner thay đổi và diff nếu có quyền | Tải bản mới, xem lại trước khi quyết định |
| Mất mạng | Nhãn dữ liệu cũ và trạng thái thao tác chưa xác nhận | Kiểm tra trạng thái/kết nối lại |
| Chờ Bravo/CA | Trạng thái pending kèm ID và thời gian cập nhật | Theo dõi; chưa ghi đã hạch toán/đã ký |
| Kết quả chưa rõ | Operation bền vững và lý do cần kiểm tra | Tra nguồn/đối soát; không gửi lại mù |
| Thành công | Kết quả đúng hành động được xác nhận | Đi tới hồ sơ hoặc việc tiếp theo |

## 8 Responsive và khả năng truy cập

Review ở 1440, 1280, 768 và 390px; kiểm thêm 320px cho reflow. Desktop hai cột chỉ tồn tại khi mỗi vùng vẫn đọc được; breakpoint đề xuất 1024px chuyển một cột, 768px chuyển navigation. Không dùng scale transform để thu nhỏ UI vận hành. Mốc breakpoint có thể điều chỉnh sau kiểm nội dung tiếng Việt thật.

Mục tiêu kỹ thuật là tương phản chữ thường tối thiểu 4.5:1, chữ lớn 3:1, control/focus cần nhận biết 3:1; kiểm từng cặp token thực dùng. Focus nhìn rõ, tab order hợp lý, thao tác bằng bàn phím, screen reader biết label/status/error. Dùng HTML semantic ở UI thật; heading trong illustration Stageshow không làm lộn outline của trang chứa nó.

Kiểm zoom 200%, tên hồ sơ dài, dấu tiếng Việt, số tiền lớn và định dạng ngày. Cho phép reduced motion; trạng thái và kết quả không phụ thuộc animation. Live region thông báo đổi trạng thái quan trọng vừa đủ, không đọc lại toàn trang. CTA không bị keyboard/safe-area che trên mobile.

## 9 Motion trong tác nghiệp

Motion ngắn, có nguyên nhân: mở panel, chuyển tab, hiển thị lỗi hoặc ghi nhận kết quả. Đề xuất 120–180ms cho hover/focus, 180–240ms cho overlay; đây là timing thiết kế riêng cần review. Không chạy nền chuyển động trên bảng tài chính và không làm số tiền liên tục nhảy khi cần đọc đối chiếu.

Nút đang gửi thể hiện busy và chặn thao tác lặp tại UI; chống lặp thật vẫn ở API. Khi nhận kết quả, cập nhật cùng vùng trạng thái rồi giữ kết quả đọc được. Chuyển sang “Đã ký số” cần kết quả xác minh; không đóng dấu đồ họa lên chứng từ thay cho artifact đã ký.

## 10 Stageshow cho hình và demo sản phẩm

Theo skill gốc, mỗi cảnh có một câu chuyện, một đối tượng chính và kết quả rõ. Cảnh giữ ngữ cảnh đủ nhận ra sản phẩm; chữ thật tập trung vào hành động/kết quả, placeholder chỉ ở phần phụ. Crop có chủ đích giữ trọn nút, dữ liệu trọng tâm và overlay; satellite có vai trò. Bản compact được bố trí lại. Poster phải tự kể được kết quả; motion có nguyên nhân và kết quả được giữ đủ lâu để đọc. Chọn example gần nhất, dựng still trước, quay lại và sửa khung hình trước chi tiết. Các quy tắc này áp dụng cho illustration/demo theo [Stageshow](https://github.com/benjitaylor/skills/blob/main/stageshow/SKILL.md).

Số đo sân khấu, thời lượng và ngân sách chữ của Stageshow không là giới hạn cho màn hình vận hành. UI demo dùng chung tokens và component của ứng dụng khi có; dữ liệu tổng hợp có nhãn, tách khỏi adapter giao dịch thật.

| Cảnh đề xuất | Một hành động | Kết quả giữ trên poster | Điểm bắt đầu tham khảo |
| --- | --- | --- | --- |
| Hồ sơ cần bổ sung | Mở cảnh báo và trả lại có lý do | Trạng thái Chờ bổ sung cùng lý do | form-error hoặc static-card |
| Đối chiếu một trường | Mở chênh lệch số lượng | Giá trị ba nguồn và chênh lệch cụ thể | table-edit hoặc story |
| Nhận xác nhận nguồn | Từ thao tác đã gửi tới ack | Đã xác nhận, ID nguồn mẫu | device-pair hoặc phone-touch |

Không mặc định giữ ba showcase trong tài liệu cũ. Chọn cảnh sau khi đã review UI thật; mỗi cảnh minh họa một kết quả có trong sản phẩm. Gói bàn giao demo có still desktop/compact, poster reduced-motion, contact sheet/loop nếu có animation, ghi chú example tham khảo và nội dung đã kiểm. Không cài hoặc thực thi mã từ skill chỉ vì tài liệu nguồn nêu lệnh cài.

## 11 Công việc UI cần giao cho coding agent

| ID | Đầu ra | Điều kiện nghiệm thu |
| --- | --- | --- |
| feat-081 | Sitemap, navigation và user flow theo vai trò | Đi được từ inbox tới bản trình và quyết định; context pháp nhân không bị mất |
| feat-006 | Tokens, shell và component foundations | Đúng nguồn nhận diện, màu sản phẩm được đánh dấu đề xuất, chữ và focus đọc được |
| feat-082 | Bản review bốn màn hình ưu tiên: inbox, hồ sơ, đối soát, mobile detail | Có nội dung tiếng Việt thật và trạng thái lỗi/stale; desktop/mobile được bố trí riêng |
| feat-083 | Bộ component và ma trận trạng thái | Có đủ trạng thái mục 7 và quy tắc phản hồi tác vụ nền |
| feat-084 | Hoàn thiện responsive trên luồng đã triển khai | Không che CTA, không cắt số tiền, đúng hành vi mất mạng và bàn phím |
| feat-085 | Review UI toàn phạm vi và sửa lỗi | Bằng chứng ảnh ở kích thước đã chọn; kiểm focus/contrast/reflow; ghi rõ phần chưa kiểm |
| feat-086 | Hình/demo Stageshow từ UI đã review | Có poster/compact; crop đúng vùng; trạng thái không hứa tính năng ngoài SRS |

Backlog chi tiết và phụ thuộc nằm trong [feature list](../planning/feature_list.proposed.json). UI review xác nhận bố cục, trạng thái và usability; không thay thế nghiệm thu tài chính, phân quyền hay tích hợp.
