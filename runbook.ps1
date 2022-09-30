<#
    .DESCRIPTION
        An example runbook which gets all the ARM resources using the Managed Identity

    .NOTES
        AUTHOR: Azure Automation Team
        LASTEDIT: Oct 26, 2021
#>

"Please enable appropriate RBAC permissions to the system identity of this automation account. Otherwise, the runbook may fail..."

try
{
    "Logging in to Azure..."
    $AzureContext = (Connect-AzAccount -Identity).context
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}

#Findig vm status
$status = (Get-AzVM -ResourceGroupName Batch10 -Name LINUXVM -Status).Statuses[1].Code
$status
#updating vm status

if($status -eq "PowerState/running"){
	stop-AzVM -Name LINUXVM -ResourceGroupName Batch10 -DefaultProfile $AzureContext -Force
}
elseif ($status -eq "PowerState/deallocated"){
    start-AzVM -Name LINUXVM -ResourceGroupName Batch10 -DefaultProfile $AzureContext
}
