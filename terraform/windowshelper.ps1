<powershell>
Get-NetFirewallRule -DisplayGroup "File and Printer Sharing"|Set-NetFirewallRule -Profile 'Private, Public, Domain' -Enabled true
net user ansible AFMZCQAaukS5Wt44hbUF /add /expires:never /y
net localgroup "Administrators" ansible /add
net localgroup "Remote Desktop Users" ansible /add
Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/AlbanAndrieu/ansible-windows/master/files/ConfigureRemotingForAnsible.ps1'))

</powershell>