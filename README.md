Create New Deployment

```
pkg-create 7zip
pkg-build 7zip
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
