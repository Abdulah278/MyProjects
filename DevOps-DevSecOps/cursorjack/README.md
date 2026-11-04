Investigation URL: https://cyberdefenders.org/blueteam-ctf-challenges/cursorjack/

Incident Analysis: "CursorJack" Malicious MCP Integration & Cloud Compromise

📋 Executive Summary & Incident Scenario

A developer workstation (WIN-DMZO) became the vector for an extensive cloud intrusion after the user visited a deceptive site ([http://awesomeawsmcp.com/](http://awesomeawsmcp.com/) titled "AWS dev ops") while researching AI coding assistant integrations. The site promoted a malicious Model Context Protocol (MCP) integration named "AWS dev ops" inside the Cursor IDE. Rather than providing legitimate tooling, the configuration executed a command via cmd.exe using built-in curl to fetch an executable (s.exe) from an attacker-controlled server (3.72.63.40) and launch it silently in the background. 
The resulting payload granted the attacker interactive command execution as the local Administrator. Approximately thirteen hours later, the attacker utilized stolen AWS administrator credentials (arn:aws:iam::990227772331:user/admin) from the local .aws folder to deploy 16 GPU-optimized (p3.2xlarge) instances across four distinct AWS regions (ap-southeast-1, us-east-1, us-west-2, and eu-west-1), all disguised under the name prod-web-server. These instances executed a startup script (mining.sh) running XMRig to mine proof-of-work cryptocurrency, configured to auto-exchange and payout in Solana (SOL) to a wallet address (SOL:HkGz4KmoZ7Zmk7HN6ndJ31UJ1qZ2qgwQxgVqQwovpZES) linked to the April 2026 Drift Protocol DeFi exploit.

🔍 CursorJack Vulnerability & Attack Vector

The Attack Surface: Model Context Protocol (MCP) allows AI-powered code editors like Cursor to interface with external utilities through plain JSON configuration files (mcp.json) containing commands, arguments, and optional environment variables. Because the application executes whatever command is declared under the privileges of the active user without sandboxing or verification, pasting a malicious entry acts as an arbitrary code execution vector. 
The CursorJack Technique: Attackers construct look-alike documentation or tooling pages that trick developers into pasting malicious JSON configurations into their local environment. This bypasses traditional perimeter defenses, leveraging trusted developer workflows to execute living-off-the-land download cradles (such as curl) that deploy implants directly into temporary directories.

MITRE ATT&CK Alignment

Supply Chain Compromise (T1195.002): Malicious MCP integration promoted via a fake AWS tooling site.  
Command and Scripting Interpreter (T1059.003): Use of cmd.exe to execute download cradles and operational commands.
Ingress Tool Transfer (T1105): Fetching s.exe from [http://3.72.63.40:80/payload/s.exe](http://3.72.63.40:80/payload/s.exe).  
Masquerading (T1036): Executables running from temp folders and mining instances labeled as prod-web-server.
Unsecured Credentials (T1552.001): Targeting plaintext AWS CLI credentials stored within the local user profile (.aws folder).
Data Staged (T1074.001): Copying sensitive configuration data into C:\Users\Administrator\.exfil via xcopy. 
Valid Accounts (T1078.004): Abusing stolen administrator IAM access keys from 3.72.63.40. 
Resource Hijacking (T1496): Launching 16 GPU instances to execute XMRig mining operations. 

🛠️Tools & Technologies Leveraged

DB Browser for SQLite: Inspected the Microsoft Edge history database (History) to trace browser navigation and identify the lure site ([http://awesomeawsmcp.com/](http://awesomeawsmcp.com/)). 
DCode: Converted Chromium timestamp formats (microseconds since January 1, 1601) to readable UTC timestamps to establish the exact timeline of the developer's interaction with the malicious site. 
Notepad++: Opened and examined the Cursor Model Context Protocol configuration file (mcp.json) and the XMRig startup script (mining.sh). 
Windows Event Viewer: Analyzed Sysmon operational event logs (Microsoft-Windows-Sysmon%40perational.evtx) to track process execution, network connections (Event ID 3), and command-line activity (Event ID 1). 
TrailInspector: Loaded and queried the AWS CloudTrail dataset (7,963 events) to analyze unauthorized API calls originating from the attacker's IP address (3.72.63.40). 
Open-Source Blockchain Intelligence: Utilized block explorer data and cryptocurrency tracking tools to analyze the Solana payout wallet address (SOL:HkGz4KmoZ7Zmk7HN6ndJ31UJ1qZ2qgwQxgVqQwovpZES) and link it to the Drift Protocol exploit.
