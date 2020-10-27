<#
.SYNOPSIS 
    Export VM .RDP files for a given Azure service.

.DESCRIPTION
    The following script will export all VM .RDP connections to c:\AzureRDP folder.  The folder must be created by hand before the script is run.

.PARAMETER ServiceName
    Cloud Service the Azure VM is running under.

.PARAMETER SubscriptionName
    Name of the Azure subscription being selected.

#>


Param

(

[parameter(Mandatory=$true)]

[String]

$ServiceName,

[parameter(Mandatory=$true)]

[String]

$SubscriptionName


)

Add-AzureAccount

select-azuresubscription "$SubscriptionName"

Get-AzureVM $ServiceName | foreach { 
	$rdpexportfile = 'c:\AzureRDP\' + $_.Name + '.rdp'
	Get-AzureRemoteDesktopFile -ServiceName $ServiceName -Name $_.Name -LocalPath $rdpexportfile
}

