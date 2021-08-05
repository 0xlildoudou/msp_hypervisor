# Change ip with powershell

netsh interface ipv4 show interfaces
New-NetIPAddress -InterfaceIndex 3 -IPAddress 192.168.1.1 -PrefixLength 24

# add failover on node of cluster

Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools

Install-WindowsFeature –Name Hyper-V -IncludeManagementTools –Restart

Set-DnsClientServerAddress -InterfaceIndex 3 -ServerAddresses ("192.168.1.101")

### intergration dans le domain
Add-Computer -DomainName autoroot.com -DomainCredential administrator@autoroot.com

### check Target Portal
New-iSCSITargetPortal –TargetPortalAddress w2019-main.autoroot.com

#Add iscsi target on w2019 server

Add-WindowsFeature FS-iSCSITarget-Server

Get-Disk
Initialize-Disk -Number 1 –PartitionStyle MBR
New-Partition –DiskNumber 5 -UseMaximumSize -DriveLetter J
Get-Volume
Format-Volume -DriveLetter E -FileSystem NTFS -Confirm:$false

New-IscsiVirtualDisk c:\data\LUN1.VHDX –size 95GB

Set-Service -Name MSiSCSI -StartupType Automatic
Start-Service -Name MSiSCSI
            # iqn.1991-05.com.microsoft:hyper-v-02
            # iqn.1991-05.com.microsoft:hyper-v-01

## iscsitarget
(Get-InitiatorPort).NodeAddress     # iqn.1991-05.com.microsoft:w2019-main

Add-IscsiVirtualDiskTargetMapping iSCSI-autoroot c:\data\LUN1.vhdx

New-IscsiTargetPortal -InitiatorPortalAddress "192.168.1.1" -InitiatorInstanceAddress "192.168.1.101" -InitiatorInstanceName "ROOT\ISCSIPRT\000_0"

# Create virtual switch on hyper-v node

Get-NetAdapter

# Create ADDS Domain

Add-WindowsFeature AD-Domain-Services
Install-ADDSForest -DomainName autoroot.com -InstallDNS

# Enable Ping

Import-Module NetSecurity
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" -enabled True
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-Out)" -enabled True