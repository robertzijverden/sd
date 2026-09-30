# Toon de laatste Autopilot events en kernwaarden, zonder wijzigingen.
Write-Host "=== Autopilot registry ===" -ForegroundColor Cyan
reg.exe query "HKLM\SOFTWARE\Microsoft\Provisioning\Diagnostics\Autopilot" /s
Write-Host ""
Write-Host "=== Laatste Autopilot events ===" -ForegroundColor Cyan
wevtutil.exe qe "Microsoft-Windows-ModernDeployment-Diagnostics-Provider/Autopilot" /f:text /c:50
