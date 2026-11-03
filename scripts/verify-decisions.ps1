param(
    [string]$Path = "docs/decisions/decision-register.md",
    [string]$PilotPath = "docs/requirements/pilot-scope.md"
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    Write-Error "Decision register not found: $Path"
    exit 1
}

$content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
$required = @('QD-01','QD-02','QD-03','QD-04','QD-05','QD-06','QD-07')
$missing = @($required | Where-Object { $content -notmatch [regex]::Escape($_) })

if ($missing.Count -gt 0) {
    Write-Error "Decision register is missing: $($missing -join ', ')"
    exit 1
}

foreach ($column in @('Chủ xử lý','Đầu vào còn thiếu','Mốc cần chốt','Phạm vi bị chặn')) {
    if ($content -notmatch [regex]::Escape($column)) {
        Write-Error "Decision register is missing required field: $column"
        exit 1
    }
}

if (-not (Test-Path -LiteralPath $PilotPath -PathType Leaf)) {
    Write-Error "Pilot scope draft not found: $PilotPath"
    exit 1
}

$pilot = Get-Content -LiteralPath $PilotPath -Raw -Encoding UTF8
foreach ($section in @('Ứng viên trong phạm vi','Ngoài phạm vi ở pilot đầu','Điều kiện vào pilot','Điều kiện kết thúc pilot')) {
    if ($pilot -notmatch [regex]::Escape($section)) {
        Write-Error "Pilot scope is missing section: $section"
        exit 1
    }
}

Write-Output "Decision register structure present: $Path"
Write-Output 'All seven decisions are explicitly listed; this check does not approve their values.'
Write-Output "Pilot scope sections present: $PilotPath"
