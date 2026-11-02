Investigation URL: https://cyberdefenders.org/blueteam-ctf-challenges/achievements/abdulah/azurespray/


📋 Executive Summary & Incident Scenario

A mid-sized technology company recently migrated its infrastructure to Microsoft 365, shortly after which identity logs began exhibiting a high volume of failed sign-ins. Tasked as the security investigator, my objective was to determine whether the tenant was under an active password spray attack, establish the scope of the campaign, identify any successfully breached accounts, and engineer an automated detection rule in Microsoft Sentinel to catch future occurrences.

🔍 Threat Intelligence & MITRE ATT&CK Alignment

MITRE ATT&CK Mapping: This incident maps directly to T1110.003 (Brute Force: Password Spraying) under the Credential Access tactic, alongside T1078.004 (Valid Accounts: Cloud Accounts).

Attack Mechanics: Password spraying relies on a "low-and-slow" strategy, testing a small set of common passwords against a vast pool of user principal names (UPNs) to deliberately stay under legacy account lockout thresholds.

Adversary Infrastructure: Log profiling revealed that traffic originated from public cloud hosting infrastructure in Frankfurt, Germany, utilizing a static, outdated user agent string—classic indicators of automated credential-testing tooling.

Compromise Analysis: While the vast majority of the password spray traffic failed, a deeper review of subsequent successful authentications (ResultType == 0) uncovered a single compromised account (...hannah@compliantsecure.store) accessed from an unassociated external IP address (18.153.41.155). This highlights a core reality in cloud security: a single weak password can successfully pivot a noisy, failed reconnaissance campaign into an active data breach.

🛠️ Tools & Technologies Leveraged

Microsoft Sentinel & KQL (Kusto Query Language): Utilized as the primary SIEM and query engine to perform deep log triage, aggregate client fingerprints, filter out background noise, and write custom detection rules.

Microsoft Entra ID Sign-in Logs (SigninLogs_CL): Served as the core telemetry source for tracking authentication outcomes, result codes, client application footprints, and geolocation metadata.

Detection Engineering Templates: Leveraged native Microsoft Sentinel rule templates, adapting them via schema-tolerant KQL functions (column_ifexists) to seamlessly integrate with custom log architectures and reduce false positives.
