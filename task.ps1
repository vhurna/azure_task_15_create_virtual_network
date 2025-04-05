$location = "uksouth"
$resourceGroupName = "mate-azure-task-15"

$virtualNetworkName = "todoapp"
$vnetAddressPrefix = "10.20.30.0/24"
$webSubnetName = "webservers"
$webSubnetIpRange = "10.20.30.0/26" # Діапазон для підмережі webservers
$dbSubnetName = "database"
$dbSubnetIpRange = "10.20.30.64/26" # Діапазон для підмережі database
$mngSubnetName = "management"
$mngSubnetIpRange = "10.20.30.128/26" # Діапазон для підмережі management

Write-Host "Creating a resource group $resourceGroupName ..."
New-AzResourceGroup -Name $resourceGroupName -Location $location

Write-Host "Creating subnets..."
$webSubnet = New-AzVirtualNetworkSubnetConfig -Name $webSubnetName -AddressPrefix $webSubnetIpRange
$dbSubnet = New-AzVirtualNetworkSubnetConfig -Name $dbSubnetName -AddressPrefix $dbSubnetIpRange
$mngSubnet = New-AzVirtualNetworkSubnetConfig -Name $mngSubnetName -AddressPrefix $mngSubnetIpRange

Write-Host "Creating a virtual network with subnets..."
$vnet = New-AzVirtualNetwork -Name $virtualNetworkName -ResourceGroupName $resourceGroupName -Location $location -AddressPrefix $vnetAddressPrefix -Subnet $webSubnet, $dbSubnet, $mngSubnet

Write-Host "Running artifacts generation script..."
.\scripts\generate-artifacts.ps1

Write-Host "Running validation script..."
.\scripts\validate-artifacts.ps1
