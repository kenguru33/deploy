Create New Deployment

```
mkdir 7zip
cp choco-template/install.ps1
cp choco-template/uninstall.ps1
choco-template/detect.ps1
touch New-Item -Path . -Name "7zip" -ItemType "file"
```

Change packageName variable in all 3 files

Create a MEM package:
```
IntuneWinAppUtil.exe -c 7zip -s 7zip -o .
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
