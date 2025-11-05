# Move table captions to bottom of use case tables
# Usage: .\move-captions-bottom.ps1 -FolderPath "workspace\Hieu"

param(
    [Parameter(Mandatory=$true)]
    [string]$FolderPath
)

# Get all .tex files in the specified folder
$texFiles = Get-ChildItem -Path $FolderPath -Filter "*.tex"

foreach ($file in $texFiles) {
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if caption exists
    if ($content -match '\\caption\{[^}]+\}') {
        $caption = $matches[0]
        
        # Remove caption from anywhere in the file
        $contentWithoutCaption = $content -replace '\\caption\{[^}]+\}\s*', ''
        
        # Add caption before \end{table}
        $newContent = $contentWithoutCaption -replace '(\\end\{tabular\}\s*)', "`$1`n$caption`n"
        
        # Write back to file
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "Skipped: $($file.Name) (no caption found)" -ForegroundColor Yellow
    }
}

Write-Host "`nDone! Processed $($texFiles.Count) files." -ForegroundColor Cyan
