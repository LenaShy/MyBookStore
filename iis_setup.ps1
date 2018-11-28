#Install-WindowsFeature -name Web-Server -IncludeManagementTools
Import-Module ServerManager
Add-WindowsFeature Web-Scripting-Tools
Import-Module WebAdministration
$SiteFolderPath = "C:\WebSite"              # Website Folder
$SiteAppPool = "MyAppPool"                  # Application Pool Name
$SiteName = "MySite"                        # IIS Site Name
$SiteHostName = "www.TestSite.com"          # Host Header

New-Item $SiteFolderPath -type Directory
Set-Content $SiteFolderPath\Default.htm "<h1>Hello IIS</h1>"
New-Item IIS:\AppPools\$SiteAppPool
New-Item IIS:\Sites\$SiteName -physicalPath $SiteFolderPath -bindings @{protocol="http";bindingInformation=":80:"+$SiteHostName}
Set-ItemProperty IIS:\Sites\$SiteName -name applicationPool -value $SiteAppPool