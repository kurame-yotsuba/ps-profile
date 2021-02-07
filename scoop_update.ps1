
# scoopのupdate自動化
# 1日1回起動時にupdateする
# update時刻を保存するためのファイル。中身は空

# 直近の時刻を返す関数
function lastTime([datetime]$time) {
    [DateTime]::Now -lt $time ? $time.AddDays(-1) : $time
}

# アップデートするかどうか判断する時間
$update_time = lastTime "5:00"

# アップデート時に作成されるファイル
$last_update_time_file = "~/.scoop_update_time"

$updated = (Test-Path $last_update_time_file) -and
    (Get-Item $last_update_time_file).LastWriteTime -gt $update_time

if(-not $updated){
    scoop update
    scoop status
    # 自動アップデートしてほしくないアプリはholdしておくこと
    scoop update *

    New-Item $last_update_time_file -Force > $null
}
