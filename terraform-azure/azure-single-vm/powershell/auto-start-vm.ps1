# Import the modules
Import-module 'az.accounts'
Import-module 'az.compute'

# Connect to Azure with the System Managed Identity
Connect-AzAccount -Identity


$rg = Get-AutomationVariable -Name 'rg_name'
$Resources = Get-AzResource -ResourceGroupName $rg 
$Resources  | select Name, Type | Out-String


$vm = Get-Azvm -ResourceGroupName $rg
echo "You' vm: " $vm

$vm | Start-AzVM 