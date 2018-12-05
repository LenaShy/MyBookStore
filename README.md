# About Project
This project helps deploy ASP.NET application to IIS server on virtual machine.
# Goals
The goal of this project is to automate creating VirtualBox and deploying ASP.NET application using Vagrant tool. It takes less time just set your repository url and run one command to check if application will work on remote enviroment.    
# Executive Summary
Vgrant creates and start virtual machine using settings in [Vagrantfile](https://github.com/LenaShy/MyBookStore/blob/master/Vagrantfile).
 [This PowerShell script](https://github.com/LenaShy/MyBookStore/blob/master/iis_setup.ps1) using for automate deploying ASP.NET application on IIS. It clones or pulls source files from remote GitHub repository, builds application with MSBuild and starts it on IIS server.  
# Toolset
To run this box you need:
* VirtualBox 5.2.20
* Vagrant 2.2.0

Preinstalled on base vagrant box:
* Visual Studio build tools
* SQL Server Express 
* Git
# Proccess
1. Get box image.
2. With next command add box localy
```vagrant box add windowsserver WindowsServer.box```.   
*Note: you should be in the same folder where `WindowsServer.box` is placed or specify full path.*
3. Create folder for your machine.
4. Add to this folder [Vagrantfile](https://github.com/LenaShy/MyBookStore/blob/master/Vagrantfile) and [iis_setup.ps1](https://github.com/LenaShy/MyBookStore/blob/master/iis_setup.ps1) script.
5. In created folder run
`vagrant up`.  
VirtualBox with new machine will be oppened.
6. Login to `vagrant` account with password `vagrant`.
7. IIS server with your app is already running. To check it browse `http://localhost/`.
# Structure 
diagram
# Output
In output you should see 
```
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'windowsserver'...
...
    default: Running: iis_setup.ps1 as c:\tmp\vagrant-shell.ps1
 ```
After will be results of PowerShell script executing. And VirtualBox machine will be appeared.
    
    
