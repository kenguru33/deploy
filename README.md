Create New Deployment

Instaall required tools:

```
sudo choco install intunewinapputil
```

Example Create a package for 7zip:

```
create 7zip
build 7zip
```

Upload the package to intune 32 bit app.

install cmd: 
```
powershell.exe -windowstyle hidden -executionpolicy bypass -command .\install.ps1
```
uninstall cmd:
```
powershell.exe -windowstyle hidden -executionpolicy bypass -command .\uninstall.ps1
```
