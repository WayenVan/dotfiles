# starship init
Invoke-Expression (&starship init powershell)

$local_profile = "$HOME/Documents/PowerShell/local_profile.ps1"
# check if local profile exists
if (Test-Path -Path $local_profile) {
    & $local_profile
} else {}

# set alias of command
Set-Alias ll ls
