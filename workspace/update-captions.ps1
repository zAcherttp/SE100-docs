# Update table captions in use case files
# Usage: .\update-captions.ps1 -FolderPath "workspace\Hieu"

param(
    [Parameter(Mandatory=$true)]
    [string]$FolderPath
)

# Get all .tex files in the specified folder
$texFiles = Get-ChildItem -Path $FolderPath -Filter "*.tex"

foreach ($file in $texFiles) {
    # Get filename without extension (e.g., UC01-01)
    $baseName = $file.BaseName
    
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Replace the caption (match both single and double backslash)
    $newContent = $content -replace '\\\\?caption\{.*?\}', "\caption{Bảng $baseName}"
    
    # Write back to file if changes were made
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "Skipped: $($file.Name) (no match found)" -ForegroundColor Yellow
    }
}

Write-Host "`nDone! Processed $($texFiles.Count) files." -ForegroundColor Cyan
