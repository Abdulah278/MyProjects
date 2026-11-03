Lab URL: https://cyberdefenders.org/blueteam-ctf-challenges/achievements/abdulah/redishell-kinsing/

Digital Forensics & Incident Analysis: "Redishell - Kinsing" Container Breakout & Infrastructure Compromise

📋 Executive Summary & Incident Scenario

A sophisticated, multi-stage intrusion targeted a development network environment comprising a Jenkins CI/CD container (172.16.10.10), a Redis database container (172.16.10.20), and the underlying physical host node (redis-db.corp.local). Initiated from external IP 185.220.101.50, the threat actor exploited an unauthenticated Jenkins Script Console to gain initial access, harvested plaintext credentials, moved laterally via unencrypted Telnet to the Redis server, executed a Lua engine remote code execution exploit alongside a misconfigured SUID binary to achieve root inside the container, and finally executed a container breakout to compromise the underlying physical host node.

🔍 Threat Intelligence & Kinsing Malware Context

Kinsing Malware Operations: Kinsing is a well-known cybercriminal threat group and cryptojacking malware campaign that targets misconfigured containers, cloud environments, and vulnerable web applications (such as Jenkins, Redis, and Elasticsearch). Known for automated discovery, rapid lateral movement, and container breakout capabilities, Kinsing frequently drops cryptominers, malicious rootkits, and persistence mechanisms to exploit underlying computing resources.

MITRE ATT&CK Mapping: The incident maps across several tactics and techniques, including T1190 (Exploit Public-Facing Application) via the Jenkins Script Console, T1552.001 (Unsecured Credentials) via discovery of credentials.txt, T1068 (Exploitation for Privilege Escalation) via the Redis Lua flaw and SUID binary abuse, T1611 (Escape to Host) via cgroup v1 release_agent abuse (CVE-2022-0492) and nsenter namespace escalation, T1105 (Ingress Tool Transfer) for staging scripts like linpeas.sh and escape.sh, and T1562.001 (Impair Defenses: Disable or Modify Tools) via the termination of the active tcpdump packet capture process (kill -9).

Attack Progression & Mechanics:

Initial Access: The attacker targeted the unauthenticated /script endpoint on Jenkins 2.387.1, executing Groovy payloads to deploy an interactive bash reverse shell on port 4444.

Lateral Movement: Automated enumeration via LinPEAS exposed a plaintext credentials file (/var/jenkins_home/credentials.txt) containing credentials for an unencrypted Telnet service on the Redis server (172.16.10.20).

Privilege Escalation: Exploiting Redis version 5.0.7 via a crafted Lua script (exploit.lua mapped to CVE-2025-49844), the attacker gained code execution as redis_user and leveraged a vulnerable SUID binary (/usr/local/bin/redis-backup) to escalate to container root.

Host Breakout: Using the downloaded breakout script (escape.sh), the threat actor successfully abused cgroup v1 (CVE-2022-0492) and performed an nsenter namespace escape to break out of the container boundary into the host node, establishing a high-privilege reverse shell on port 5555 and leaving a proof file (/tmp/you_have_been_hacked.txt).

Anti-Forensics & Staging: On the host node, the attacker installed Python's uploadserver via pip, staged custom kernel rootkit files (kernel-rootkit.c, Makefile, install-rootkit.sh) under /root/file/, and terminated the active forensic packet capture (sudo tcpdump) by issuing a kill -9 24918 command.

🛠️ Tools & Technologies Leveraged

Wireshark: Used to analyze network packet captures (monitor.pcap), reconstruct HTTP streams, trace interactive Telnet sessions, and inspect payload transfers.

CyberChef: Employed to decode URL-encoded Groovy command execution strings and initial reverse shell callback parameters.

LinPEAS: Automated enumeration script utilized inside both the Jenkins container and Redis container to discover misconfigurations, weak permissions, and plaintext credentials.

cgroup Escape Scripts & Netcat: Utilized to execute container breakouts via release_agent abuse and set up reverse shell listeners.

Uploadserver (Python): Deployed by the threat actor on the compromised host node to facilitate malicious file uploads on port 8000.
