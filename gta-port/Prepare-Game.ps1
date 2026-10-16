param(
    [Parameter(Mandatory=$true)][string]$GameDirectory,
    [Parameter(Mandatory=$true)][string]$OutputDirectory
)
$ErrorActionPreference = 'Stop'
$source = (Resolve-Path -LiteralPath $GameDirectory).Path
$destination = [IO.Path]::GetFullPath($OutputDirectory)
if ($destination.StartsWith($source.TrimEnd('\') + '\', [StringComparison]::OrdinalIgnoreCase) -or $destination -eq $source) {
    throw 'Output must be outside the original game folder.'
}
if (Test-Path -LiteralPath $destination) { throw 'Choose a new, empty output path to preserve existing files.' }
if (-not (Test-Path -LiteralPath (Join-Path $source 'gta_sa.exe'))) { throw 'gta_sa.exe missing.' }
$excluded = @('_DLSS5_Backup','host64','Uninstall','reshade-shaders','dxgi.dll','dlss5-feed.addon32','dlss5-feed.cfg','dlss5-feed.log','ReShade.ini','ReShade.log','ReShadePreset.ini','_dlss5_install_state.json')
New-Item -ItemType Directory -Path $destination | Out-Null
foreach ($item in Get-ChildItem -LiteralPath $source -Force) {
    if ($item.Name -in $excluded) { continue }
    Copy-Item -LiteralPath $item.FullName -Destination $destination -Recurse -ErrorAction Stop
}
$original = Get-FileHash -LiteralPath (Join-Path $source 'gta_sa.exe') -Algorithm SHA256
$copied = Get-FileHash -LiteralPath (Join-Path $destination 'gta_sa.exe') -Algorithm SHA256
if ($original.Hash -ne $copied.Hash) { throw 'Executable copy verification failed.' }
Write-Output "Game staged: $destination"
Write-Output 'Copy this folder to the iOS app Documents/wine/drive_c/Games/GTAExtremeIndonesia.'
Write-Output 'ReShade/DLSS extras were excluded. CLEO and ASI plugins remain untested.'
