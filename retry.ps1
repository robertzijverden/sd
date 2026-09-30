# ServiceDesk - veilige OOBE retry
# Herstart Windows opnieuw naar OOBE. Dit script verwijdert bewust geen Autopilot/tenant registry keys.
$ErrorActionPreference="Stop"
Write-Host "Autopilot/OOBE opnieuw starten..." -ForegroundColor Cyan
Write-Host "LET OP: dit repareert geen ontbrekende Autopilot-registratie in Intune." -ForegroundColor Yellow
Start-Sleep 2
$sysprep="$env:windir\System32\Sysprep\Sysprep.exe"
if(!(Test-Path $sysprep)){ throw "Sysprep niet gevonden." }
Start-Process $sysprep -ArgumentList "/oobe /reboot" -Verb RunAs
