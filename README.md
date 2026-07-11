## New workspace for Azure Administrator exam - AZ-104
'''


- naming convention rg-az104
- region - uswest2
- storageacctaz104, uswest2, Azure Blob Storage, Standard (gpv2), LRS



Administrator Career Path
https://learn.microsoft.com/en-us/plans/50nrtozg28d354



Azure Administrators have subject matter expertise implementing, managing, and monitoring an organization’s Microsoft Azure environment. Responsibilities for this role include implementing, managing, and monitoring identity, governance, storage, compute, and virtual networks in a cloud environment, plus provision, size, monitor, and adjust resources.




AZ-104: Prerequisites for Azure administrators (completed)
AZ-104: Manage identities and governance in Azure (completed)
AZ-104: Implement and manage storage in Azure (in progress)
    - created storage accounts
    - created containers
    - uploaded blob objects to containers
    - used public anonymous access to test blob object URL from external
    - used versioning (similar to NetApp snapshot)
    - SAS (shared access signatures) - Use a URI for clients that you don't want to have access to your keys. SAS has an expiration. Keep it as short as possible.
    - encryption is on by default and the keys are either managed by Microsoft or by customer (CMK - customer managed keys)
    - infrastructure encrypting can be enable to provide a second/double layer of encryption, above the default service-level encryption
    - PMKs - platform managed keys are generated, stored, and managed entirely by Azure
    - Monitoring - Insight (Storage Insights)
    - lock down public access by enabling select networks; add your own IP address as the only network permitted access
    - data management - lifecycle management : create rules to move data to lower (cooler) tiers after specified time periods
    - you can lock down a container or blob to a single ip, range, or vnet
    -
    # Azure Files
    - a share can store 100TiB.  Tebibyte is different than Terabyte.
    - a single file can be up to 4 TiB

    - serverless deployment
    - encrypted at rest and transit
    - control access with Entra or AD->synced.
    - can leverage previous versions and snapshots
    - backup with Azure Backup
    - replication controlled by the storage account settings
    - Azure File Sync - replicate Azure File shares to Windows Servers (on-prem)
    - supports NFS and SMB protocols (not simultaneously on same share)
    - authentication: SMB identity (AD, Entra DS, Entra Kerberos), access key, Shared Access Signature (SAS)        *SMB uses port 445**
    - snapshots - point-in-time copies (deltas similar to NetApp snapshots?)
    - up to 200 snapshots per share
    - 



** Defender for Cloud
- connected Defender to GitHub
- connected Defender to Azure DevOps




## Current Module

- Azure Storage Security





## Topics

- Azure Storage
- Virtual Machines
- Virtual Networking
- Azure Files
- Azure Backup
- Azure Monitor
- RBAC
- Microsoft Entra ID
- Azure CLI
- PowerShell
- ARM/Bicep
- Terraform

## Repository Structure

- notes/
- labs/
- scripts/
- screenshots/
- diagrams/

## Current Progress

- ✅ Azure Storage
- ⏳ Blob Storage
- ⏳ Virtual Machines
- ⏳ Networking




'''