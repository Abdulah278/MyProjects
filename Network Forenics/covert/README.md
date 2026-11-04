scenario URL: https://blueteamlabs.online/achievement/share/61222/79

Incident Analysis Report: TrevorC2 Covert Command and Control & DNS Exfiltration

📜 Executive Summary & Incident Scenario

An incident analysis of network capture output.pcap revealed that a Windows workstation (192.168.1.11, hostname MSEDGEWIN10) was compromised and interacting with an internal C2 server (192.168.1.30) using a covert command and control framework. The workstation conducted periodic HTTP GET requests featuring long Base64-encoded strings within the guid parameter, while the C2 server responded with copies of legitimate web pages containing encrypted operator commands hidden inside HTML comments. Concurrently, automated wordlist-based content discovery (HTTP 404 probes) was directed at the workstation from 192.168.1.29 and 192.168.1.37, followed by sensitive data exfiltration via DNS queries carrying Base64-encoded subdomains (fakec2server.domain).  

🔍 Threat Intelligence & MITRE ATT&CK Alignment

MITRE ATT&CK Mapping: Active Scanning (T1595) via sequential port and wordlist probes. Application Layer Protocol: Web Protocols (T1071.001) for HTTP-based C2 beaconing. Data Obfuscation (T1001) via commands hidden within HTML comments. Data Encoding: Standard Encoding (T1132.001) via Base64 parameters and DNS labels. Encrypted Channel: Symmetric Cryptography (T1573.001) via AES-CBC protected C2 traffic. Exfiltration Over C2 Channel (T1041) and Exfiltration Over Alternative Protocol (T1048.003) via DNS query subdomains. Command and Scripting Interpreter: Windows Command Shell (T1059.003) and PowerShell (T1059.001) for executing enumeration and staging scripts (powershell -ep bypass -f exfil.ps1). File and Directory Discovery (T1083) via dir execution.

Framework & Tooling Context: The C2 infrastructure relies on TrevorC2, an open-source covert command and control framework published by TrustedSec that clones existing websites and conceals AES-CBC encrypted commands (derived via SHA-256 using the hard-coded passphrase Tr3v0rC2R0x@nd1s@w350m3#TrevorForget) inside HTML comments (such as oldcss=). 

Impacted System Assets & Network Indicators:

Compromised Workstation: 192.168.1.11 (MSEDGEWIN10)  
C2 Server & Recon Hosts: 192.168.1.30 (C2), 192.168.1.29 & 192.168.1.37 (Scanners/Discovery) 
DNS Exfiltration Domain: fakec2server.domain 
Artifacts & Files: direct.txt, exfil.ps1, C:\Windows\Temp staging folder  

⚒️ Tools & Technologies Leveraged

Wireshark: Utilized for parsing output.pcap, analyzing TCP conversations, and tracking HTTP packet streams and DNS query request structures.
CyberChef: Applied to decode Base64 strings, analyze DNS labels, and reconstruct exfiltrated credential-like data streams.
Python (PyCryptodome): Used to write custom AES-CBC decryption scripts implementing SHA-256 key derivation, IV slicing, and padding correction to uncover hidden operator commands.
Kali Linux: Deployed as the analyst environment for processing capture files and executing decryption utilities.
