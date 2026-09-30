# ServiceDesk Windows Autopilot OOBE Toolkit
# Run from OOBE with Shift+F10:
# powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/robertzijverden/sd/main/oobe.ps1 | iex"

$ErrorActionPreference = "SilentlyContinue"
function Banner($t){ Write-Host ""; Write-Host "=== $t ===" -ForegroundColor Cyan }
function Good($t){ Write-Host "[OK]   $t" -ForegroundColor Green }
function Bad($t){ Write-Host "[FAIL] $t" -ForegroundColor Red }
function Warn($t){ Write-Host "[INFO] $t" -ForegroundColor Yellow }

Clear-Host
Write-Host "ServiceDesk - Autopilot OOBE controle" -ForegroundColor Cyan
Write-Host "Alleen bedoeld voor apparaten die tijdens Windows OOBE horen te enrollen." -ForegroundColor DarkGray

Banner "Apparaat"
$serial=(Get-CimInstance Win32_BIOS).SerialNumber
$uuid=(Get-CimInstance Win32_ComputerSystemProduct).UUID
Write-Host "Serienummer : $serial"
Write-Host "UUID         : $uuid"

Banner "Netwerk"
$net=Test-NetConnection ztd.dds.microsoft.com -Port 443 -WarningAction SilentlyContinue
if($net.TcpTestSucceeded){Good "Autopilot endpoint bereikbaar via HTTPS"}else{Bad "ztd.dds.microsoft.com:443 niet bereikbaar"}
try { Resolve-DnsName login.microsoftonline.com -ErrorAction Stop | Out-Null; Good "DNS werkt" } catch { Bad "DNS lookup mislukt" }

Banner "Autopilot profiel"
$key="HKLM:\SOFTWARE\Microsoft\Provisioning\Diagnostics\Autopilot"
$p=Get-ItemProperty $key -ErrorAction SilentlyContinue
if(!$p){
    Bad "Geen Autopilot diagnostics state gevonden."
}else{
    $tenant=$p.CloudAssignedTenantId
    $domain=$p.CloudAssignedTenantDomain
    $oobe=$p.CloudAssignedOobeConfig
    if($tenant){Good "Tenant ontvangen: $tenant"}else{Bad "CloudAssignedTenantId ontbreekt"}
    if($domain){Good "Tenantdomein ontvangen: $domain"}else{Bad "CloudAssignedTenantDomain ontbreekt"}
    if($null -ne $oobe){Good "OOBE-config ontvangen: $oobe"}else{Bad "CloudAssignedOobeConfig ontbreekt"}
}

Banner "Conclusie"
if($net.TcpTestSucceeded -and $p.CloudAssignedTenantId){
    Good "Dit apparaat heeft een Autopilot tenantconfiguratie ontvangen."
    Warn "Als OOBE toch 'persoonlijk of werk/school' toont, verzamel dan logs met logs.ps1."
}else{
    Bad "Geen bruikbaar Autopilot profiel aangetroffen."
    Write-Host "Controleer in Intune het serienummer, Autopilot-registratie en deployment-profile assignment." -ForegroundColor Yellow
    Write-Host "Ga NIET handmatig verder met 'Werk of school' als dit een Autopilot-device hoort te zijn." -ForegroundColor Yellow
}
Write-Host ""
Write-Host "Druk op Enter om af te sluiten."
Read-Host | Out-Null
