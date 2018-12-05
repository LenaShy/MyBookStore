Set-ExecutionPolicy Bypass -Scope Process -Force 
Import-Module WebAdministration
$IISSiteName = "BookStore"
$RepoFolderPath = "C:\BookStoreRepo" 
$SiteFolderPath = "C:\BookStore"
$AppPoolName = "BookStoreAppPool" 
$HostHeader = "www.BookStore.com"
$GitHubUrl = "https://github.com/LenaShy/MyBookStore" 



if(!(Test-Path("$RepoFolderPath"))) 
{ 
    New-Item $RepoFolderPath -type Directory # creating folder with repo
    Set-Location -Path $RepoFolderPath # go to location where repo is sited
    git clone $GitHubUrl

} 
else # if folder exist
{
    Set-Location -Path "$RepoFolderPath\MyBookStore" # go to location where repo is sited
    git pull
}

Set-Location -Path "$RepoFolderPath\MyBookStore" # go to inner folder in cloned repo
msbuild # build 


$SiteFolderPath = "$RepoFolderPath\MyBookStore\MyBookStore"

if(!(Test-Path ("IIS:\AppPools\$AppPoolName"))) # if not AppPool -> create it
{ 
    New-WebAppPool -Name $AppPoolName
}

If((!(Test-Path "IIS:\Sites\$IISSiteName"))) # if not site -> create it
{ 
    New-Website -Name $IISSiteName -physicalPath $SiteFolderPath -ApplicationPool $AppPoolName 
}

if(!(Get-WebBinding -Name $IISSiteName)) 
{
    New-WebBinding -Name $IISSiteName -Protocol http -Port 80 -IPAddress "*" -HostHeader $HostHeader
}

Stop-WebSite -Name "Default Web Site"

if(Get-Website -Name $IISSiteName | where {$_.State -eq 'Stopped'})
{
    Start-WebSite -Name $IISSiteName
}
