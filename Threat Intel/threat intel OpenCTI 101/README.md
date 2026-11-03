scenario URL: https://cyberdefenders.org/blueteam-ctf-challenges/opencti-101-apt29/ 

Threat Intelligence Incident Analysis: APT29 Campaigns, Tooling & Phishing Infrastructure

📜 Executive Summary & Incident Scenario

An internal investigation profiling APT29 (also known as Cozy Bear, IRON HEMLOCK, NobleBaron, Dark Halo, NOBELIUM, and UNC2452)—widely attributed to Russia's Foreign Intelligence Service (SVR)—was conducted using OpenCTI based on intelligence records and historical campaigns. The actor demonstrates a highly patient and adaptive operational tempo, evidenced by major intelligence collection efforts such as the SolarWinds Supply Chain Compromise and Operation Ghost. Recent 2023 operations heavily utilized diplomatic-themed phishing lures (spoofing Czechia, Türkiye, Norway, and Poland) to distribute ISO, ZIP, PDF, and SVG payloads powered by ROOTSAW droppers and weaponized shortcuts designed to execute payloads via rundll32.   

🔍 Threat Intelligence & MITRE ATT&CK Alignment

MITRE ATT&CK Mapping: Phishing: Spearphishing Link (T1566.002) via embassy-themed URLs linking to malware delivery sites. Phishing: Spearphishing Attachment (T1566.001) via attached SVG files in June 2023 campaigns. Obfuscated Files or Information: HTML Smuggling (T1027.006) via ROOTSAW delivery of ZIP/ISO archives. Compromise Infrastructure (T1584) via abused WordPress servers and compromised third-party websites hosting payloads. User Execution: Malicious File (T1204.002) via victim opening ISOs containing shortcuts and DLLs. System Binary Proxy Execution: Rundll32 (T1218.011) via shortcut execution invoking rundll32.exe BugSplatRc64.dll, InitiateDs. Proxy: Domain Fronting (T1090.004) via the meek Tor tunneling plugin. Data Transfer Size Limits (T1030) and Exfiltration Over Alternative Protocol (T1048) observed in recent exfiltration patterns. 

Threat Actor & Campaign Context: APT29 continuously evolves its delivery mechanisms to reduce host-side artifacts, ranging from server-side user-agent anti-analysis filtering and URL shorteners (TinyURL) to returning custom or generic HTTP 404 errors on compromised WordPress hosts to throw off investigators. Their 15-tool arsenal balances offensive frameworks and evasion mechanisms like meek (an open-source Tor plugin tunneling traffic over HTTPS via domain fronting) alongside post-exploitation utilities like Cobalt Strike and EnvyScout.   Impacted Campaign Assets & Indicators:

Domains & Infrastructure: crossfity[.]com, techspaceinfo[.]com, literaturaelsalvador[.]com   
Phishing & Redirect URLs: https://sylvio[.]com[.]br/form.php, https://tinyurl[.]com/mrxcjsbs, [https://www.willyminiatures](https://www.willyminiatures)[.]com/e-yazi.htm/?v=bc78a8d162c6  
Malware & Payloads: e-yazi.htm (MD5: a3067a0262e651e94329869f43a51722), e-yazi.iso, e-yazi.pdf, and SVG-based ROOTSAW (295527e2e38da97167979ade004de880)  
Execution Artifact: LNK file (38b05aa4b5ba651ba95f7173c5145270) loading BugSplatRc64.dll via rundll32.exe 

⚒️ Tools & Technologies LeveragedOpenCTI (STIX2 Platform):

Utilized for centralizing threat intelligence data, structuring intrusion sets, correlating threat reports, and pivoting across threat actor observables and indicators.
MITRE ATT&CK Kill Chain View: Applied to analyze and visualize APT29's tactics, techniques, and procedures (TTPs), specifically mapping out exfiltration, defense evasion, and discovery categories.
AlienVault OTX: Leveraged to ingest external threat pulses, track malicious indicators of compromise (IOCs), and extract file hashes, YARA rules, and C2 URLs.   
