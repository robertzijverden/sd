# RZ ICT ServiceDesk Toolkit
$ErrorActionPreference='Continue'
$base='https://raw.githubusercontent.com/robertzijverden/sd/main/'
function Run-SD($file){
 try {
  $code=Invoke-RestMethod ($base+$file) -UseBasicParsing -ErrorAction Stop
  Invoke-Expression $code
 } catch {
  Write-Host "[FOUT] Script kon niet worden geladen: $($_.Exception.Message)" -ForegroundColor Red
  Read-Host "Enter" | Out-Null
 }
}
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
  '1' { Run-SD 'oobe.ps1' }
  '2' { Run-SD 'serial.ps1'; Read-Host "Enter" | Out-Null }
  '3' { Run-SD 'logs.ps1'; Read-Host "Enter" | Out-Null }
  '4' { Run-SD 'retry.ps1'; return }
 }
} until($c -match '^[qQ]$')
