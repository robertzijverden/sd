# RZ ICT ServiceDesk Toolkit
$ErrorActionPreference='SilentlyContinue'
function Run($file){ iex (irm ("https://raw.githubusercontent.com/robertzijverden/sd/main/"+$file)) }
do {
 Clear-Host
 Write-Host "RZ ICT - ServiceDesk Toolkit" -ForegroundColor Cyan
 Write-Host ""
 Write-Host "[1] Autopilot controleren"
 Write-Host "[2] Serienummer / UUID"
 Write-Host "[3] Autopilot logs"
 Write-Host "[4] OOBE opnieuw starten"
 Write-Host "[Q] Afsluiten"
 Write-Host ""
 $c=Read-Host "Kies"
 switch($c){
  '1' { Run 'oobe.ps1' }
  '2' { Run 'serial.ps1'; Read-Host "Enter" | Out-Null }
  '3' { Run 'logs.ps1'; Read-Host "Enter" | Out-Null }
  '4' { Run 'retry.ps1'; return }
 }
} until($c -match '^[qQ]$')
