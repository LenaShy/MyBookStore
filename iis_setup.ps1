#Install-WindowsFeature -name Web-Server -IncludeManagementTools
Import-Module WebAdministration

$IISSiteName = "BookStore"
$SiteFolderPath = "C:\BookStore"
$AppPoolName = "BookStoreAppPool"          
$HostHeader = "www.BookStore.com" 

if(!(Test-Path("$SiteFolderPath"))) {
    New-Item $SiteFolderPath -type Directory
    Set-Content $SiteFolderPath\Default.htm "<h1>Hello IIS</h1>"
}

if(!(Test-Path ("IIS:\AppPools\$AppPoolName"))) {
    New-WebAppPool -Name $AppPoolName
}

If((!(Test-Path "IIS:\Sites\$IISSiteName"))){
    New-Website -Name $IISSiteName -physicalPath $SiteFolderPath  -ApplicationPool $AppPoolName        
}

if(!(Get-WebBinding -Name $IISSiteName)) {
    New-WebBinding -Name $IISSiteName -Protocol http -Port 80 -IPAddress "*" -HostHeader $HostHeader
}

Start-WebSite -Name $IISSiteName
