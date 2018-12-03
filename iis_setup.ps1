Set-ExecutionPolicy Bypass -Scope Process -Force 
#iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#Install-WindowsFeature -name Web-Server -IncludeManagementTools
choco install git.install
choco install visualstudio2017-workload-webbuildtools
choco install visualstudio2017buildtools
choco install nuget.commandline
choco install nuget.commandline
Import-Module WebAdministration

$IISSiteName = "BookStore"
$SiteFolderPath = "C:\BookStore"
$AppPoolName = "BookStoreAppPool"          
$HostHeader = "www.BookStore.com"
$GitHubUrl = "https://github.com/LenaShy/MyBookStore.git" 
 

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
