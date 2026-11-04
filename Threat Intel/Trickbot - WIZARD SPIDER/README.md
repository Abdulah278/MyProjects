Investigation URL: https://cyberdefenders.org/blueteam-ctf-challenges/trickbot-wizard-spider/

Malware Analysis & Threat Attribution: "Trickbot - WIZARD SPIDER" Incident

📋 Executive Summary & Incident Scenario

A financial organization detected unauthorized attempts to access sensitive financial records, leading to the recovery and analysis of a suspicious executable (SHA-256: 3bf0f489250eaaa99100af4fd9cce3a23acf2b633c25f4571fb8078d4cb7c64d). Behavioral and sandbox analysis revealed that the sample acts as a Trickbot-family dropper. It fingerprints the host operating system via Windows Management Instrumentation (WMI) to evade virtual machine environments, injects malicious code into explorer.exe, drops a secondary 192 KB executable named TimeManager.exe into C:\ProgramData, and achieves persistence by writing to the current-user Run registry key. The secondary payload actively communicates with command-and-control (C2) infrastructure, including the malicious domain obuhov2k.beget.tech and multiple Russian-hosted IP addresses.

🕵️‍♂️ Threat Actor Profile:

Threat Actor Profile: WIZARD SPIDER (Trickbot Group) is a highly sophisticated, financially motivated cybercriminal cyber-espionage and ransomware syndicate originating from Eastern Europe. Known for operating modular malware frameworks such as Trickbot, Ryuk, and Conti, the group primarily targets large enterprise networks, financial institutions, and critical infrastructure to perform credential harvesting, data exfiltration, and high-impact ransomware deployments.


🔍 MITRE ATT&CK Alignment

Execution: T1047 (Windows Management Instrumentation) via WbemLocator queries to Win32_Bios and Win32_ComputerSystem for sandbox detection.
Defense Evasion & Privilege Escalation:T1055 (Process Injection) and T1055.003 (Thread Execution Hijacking) by allocating memory and injecting payloads into explorer.exe.   T1112 (Modify Registry) via modifying registry keys and values.
Persistence: T1547.001 (Boot or Logon Autostart Execution: Registry Run Keys / Startup Folder) via writing TimeManager.exe into HKCU\Software\Microsoft\Windows\CurrentVersion\Run. 
Command and Control: Communication with external C2 servers and domains (obuhov2k.beget.tech).   

🛠️ Tools & Technologies Leveraged

PowerShell: Utilized for hash calculation (Get-FileHash -Algorithm SHA256). 
VirusTotal: Leveraged for behavior summary analysis, file relationships, and node graphing (TimeManager.exe SHA-256: a953bce437f63fcf4ddbe4f0eb1b24b310d6eadf544569d924720855e6b5b797).  
Hybrid Analysis (Falcon Sandbox): Provided secondary validation, threat scoring (100/100), and indicator extraction on a Windows 10 environment.   
