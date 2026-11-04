Investigation URL: https://cyberdefenders.org/blueteam-ctf-challenges/voldemort-apt41/

Voldemort - APT41 Forensic Report: End-to-End Cyber Incident Reconstruction & Threat Analysis

📜 Executive Summary & Incident Scenario

On July 21, 2025, a multi-stage cyber intrusion targeting financial sector assets was executed against host PC02 (10.10.3.251). The campaign leveraged a sophisticated phishing vector impersonating the UK tax authority HMRC to lure victims to an external web landing page. By abusing the Windows search-ms protocol, the attack chained a TryCloudflare tunnel to execute hidden PowerShell commands running a remote Python interpreter and script straight from an attacker-controlled share. This activity dropped a second-stage archive containing Cisco-named payloads configured for DLL side-loading and covert command-and-control (C2) communications utilizing the Google Sheets API.

🔍 Threat Intelligence & MITRE ATT&CK Alignment

APT41 & Voldemort Campaign Profile: The investigation maps the observed intrusion to the Voldemort malware espionage campaign, characterized by tax-authority themed lures, remote share execution via tunneling utilities, and overlaps with threat clusters associated with APT41/TA415. 
Initial Access: Delivered via an HMRC-themed spearphishing email (no_reply_hmrc.gov.uk@ideasworkshop.it) containing a link to a free-hosted landing page ([http://pops.infinityfreeapp.com/SA700_Notes_2025.html](http://pops.infinityfreeapp.com/SA700_Notes_2025.html)). 
Execution: Browser evaluation of the user agent triggered a search-ms URI pointing to a TryCloudflare tunnel (worse-entering-bg-political.trycloudflare.com), spawning a hidden PowerShell process (-NoProfile -WindowStyle Hidden) that invoked a remote Python interpreter and script (script.py). 
Command & Control & Ingress Tool Transfer: The script resolved MediaFire (download1589.mediafire.com) to download a second-stage archive (test.zip) into a user-writable directory (C:\Users\Administrator\AppData\Local\Microsoft\Windows\test.zip).  
Defense Evasion & C2 Channels: The deployment included legitimate-looking, Cisco-named components (CiscoCollabHost.exe and CiscoSparkLauncher.dll) to facilitate DLL side-loading, while the malicious library utilized hard-coded requests to the Google Sheets API (sheets.googleapis.com) for persistent bidirectional C2 tasking.   

⚒️ Tools & Technologies Leveraged

Splunk SIEM: Utilized to query and correlate Suricata network event logs, Windows PowerShell logs, and Sysmon operational logs (EventCodes 3, 22). 
ChromeCacheView: Deployed to recover browser cache data (1.htm) and analyze the landing page's malicious JavaScript and OS-detection routines. 
Notepad / Notepad++: Used to inspect raw HTML source code, review extracted command lines, and analyze readable strings within the dropped DLL. 
Windows File Explorer: Inspected localized file system artifacts, modification timestamps, and directory contents within AppData\Local\Microsoft\Windows.   
