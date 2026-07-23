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
- .
# Azure App Server plan is the scale unit of App Service applications.
1. AAS has three pricing tiers: shared compute (free and shared are the two base tiers) run on the same Azure vms as other app services, including apps of other customers.
    1. the shared compute tiers allocate CPU quotas to each app and can't scale out
    2. these shared tiers are only intended for dev and testing purposes.
    3. No sla for free tiers
2. dedicated compute. Tiers: basic, standard, premium, premiumV2, premiumV3 all run on dedicated vms
3. isolated and isolatedV2 tiers run dedicated vms on dedicated Azure VNets
  
- Scale up and out on App Service
- Automatic scaling aka Elastic scaling for PremiumV2 and V3 tiers is a separate feature that automatically scales in response to incoming HTTPs requests without needed a config
- automatic scaling is managed by Azure platform.
- maintains warmed instances for immediate response to traffic spikes
- deployment slots allow you to automatically or manually swap slots (e.g. staging and production slots) to seamlessly promote content to web traffic.
- App Service security is set by selecting features in the Azure portal (no SDKs, or code changes). The module handles authentication and authorization.
- App Service offers free managed TLS certicates, which auto-renew 30 days before expiry.
- You can backup and restore your App Service configuration, file content, connected databases. You need a storage account and container in the same subscription as the app. Backups can be up to 10gb of file and database.
- each backup contains a zip file and a XML file. The zip contains the data and the XML is the manifest.
- full backups contain everything and when restored will overwrite everything. Any data outside of the backup gets deleted (files).
- Azure Application Insights lets your monitor your apps, including .NET, Node.js, and Java EE. Insights works on any public cloud or on-prem hosted apps. Integrates with Azure Pipeline processes.
✅ Lab 09 - implement web apps
- configure scaling under App Service Plan
- load test your app
   
  
# Azure Container Instances
- containers use a Docker engine. Docker is an orchestration engine. It passes actions from containers directly through to the host OS. Docker makes it so that we can run virtualized apps under the host OS instead of abstracting with a hypervisor host OS.
- containers provide lightweight isolation from host and other containers. It does not provide as strong a security boundry as a virtual machine.
- vms run a complete OS and therefore consume more of the host's resources; containers can be configured to run only the needed services.
- you can deploy individual containers by using Docker via the cmd line. you can deploy multiple containers with an orchestrator such as Azure Kubernetes Service.
- containers use Azure Disks for local storage or Azure Files (smb) for shared storages for multi-nodes.
- all containers are created from container images. container images are lightweight, standalone, executable packages of software.
- containers can start fast, sometimes in seconds.
- containers can be directly exposed to the internet with an IP address and FQDN.
- you specify the CPU cores and memory for each container at deployment time. Resource allocation is fiexed for the lifetime of the container group.
- container groups are tied together. boot together and are tied to same host.
- container group is similar to a Kubernetes pod. a container has one group but a group can have multiple containers.
- 3 ways to deploy a multi-cpntainer group: ARM template, Bicep, YAML files.
- Azure Container Apps - serverless container for apps, dynamic scaling, runs on top of Azure Kubernetes Service. Common scenarios: deploying API endpoints, hosting background processing jobs, running microservices.
- Azure Container Apps does not provide direct access to the underlying Kubernetes APIs.
  
✅ Lab 09b - Implement Azure Container Instances
- container deployed with linux helloworld image. tested with Chrome and Edge browsers on the public IP. test successful. checked the container logs to see HTTPS traffic entries.
  
  
# Azure Virtual Networks
- a virtual representation of your network in the cloud.
- an Azure virtual network is a logical isolation of Azure cloud resources.
- each virtual network has its own Classless Inter-Domain Routing (CIDR) block.
- Site-to-site VPNs use IPSEC to provide secure connections between your corporate VPN gateway and Azure
- the subnet is housed within the virtual network
- you can use virtual networks to provision and manage VPNs
- virtual networks cannot overlap (subnets)
- 5 ips from each subnet are reserved.  .0, .1, and .255 ; gateway (identifies the virtual network address), default gateway, broadcasts.  Azure also requires .2 and .3 to handle DNS requests.
- public ip addresses are availble and are often used with load balancers. IPv4 and IPv6 addresses are charged at the same rate.
- public ip SKU must match the SKU of the load balancer with which it is used. it must also match the tier of the load balancer.
- examples of resources that can use public ips: vms, load balancer, VPN gateway, application gateway
- examples of resources that can use private ips: vms, internal load balancer, application gateway 
- private ips can be dynamically or static assigned. the ips come from the address range of the virtual network subnet
  
✅ Lab 01 - Create and configure virtual networks. created two vnets and linked with virtual network peering.
  
✅ Lab 04 - Implement Virtual Networking. 
- created two virtual networks, configured vnet peering, added network security groups (with rules), added application security group.
- created a public DNS zone and then a 'www' A-record.
- DNS services must be homed in a region, even thought DNS is global and region bound, its metadata needs to reside somewhere.
- DNS zones are assigned four (4) DNS name servers.
- created a private DNS zone. private zones provide name resolution internally. In Azure private zones resolve to virtual networks within Azure. Link the private dns zone to a virtual network so the vms in the vnet can use the zone.
- optionally you can enable autoregistration so the virtual machines deployed into the vnet are automatically registered in the DNS zone. Without autoregistration enabled, the vms just use the zone as a lookup zone.
  
  
  
# Azure Network Security Groups
- you can limit traffic in your virtual network by using a NSG. You can assign a NSG to a subnet or a NIC.
- most commonly applied at the subnet level. can also apply to a single NIC/vm to be very specific.
- a single NSG can be used across many subnets
- you can use NSGs to create a protected subnet (DMZ) - such as a DMZ between external and internal networks.
- each subnet can have a maximum of one associated NSG.
- each NIC in a subnet can have 0 or 1 associated NSGs.
- default security rules tend to be assigned a lot priority in the 65000 area.
- rules are applied from bottom to top (655xx upwards to 100)
- you can configure priority between 100-4096
- NSGs are created with default rules: DenyAllInbound and AllowInternetOutbound traffic
- some of the critera for configuring rules: source, source port ranges, destination, protocol, action (allow or deny), priority (100-4,096) - some of the protocols are only available via JSON & PowerShell (ESP & AH protocols).
- you cannot remove the default security rules
- you can override a default security rule by creating another rule with higher Priority.
- if you want to set a rule to pass traffic through a NSG you must repeat that rule on every downstream NSG. For example. NSG2 at the subnet level then NSG1 at the NIC level.
- Use the Effective Security Rules link, under Network Monitoring & Management, to analyze security rules
- augmented security rules - combines multiple values into one rule. in larger environments this can help to prevent NSG rule sprawl.
- Application Security Groups (ASG) - group your vms by workload in a network layer. You use the ASG as a source or destination in your NSG security group rules.
   
  
# Host your domain on Azure DNS
- Azure DNS is a hosting service for DNS domains that provide name resolution.
- DNS is a TCP/IP protocol (53)
- DNS server is aka name server
- DNS server maintains a local cache of recent lookups. This cache provides a faster lookup than going out to a remote DNS server. At Envision and Sheridan we ran DNS on the DCs and occassionally would clear the DNS cache as part of name resolution troubleshooting. You could actually see the cached entry list through the DNS managmenet tool in Windows Server.
- DNS servers also maintain the key-value pair database of IP addresses and any host or subdomain over which the DNS server has authority. At Envision we would host subdomains for internally lookup for things like our intranet, development, internal applications.
- When you are assigned an IP from DHCP, you typically also get the IPs of your local DNS servers. These were configured on Envision's DHCP servers. In smaller environments I would have DNS and DHCP running on the same server. In larger enterprises it sometimes was better to separate these services for security and performance.
- When you connect to your ISP, for instance Comcast, the ISP will assign you an IP along with DNS servers that the ISP maintains. DNS lookups that aren't cached on your PC will be relayed to those ISP DNS servers to see if they have cached entries or they will lookup or forward the request. local->ISP->DNS Resolver->root nameserver->TLD nameserver->authoritative nameserver
- IPv4 has four sets of numbers 127.0.0.1
- IPv6 has eight sets of hexadecimal numbers ffff.ffff.ffff.ffff.ffff.ffff.ffff.ffff
- DNs record types: A record (host), CNAME (alias), MX (mail), TXT (text strings). Also: wildcards, CAA (certs), NS (name server), SOA (start of authority), SPF (sender policy framework), SRV (server location)
- for public DNS zones. Register a domain name. Create an Azure public DNS zone. Copy your zone's Azure DNS servers. Use the registrar service to update it's records to point the Azure DNS servers you copied (NS records). Changing NS details is called Domain Delegation. Use all four name servers provided by Azure DNS.
- Verify domain delegation after waiting aproximately 10 minutes for propagation. Then perform a nslookup of the SOA for your domain. e.g. nslookup -type=SOA ryanlabs.com
- after domain delegation you can update the DNS records of your Azure DNS zone.
- Canonical Name (CNAME) must always point to a domain record.
- Time to Live (TTL) time duration in seconds for time a cached DNS entry exists before expiring and being elible for refresh query.
- apex domain is your domain's highest level. e.g. ryanlabs.com. Two apex domain records: NS and SOA.
- alias DNS records can point to Traffic Manager profile, Content Delivery Network endpoints, public IP resource, front-door profile
- alias record supports: A-record (IPv4), AAAA-record (IPv6), CNAME record
  
# Exercise: git clone https://github.com/MicrosoftDocs/mslearn-host-domain-azure-dns.git
- this exercise uses a shell script (bash) to configure resources in Azure. NSG, two NICs, a VNET, two VMs, a public IP address, a load balancer that references a backend pool containing the two vms (NICs)
- the /setup.sh script did not work as-is. I had to modify it to use eastus2 region and added a line to the vm resource, "--size Standard_D2s_v3". I kept running into vm sizing and region limitations on this subscription.
- once all resources were created in a new resource group, 'az-104-c' I was able to verify the external IP cycles between the web servers on vm1 and vm2. 
  
# Virtual Network Peering
- virtual network peering; regional peering or global peering
- can peer vnets in different subscriptions, different tentants
- global peering of vnets in different Azure Gov regions is not permitted
- can create global peering of vnets in any Azure public cloud region or in any China cloud region
- no downtime during peer creation process
- must have non-overlapping IP address spaces
- if you want to change a vnet's address range you must first delete the peering, make the change, then recreate the peering
- Basic Internal Load Balancer does not cross peers. You must use the Standard Load Balancer for cross-region connections.
- DNS resolution does not cross the peering boundaries
- virtual network peering is deal for hub and spoke networking
- gateway transit with peering to allow remote networks to transit across the peered networks
- a vnet can only have one VPN gateway
- gateway transit is supported for both regional and global virtual peering
- you can use NSGs to control flow between the vnets
- the second vnet in the peering is referred to as the remote network
- peering has status conditions of either Initiated or Connected
- vnet peering is non-transitive
- service chaining is used to direct traffic from one vnet to a virtual appliance or gateway.



# Lab 05 - Implement Intersite Connectivity
- created two vms in two separate vnets. peer linked the two vnets.
- vm1 -> operations -> Run command -> RunPowerShellScript:  Enable-NetFirewallRule -DisplayGroup "Remote Desktop". Running remote PowerShell commands through Azure portal crashed both Windows servers.
- create a user-defined route to direct traffic from DMZ to a newly created NVA.
- Finished - had some trouble around RDP services but eventually iron it out and was able to access RDP of server1.
  

# Azure Network Virtual Appliance
- az network route-table route create --route-table-name publictable --resource-group "az104-rg5" --name productionsubnet --address-prefix 10.0.1.0/24 --next-hop-type VirtualAppliance --next-hop-ip-address 10.0.2.4
- az network vnet create --name vnet --resource-group "az104-rg5" --address-prefixes 10.0.0.0/16 --subnet-name publicsubnet --subnet-prefixes 10.0.0.0/24
- az network vnet subnet create --name privatesubnet --vnet-name vnet --resource-group "az104-rg5" --address-prefixes 10.0.1.0/24
- az network vnet subnet create --name dmzsubnet --vnet-name vnet --resource-group "az104-rg5" --address-prefixes 10.0.2.0/24
- az network vnet subnet list --resource-group "az104-rg5" --vnet-name vnet --output table
- az network vnet subnet update --name publicsubnet --vnet-name vnet --resource-group "az104-rg5" --route-table publictable
- az vm create --resource-group "az104-rg5" --name nva --vnet-name vnet --subnet dmzsubnet --image Ubuntu2204 --admin-username azureuser --admin-password <password>
- az vm create --resource-group "az104-rg5" --name nva --vnet-name vnet --subnet dmzsubnet --image Ubuntu2204 --admin-username azureuser --admin-password <insert password> --size Standard_D2s_v3
- az network nic update --name nvaVMNic --resource-group "az104-rg5" --ip-forwarding true
-$ ssh -t -o StrictHostKeyChecking=no azureuser@20.96.19.135 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'
  Warning: Permanently added '20.96.19.135' (ED25519) to the list of known hosts.
  azureuser@20.96.19.135's password: 
  net.ipv4.ip_forward = 1
  Connection to 20.96.19.135 closed.

- az vm create --resource-group "az104-rg5" --name public --vnet-name vnet --subnet publicsubnet --image Ubuntu2204 --admin-username azureuser --no-wait --custom-data cloud-init.txt --admin-password "Sup3rC0mPl3x!" --size Standard_D2s_v3
- az vm create --resource-group "az104-rg5" --name private --vnet-name vnet --subnet privatesubnet --image Ubuntu2204 --admin-username azureuser --no-wait --custom-data cloud-init.txt --admin-password "Sup3rC0mPl3x!" --size Standard_D2s_v3


- watch -d -n 5 "az vm list --resource-group "az104-rg5" --show-details --query '[*].{Name:name, ProvisioningState:provisioningState, PowerState:powerState}' --output table"
- PUBLICIP="$(az vm list-ip-addresses --resource-group "az104-rg5" --name public --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)"
- echo $PUBLICIP
- ssh -t -o StrictHostKeyChecking=no azureuser@$PUBLICIP 'traceroute private --type=icmp; exit'
  Warning: Permanently added '20.114.155.124' (ED25519) to the list of known hosts.
  azureuser@20.114.155.124's password: 
  traceroute to private.d5mijzdz0gjeplhixphgafygjb.cx.internal.cloudapp.net (10.0.1.4), 64 hops max
  1   10.0.2.4  0.906ms  0.299ms  0.285ms 
  2   10.0.1.4  1.224ms  0.643ms  0.594ms 
  Connection to 20.114.155.124 closed.
  
- the first hop is the IP address of the NVA vm. The second hop is the address of the private vm.

# Azure Load Balancer
- Azure Load balancer is a service that allows you to direct incoming network traffic across a group of Azure vms
- load balancing rules determine how to distribute the traffic
- health probes determine which nodes are healthy and can receive traffic
- public load balances maps the public IP address and port to the private internal backend servers
- public load balancers can provide outbound connections for your vms.
- internal load balancer directs traffic to resources inside a vnet or that use a VPN to access Azure infrastructure. Internal load balancer front end IP addresses are never exposed to the internet endpoint.
- Azure Load Balancers operate at the Transport Layer of the OSI model. Layer 4.
- Session affinity - ensures that the same pool node (vm) handles traffic for a client. AKA Session Persistence.
- High availability ports. a load balancer rule configured with 'protocol - all and port - 0' is knowsn as a High Availability (HA) port rule. Uses five-tuple connections.
- You can also use NAT rules on a load balancer. e.g. NAT public address to TCP 3389 to a specific VM, like a jump box.
- Source Network Address Translation (SNAT) rule for outbound VMs.
- Azure Front Door - alternative to load balancer, that provides layer 7 global load balancing and site acceleration
- Azure Traffic Manager - DNS based load balancer that works only at domain level. DNS caching makes this slow to fail over.
- Azure Application Gateway - App Delivery Controller (ADC) various layer 7 load balancing capbilities. Optimize web farm productivity by off-loading TLS/SSL termination to the gateway.
  

# Azure Application Gateway
- Session stickiness ensures client requests in the same session are routed to the same back-end server.
- Application Gateway uses round-robin process to balance traffic to back-end pool
- supports: HTTP, HTTPS, HTTP/2, WebSocket protocols
- Web Application Firewall (WAF)
- End-to-end encryption
- Autoscaling to adjust capacity
- Connection draining to allow graceful removal of back-end pool members for maintenance.
- Application Gateway can not have more than one public IP and one private IP.
- Listeners: Application Gateway uses one or more listeners to receive incoming requests.
- Web Application Firewall (WAF) uses OWASP generic rules. Core Rule Sets 3.2, 3.1, 3.0. and 2.2.9. v3.1 is the default.
- WAF can also limit transfers of large files as to keep them from overwhelming your servers.
- Path-based routing uses the URL paths to determine which pool of servers to connect to.
- Multiple-site routing uses the domain name to determine which pool of servers to connect to.
- Health probes return a status code HTTP 200-399 for healthy servers. Default health probe is to wait 30 seconds for a response before marking the server unhealthy.
- WebSock and HTTP/2 communicates over HTTP ports 80 and 443.
  

# Azure Network Watcher
- Network Watcher is designed to monitor and repair the network health of IaaS products like vms, vnets, AGs, LBs. It is NOT designed for PaaS monitoring or Web analytics.
- Network Watcher consists of three major sets of tools and capabilities
  - Monitoring
  - Network Diagnostic (7 diagnotic tools: IP flow verify, NSG diags, Next hop, Effective Security Rules, Connection Troubleshoot, Packet capture, VPN troubleshoot)
  - Traffic (two tools: flow logs and traffic analytics)0
  

# Azure Backup
- Backup built into Azure for VMs, Azure Disks, SQL and SAP Databases, Azure File Shares, and Blobs, Kubernetes Clusters
- Can also backup on-premises servers with agents (Microsoft Azure Recovery Services (MARS) agent).
- zero-infrastructure needed
- Recovery Time Objective (RTO) is the target time within which a business process must be restored after a disaster
- Recovery Point Objective (RPO) is the maximum amount of data loss, measured in time, that your organization can sustain during an event.
- Data Plane - Access Tiers: Snapshot tier, Standard Tier, and Archive Tier
- You can use the MARS agent to backup files and folders on a VM instead of the entire VM itself.
- Backup data is stored in vaults; Recovery Services vaults and Backup vaults.
- Microsoft MARS agent can be used to backup the files, folders, and system state of the VMs.
- Azure Backup offers a stream-based specialized solution to backup SQL servers running on Azure VMs.
- Azure Backup integrates with Log Analytics for monitoring and reporting and provides reports via Workbooks.
- Backup restore types: restore to a new virtual machine, restore disk, replace existing disk on vm, cross-region restore, cross subscription restore, selective disk restore
- a backup cannot be restored if the VM is allocated and running. Stop the VM in order to restore it.
  

# Azure Monitoring








  
** Defender for Cloud
- connected Defender to GitHub
- connected Defender to Azure DevOps




## Current Module

- Azure Monitoring





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
- ✅ Blob Storage
- ✅ Virtual Machines
- ✅ Networking
- ✅ Backup
- ✅ Monitoring




'''