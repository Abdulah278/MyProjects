Investigation URL: https://cyberdefenders.org/blueteam-ctf-challenges/awsraid/

Cloud Infrastructure Incident Analysis: "AWS Raid" S3 Exfiltration & IAM Compromise

📋 Executive Summary & Incident Scenario

An automated credential brute-force campaign targeted internal enterprise AWS IAM user accounts, detected via CloudTrail logs ingested into Splunk. The threat actor (originating from IP range 185.192.70.0/24, primarily 185.192.70.78) successfully compromised the support staff user identity helpdesk.luke. Once inside the management console, the adversary executed systematic data theft from multiple AWS S3 buckets, weakened security controls by modifying bucket public access blocks, and established long-term persistence by provisioning a backdoor administrative user (marketing.mark) added directly to the Admins group.

🔍 Threat Intelligence & MITRE ATT&CK Alignment

MITRE ATT&CK Mapping:
Initial Access: T1078.004 (Valid Accounts: Cloud Accounts) via brute-force against helpdesk.luke.  
Discovery: T1530 (Data from Cloud Storage Object Storage) via systematic enumeration of S3 storage buckets.  
Collection: T1213.003 (Data from Information Repositories: Cloud Storage) via exfiltration of sensitive prototype files, CAD drawings, and customer database backups. 
Defense Evasion: T1562.007 (Impair Defenses: Cloud Storage Object Protection Modification) via PutBucketPublicAccessBlock execution against backup-and-restore98825501.   Persistence: T1136.003 (Create Account: Cloud Account) via provisioning of the unauthorized IAM user marketing.mark.   
Privilege Escalation: T1098 (Account Manipulation) by assigning the backdoor identity to the administrative Admins group. 

Impacted Storage Assets:research-project-files23411723 (prototype.obj)  
product-designs-repository31183937 (Product2_CAD_Designs.dwg)  
marketing-assets-vault27512203 (logo.png)   
legal-docs45020393 (Contract_agreement.pdf)  
customer-data-backup57893984 (CustomerData_Backup_2023-11-01.zip)  
backup-and-restore98825501 


🛠️ Tools & Technologies Leveraged

AWS CloudTrail: Provided comprehensive core telemetry for tracking management console logins, S3 data events (GetObject, ListObjects), security block configurations (PutBucketPublicAccessBlock), and IAM user/group modifications.   
Splunk SIEM: Utilized to aggregate log data, execute search syntax queries, and visualize chronological patterns of brute-force attempts and data exfiltration vectors.   
