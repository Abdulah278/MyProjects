Investigation URL: https://cyberdefenders.org/blueteam-ctf-challenges/pwneddc-fin7/

Incident Analysis: "PwnedDC - FIN7" Corporate Domain Controller Compromise

📋 Executive Summary & Incident Scenario

A sophisticated phishing-led intrusion targeted a corporate domain controller, culminating in the staging and execution of the DarkSide ransomware family. The attack originated from a deceptive email impersonating DHL, utilizing a macro-enabled Excel workbook disguised with an .xls extension. Upon execution, the VBA macro leveraged VBA stomping to hide malicious behavior in its P-Code, ultimately injecting a reverse shell payload into rundll32.exe. The threat actor established persistent access via a scheduled task, performed extensive Active Directory reconnaissance using tools like SharpHound, downloaded the DarkSide ransomware payload (svchost.exe running under PID 3140), and prepared the environment for enterprise-wide data encryption.  

🔍 Threat Intelligence & MITRE ATT&CK Alignment

Threat Actor Profile: FIN7 (Carbanak / ELBRUS)is a prominent, financially motivated cybercriminal syndicate (also tracked as Carbanak or ELBRUS) known for executing sophisticated, multi-stage intrusions targeting the hospitality, retail, restaurant, and financial sectors. Over time, their operational playbook evolved from targeted point-of-sale (POS) RAM scrapers to broad corporate network compromises, active directory domain controller takeovers, and the deployment of enterprise-grade ransomware families such as DarkSide.

MITRE ATT&CK Mapping:
Initial Access: T1566.001 (Spearphishing Attachment) via the spoofed DHL invoice email containing the malicious workbook. 
Execution: T1204.002 (User Execution: Malicious File), T1059.005 (Command and Scripting Interpreter: Visual Basic), and T1055 (Process Injection) via macro execution and injection into rundll32.exe.  
Defense Evasion: T1027 (Obfuscated Files or Information) via VBA stomping separating decoy source code from malicious P-Code, and T1036.005 (Masquerading: Match Legitimate Name or Location) via executing ransomware under a copied svchost.exe name. 
Command and Control: T1071 (Application Layer Protocol) via reverse shell communications over port 8080.  
Persistence: T1053.005 (Scheduled Task/Job: Scheduled Task) via a daily task named MicrosoftEdge executing remote HTA files via mshta.exe. 
Discovery: T1087.002 (Account Discovery: Domain Account), T1069.002 (Permission Groups Discovery: Domain Groups), and T1482 (Domain Trust Discovery) via SharpHound and PowerView enumeration scripts.
Tool Transfer: T1105 (Ingress Tool Transfer) via Invoke-WebRequest pulling payloads from the attacker server. 
Impact: T1486 (Data Encrypted for Impact) via the DarkSide ransomware binary running as PID 3140. 

🛠️ Tools & Technologies Leveraged

Arsenal Image Mounter: Mounted the domain controller disk triage image as a read-only drive.  
Event Log Explorer: Browsed and filtered Windows Defender and PowerShell operational logs. 
Outlook Forensics Wizard: Inspected mailbox PST files, message contents, and raw MAPI properties. 
oletools (oleid, olevba): Analyzed office attachment structures, extracted VBA source code, and uncovered P-Code discrepancies. 
scdbg: Emulated shellcode binaries to map API resolutions and network connection parameters. 
Volatility (2.6): Conducted memory forensics using modules like imageinfo, procdump, yarascan, volshell, and dumpfiles. 
ClamAV: Performed signature scans on extracted process executables from memory dumps. 
Resource Hacker: Inspected binary version information and exposed true internal names (e.g., calimalimodumator.exe).  
