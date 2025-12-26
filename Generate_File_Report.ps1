param(
    [string]$FolderPath = ".",
    [string]$OutputCsv = "File_Details_Report.csv"
)

Set-Location $FolderPath

Get-ChildItem -File | Select-Object `
@{Name='FileName';Expression={$_.Name}}, `
@{Name='FileType';Expression={$_.Extension}}, `
@{Name='Created';Expression={$_.CreationTime}}, `
@{Name='Modified';Expression={$_.LastWriteTime}}, `
@{Name='Accessed';Expression={$_.LastAccessTime}}, `
@{Name='HashValue';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} `
| Export-Csv -Path $OutputCsv -NoTypeInformation -Encoding UTF8

Write-Host "CSV Generated Successfully at $OutputCsv"
