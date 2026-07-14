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

---
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
- authentication: SMB identity (AD, Entra DS, Entra Kerberos), access key, Shared Access Signature (SAS)        **SMB uses port 445**
- snapshots - point-in-time copies (deltas similar to NetApp snapshots?)
- up to 200 snapshots per share
- ? how does soft delete differ from snapshots ?
- snapshots are a point-in-time read only copy of the data. Soft delete allows the share to be restored or the file(s)?
- soft delete retention period between 1 to 365 days
-
-
# Azure Storage Explorer
- requires management access (Azure Resource Manager) and data layer permissions
-
-
# Azure File Sync
- enables caching of Azure Files (shares) down to on-premises Window Server or cloud VMs.
- supports up to 100 sync groups
- the sync group supports one cloud endpoint (Azure File share) and up to 50 server endpoints
- server endpoint must be a NTFS formatted volume and cannot be a system volume
- Azure File Sync Agent must be installed on each Windows Server.
- consider configuring cloud tiering to move older data off of the local servers and up to Azure Files (cloud)





---

# Azure Virtual Machines
- virtual machines have several required elements
1. the virtual machine
2. disks
3. virtual network
4. NIC
5. NSG to secure network traffic
6. IP address(es)

- Azure reserves the first four ip addresses and the last ip address in each subnet for its use
- VM sizing is targeted for workloads
1. general purpose
2. compute optimized
3. memory optimized
4. storage optimized
5. gpu
6. high performance compute

- vm size can be changed while the vm is running as long as the new size is available in the current hardward cluster the vm is running on.
- the resizing process automatically reboots to complete the request
- you can also stop and deallocate a vm to select any size available in the region since deallocation removes the vm from the cluster it was running on.

- limits on the numbers of NICs depends on vm size
- IP addresses - public IPs cost $ per hour
- virtual network - cost $ per GB
- dynamic public IP cost is halted when vm is deallocated
- static public IP cost regardless if anything is connected
- NSG - no cost
- disk - no charge for local disk, OS disk is charged $
- OS cost $
- every VM costs for compute and storage.
- compute costs are billed per hour
- linux is cheaper due to no OS license
- cost of a vm includes OS
- all vms have at least two virtual hard disks (VHDs). One for OS and a second for temp. Typically a limit of two disks per vCPU.
- max disk sizes range from 32,767 GiB to 65,536 gibibytes (up to ~70 Terabytes)
- exercise to create a vm in the Azure portal (in progress)
- created a Linux vm, assigned a public IP, configured a public SSH key for authentication/logon. Generated a private key to my local pc.
- logged in via cmd line ssh terminal
- ssh -i C:\Users\ryanb\Downloads\ryanvm1_key.pem azureuser@x.x.x.x
- create a Resource Manager Template (JSON) from your vm under Automation -> export template. You can download your template in ARM, bicep or terraform. Before you can utilize terraform you must register it to your subscription.
- auto-shutdown can be used to schedule an automated shutdown.
- virtual machine scale sets. highly available (load balanced) groups of vms for scaling your apps.
- Azure load balancer is included with standard tier vms.
- Azure Site Recovery - replicates workloads from a primary site to a secondary location.
- Azure Backup - backup as a service that protects physical or virtual machines at any location. Application aware snapshots.
- availability sets - contain vms that perform the same functioality; have the same software installed
- vm is added to an availability set at time of creation. To move to a different availability set you must delete and re-create the vm
- availability sets do not cost extra $
- update domain & fault domain; the update domain contains nodes that are upgraded and rebooted together; only one update domain is rebooted at a time. You can create 1 to 20 update domains at time of creation. Default is 5 UDs.
- a fault domain is a group of nodes that represent a physical unit of failure. Typically share a common set of hardware. (i.e. a rack)
- [@EVHC we created a similiar logical separate of servers, sql servers, clusters etc so that patching in groups would no affect resource (app, db) availability]
- availability zones - unique physical locations (like datacenters). Available in two categories: zonal services and zone-redundant services.
- vertical vs horizontal scaling. vertical scaling alters the sizing of the vm. horizontal scaling alters the number of vms.
- vertical sizing requires a vm stop & restart.
- horizontal scaling is more flexible.
- virtual machine scale sets - autoscaling with identical vms. automatically scales the number of identical vms as demand increases and reduces the number of vms as demand decreases.
- vm scale sets have two types of orchestration: uniform and flexible. with uniform, all vms are identical. in flexible, vms can use different sizes, images, configs.
















** Defender for Cloud
- connected Defender to GitHub
- connected Defender to Azure DevOps




## Current Module

- Implementing Azure App Service plans





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