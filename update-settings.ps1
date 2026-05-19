param(
    [string]$SettingsFile,
    [string]$SkillsPath
)

try {
    $content = Get-Content -Path $SettingsFile -Raw -Encoding UTF8
    $obj = ConvertFrom-Json $content

    if (-not $obj.skills) {
        Add-Member -InputObject $obj -NotePropertyName 'skills' -NotePropertyValue @() -Force
    }

    $hasExisting = $obj.skills | Where-Object { $_ -like "*superpowers*" }
    if (-not $hasExisting) {
        $obj.skills += $SkillsPath
        $obj | ConvertTo-Json -Depth 10 | Set-Content -Path $SettingsFile -Encoding UTF8
        exit 0
    }
    exit 0
} catch {
    Write-Host "Error: $_"
    exit 1
}