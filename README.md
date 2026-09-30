# ServiceDesk Autopilot OOBE Toolkit

Kleine read-only diagnose- en herstelhulpen voor Windows Autopilot tijdens OOBE.

## Snelste controle

Open tijdens OOBE **Shift+F10** (op sommige laptops Shift+Fn+F10) en voer uit:

```cmd
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/robertzijverden/sd/main/oobe.ps1 | iex"
```

Het script toont serienummer/UUID, controleert HTTPS/DNS en leest de lokale Autopilot diagnostics state. Het verwijdert geen tenant- of Autopilotregistratie.

## Losse scripts

**Serienummer/UUID**
```cmd
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/robertzijverden/sd/main/serial.ps1 | iex"
```

**Autopilot logs**
```cmd
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/robertzijverden/sd/main/logs.ps1 | iex"
```

**OOBE opnieuw starten**
```cmd
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/robertzijverden/sd/main/retry.ps1 | iex"
```

## Interpretatie

Als tijdens OOBE **Instellen voor persoonlijk gebruik / werk of school** verschijnt terwijl het apparaat via Autopilot hoort te worden ingericht, controleer dan eerst `oobe.ps1`.

Als `CloudAssignedTenantId` en de overige CloudAssigned-waarden ontbreken terwijl internet werkt, controleer aan de Intune-zijde:
- of exact hetzelfde serienummer als Windows Autopilot-device aanwezig is;
- of het juiste deployment profile daadwerkelijk is toegewezen;
- of de registratie/profieltoewijzing volledig verwerkt is.

Ga bij een bedoeld Autopilot-device niet als workaround handmatig verder via **Werk of school**.

## Veiligheid

De toolkit wist bewust geen Autopilot-, Entra- of Intune-registratiekeys. Een lokale registry-reset kan een ontbrekende server-side Autopilot-registratie of profieltoewijzing niet herstellen.

> Let op: deze repository is publiek. Plaats hier geen tenant-ID's, tokens, wachtwoorden of andere organisatiegeheimen in.
