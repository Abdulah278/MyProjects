Investigation URL: https://cyberdefenders.org/blueteam-ctf-challenges/achievements/abdulah/starktech-incident-apt41/

StarkTech Forensic Report: End-to-End Cyber Incident Reconstruction & Threat Analysis (APT41 Intrusion)

📜 Executive Summary & Incident Scenario

On August 25, 2025, the StarkTech Security Operations Center (SOC) detected a sophisticated, multi-stage cyber intrusion executed by the notorious state-sponsored threat group APT41 (Double Dragon) across key enterprise assets, including workstation DESKTOP (10.10.5.62), internal server FILES-SERVER (10.10.5.245), and Domain Controller DC01 (10.10.5.10). APT41 is a prolific Chinese cyber espionage and financially motivated threat group known for blending state-sponsored espionage with custom toolsets, Living-off-the-Land Binaries (LOLBins), and supply chain compromises. In this incident, APT41 successfully compromised the environment via drive-by browser activity, deployed fileless PowerShell payloads, established redundant remote access channels, harvested domain credentials, moved laterally, and exfiltrated sensitive organizational data. 

🔍 Threat Intelligence & MITRE ATT&CK Alignment

APT41 Tactics & Operational Profile: True to APT41's signature tradecraft of blending espionage with operational efficiency, the group rapidly pivoted from initial access to internal reconnaissance, domain enumeration via SharpHound, and credential dumping via LSASS memory access. Their methodology relied heavily on dual-use administrative tooling and legitimate software (such as Atera, Splashtop, and AnyDesk) to blend in with normal network traffic and maintain long-term persistence. 
Initial Access & Execution: The intrusion began when a user visited paste.sh via Microsoft Edge (msedge.exe). This web activity triggered a background PowerShell download script that fetched the primary payload iexploreplugin.exe from an external server (10.10.5.171:8883), masking it as an Internet Explorer plugin.  
Command & Control (C2) & Defense Evasion: iexploreplugin.exe maintained active beaconing to external infrastructure on ports 8080, 8083, and 8443. To evade endpoint defenses, APT41 injected malicious code into notepad.exe (Sysmon EventCode 10) and executed script commands (Set-MpPreference -DisableRealtimeMonitoring $true) to disable Windows Defender real-time monitoring.
Lateral Movement & Credential Access: The adversary extracted credentials by opening handles to lsass.exe with access rights 0x1ffff. Using stolen domain credentials (CORETECH\admin143), they moved laterally to FILES-SERVER, staging Python-based DLL side-loading runners (testc.exe, python311.dll) to bypass application whitelisting policies.  Collection, Exfiltration & Persistence: Sensitive HR and Finance CSV files were compressed into teams-skartech.zip and exfiltrated to an external cloud endpoint via rclone. For domain-wide persistence, APT41 modified Winlogon registry keys (AutoAdminLogon=1 via dhsf82.bat) on Domain Controller DC01 to ensure automated administrative access. 

Impacted System Assets & Indicators:

Compromised Workstation: DESKTOP (10.10.5.62)  
Internal Server & Domain Controller: FILES-SERVER (10.10.5.245), DC01 (10.10.5.10) 
Associated Malware & Binaries: iexploreplugin.exe, ws2_32.exe, system_module.exe, testc.exe, python311.dll  
Staged Exfiltration Archive: teams-skartech.zip  

⚒️ Tools & Technologies LeveragedSplunk SIEM: Utilized for aggregating, correlating, and querying telemetry across Sysmon EventCodes (EventCode 1, 3, 10, 11, 22), Windows 

Security Event logs (EventCodes 4697, 4624), and Suricata NIDS event logs.
SharpHound / BloodHound: Deployed by APT41 to map Active Directory object graphs and trust relationships, exporting telemetry data into C:\Users\Public.
RClone & Certutil: Abused by the threat actor to execute cloud data exfiltration (rclone copy) and fetch remote payloads/scripts (certutil -urlcache).
RMM Frameworks (Atera, Splashtop, AnyDesk): Deployed via msiexec to establish redundant, legitimate administrative persistence channels that bypass standard security alarms.   
