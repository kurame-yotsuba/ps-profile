# プロファイルのディレクトリ
$profile_dir = Split-Path $PROFILE -Parent

# モジュールパスを別口から追加
# 通常だと「ドキュメント」の文字が文字化けして
# oh-my-poshのテーマ読み込み時に失敗する。
$sep = [System.IO.Path]::PathSeparator
$MyModulePath = "$env:USERPROFILE\repos\ps-profile\Modules"
$env:PSModulePath = $MyModulePath + $sep + $env:PSModulePath

# function prompt {
#     $teiji = [datetime]::Today.AddHours(18)
#     $now = [datetime]::Now
#     $remain = [timespan]($teiji - $now)
#     "$($remain.ToString("hh\:mm\:ss")) $(Split-Path $PWD -Leaf)>"
# }

. "$profile_dir\def_pyinit"

$MILIMETER_PER_INCH = 25.4
$DPI = 96
function toPx([int] $milimeter) {
    return $milimeter / $MILIMETER_PER_INCH * $DPI
}

# scoopのアップデート
& "$profile_dir/scoop_update"

# Tabでの補間形式をbashっぽく変更
Set-PSReadLineKeyHandler -Key Tab -Function Complete

Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox
