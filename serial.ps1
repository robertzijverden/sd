$bios=Get-CimInstance Win32_BIOS
$cs=Get-CimInstance Win32_ComputerSystemProduct
Write-Host "Serienummer : $($bios.SerialNumber)"
Write-Host "UUID         : $($cs.UUID)"
