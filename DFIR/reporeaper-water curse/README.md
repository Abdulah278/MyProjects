Lab URL: https://github.com/mo4de1/Script2Scene

Digital Forensics & Incident Analysis: "RepoReaper - Water Curse" Supply Chain Compromise

📋 Executive Summary & Incident Scenario

An internal software developer workstation (DESKTOP-POKO2F4, user DemonSlayer) was targeted in a sophisticated supply chain attack orchestrated by the Water Curse threat actor group. The campaign utilized a weaponized open-source GitHub repository (mo4de1/Script2Scene) masquerading as a script-to-scene conversion tool. Upon compilation, the repository dropped a multi-stage malware package that established persistence via scheduled tasks, escalated privileges using a UAC protocol-handler bypass, disabled system recovery features, performed anti-analysis checks against security software, and executed encrypted in-memory payloads via process hollowing. Finally, the malware exfiltrated sensitive data to remote command-and-control (C2) infrastructure via legitimate platform APIs.

🔍 Threat Intelligence & MITRE ATT&CK Alignment

Threat Actor Profile (Water Curse): Water Curse is a tracked threat group known for conducting software supply chain attacks by weaponizing GitHub repositories—leveraging a network of dozens of compromised or attacker-controlled accounts to distribute malicious payloads disguised as legitimate penetration-testing suites, developer scripts, and productivity tools. Their operations specifically target technical communities, DevOps engineers, and security professionals who routinely compile and build code from open-source repositories.

MITRE ATT&CK Mapping: The incident maps across multiple tactics and techniques, including T1195.001 (Supply Chain Compromise) via the GitHub repository delivery, T1059.001 (Command and Scripting Interpreter) through PowerShell execution scripts (Clcw.ps1.ps1, mbam.ps1), T1548.002 (Bypass User Account Control) via ms-settings protocol hijacking triggered by ComputerDefaults.exe, T1053.005 (Scheduled Task) for persistence, T1490 (Inhibit System Recovery) via registry policy manipulation, T1055.012 (Process Hollowing) into RegAsm.exe, T1036.005 (Masquerading) under a fake NVIDIA directory structure, and T1567.002 (Web Service: Exfiltration to Cloud Storage) over the Telegram Bot API (api.telegram.org).   
RepoReaper - Water Curse Report.pdf
+ 2

Attack Mechanics & Defense Evasion: The malware utilized low-profile execution tactics, dropping a password-protected 7-Zip archive (4359ce22-2f6d-43b8-b34d-063d74715562.7z) containing an Electron application framework (app.asar). It implemented anti-analysis checks (mbam.ps1) to test for Malwarebytes installations prior to executing AES-encrypted payloads (boot_f, kernel_f, thread_f). Furthermore, it modified system settings to set DisableSR and DisableConfig to 1 under SystemRestore policies to thwart recovery.

Exfiltration Analysis: Outbound connections via the Windows Filtering Platform (Event ID 5156) revealed traffic originating from a masqueraded binary (NVIDIA CONTROL PANEL.EXE) running out of AppData\Local\Microsoft\Vault\UserRoamingTiles\NVIDIA Container directly to IP 149.154.167.220, which resolves to legitimate Telegram API infrastructure used for data exfiltration. Additional C2 node traffic linked to DigitalOcean infrastructure (161.35.18.98) was discovered via hollowed RegAsm.exe processes.   
RepoReaper - Water Curse Report.pdf
+ 1

🛠️ Tools & Technologies Leveraged

FTK Imager: Used for capturing and extracting file system artifacts, disk images, and customized directory structures from the target environment.   
RepoReaper - Water Curse Report.pdf
+ 1

DB Browser for SQLite: Utilized to analyze Microsoft Edge browser history databases and recover download referrer URLs from SQLite storage.

DCode: Employed to decode Chromium microsecond timestamps into human-readable UTC event times.

Timeline Explorer & Registry Explorer: Deployed to parse NTFS Master File Table ($MFT) timelines, prefetch logs, and parse Windows registry hives for scheduled tasks, application execution artifacts, and UAC bypass keys.

Event Log Explorer: Used to analyze Windows PowerShell operational logs (Event ID 4104), execution metadata, and Windows Filtering Platform network traffic (Event ID 5156).
