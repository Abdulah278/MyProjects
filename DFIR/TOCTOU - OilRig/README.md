scenario URL: https://cyberdefenders.org/blueteam-ctf-challenges/achievements/abdulah/toctou-oilrig/

Host Forensics Incident Analysis: TOCTOU Workstation Compromise & Kernel Privilege Escalation

📜 Executive Summary & Incident Scenario

A researcher using the local account mashle on Windows 10 workstation (192.168.1.27) downloaded an archive named CLEAR_EDDY.zip from an anonymous file-sharing platform (bashupload.com). Upon execution, the payload launched initial access code. Within 30 minutes, the compromised process utilized certutil.exe to fetch a second-stage local privilege escalation exploit binary (TOCTOU.exe). By abusing a Time-of-Check to Time-of-Use (TOCTOU) race condition in the Windows kernel (CVE-2024-30088), the attacker elevated execution to NT AUTHORITY\SYSTEM. Post-exploitation activity included establishing persistence via a backdoor administrator account (gu3st) and a PowerShell profile hook, masquerading the payload as winhlp32.exe in System32, wiping event logs using wevtutil, and establishing active C2 communication over HTTPS.

🔍 Threat Intelligence & MITRE ATT&CK Alignment

MITRE ATT&CK Mapping: User Execution: Malicious File (T1204.002) via manual execution of CLEAR_EDDY.exe from Downloads. Ingress Tool Transfer (T1105) via certutil.exe ingress of TOCTOU.exe and batch scripts. Exploitation for Privilege Escalation (T1068) via kernel race condition abuse (CVE-2024-30088) to reach SYSTEM. Create Account: Local Account (T1136.001) via provisioning of local administrator gu3st (RID 1001). Event Triggered Execution: PowerShell Profile (T1546.013) via persistent execution hook in Microsoft.PowerShell_profile.ps1. Masquerading: Rename Legitimate Utilities (T1036.003) via dropping malicious winhlp32.exe into C:\Windows\System32. Indicator Removal: Clear Windows Event Logs (T1070.001) via wevtutil cl execution against 7 core logs. Indicator Removal: Clear Command History (T1070.003) via deletion of ConsoleHost_history.txt. Application Layer Protocol: Web Protocols (T1071.001) via established C2 HTTPS channel to 162.159.140.245:443.

Threat Actor & LPE Context: CVE-2024-30088 is a high-severity kernel privilege escalation vulnerability in NtQueryInformationToken / AuthzBasepCopyoutInternalSecurityAttributes. Known threat actors, including APT34 (OilRig / Earth Simnavaz), systematically leverage local kernel exploits and Living-off-the-Land Binaries (LOLBins) like certutil to establish SYSTEM-level foothold, bypass local access restrictions, and deploy persistent backdoors during espionage operations in enterprise environments.

Impacted System Assets:
C:\Users\mashle\Downloads\CLEAR_EDDY.exe
C:\Users\mashle\AppData\Local\Microsoft\Windows\INetCache\IE\FW98IITW\TOCTOU[1].exe
C:\Users\mashle\AppData\Local\Microsoft\Windows\INetCache\IE\CZFS7CMT\toctou[1].bat
C:\Windows\System32\winhlp32.exe
C:\Users\mashle\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1.
SAM Account: gu3st (RID 1001)

⚒️ Tools & Technologies Leveraged

MemProcFS & Volatility 3: Used for physical memory parsing, extracting process trees, INetCache artifacts, SAM hive structure, and executing UserAssist registry analysis.
Timeline Explorer & DB Browser for SQLite: Applied to reconstruct cross-artifact forensic timelines and parse Chromium SQLite history databases to identify initial download web referrers.
Registry Explorer & Notepad++: Utilized to inspect SAM hive user permissions, account creation timestamps, and deconstruct extracted batch scripts for persistence mechanics.
PowerShell & VirusTotal: Employed for file hashing (MD5/SHA-256) and correlating binary hashes against known CVE-2024-30088 exploit threat detections.
