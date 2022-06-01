function Set-Permission {
    param ([string]$Path,[string]$User,[string]$Permission,[switch]$Allow,[switch]$Deny,[switch]$Add,[switch]$Del)
    if ($Allow) {$PermissionType = "Allow"} else {if ($Deny) {$PermissionType = "Deny"} else {return "Error: -Allow or -Deny required"}}; $Acl = Get-Acl "$Path"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$User","$Permission","ContainerInherit,ObjectInherit","None","$PermissionType")
    if ($Add) {$Acl.SetAccessRule($AccessRule); Set-Acl "$Path" $Acl} else {if ($Del) {$Acl.RemoveAccessRule($AccessRule); Set-Acl "$Path" $Acl} else {return "Error: -Add or -Del required"}}
}
$_sp = "$env:LOCALAPPDATA\Spotify"; $_spu = "$_sp\Update"; $_u = (Get-LocalGroupMember -Group "Administrators").Name
if (!(Test-Path "$_sp\.update_block")) {
    Write-Output "Install Spotify update block? ` [Enter], [Y] - Yes"; $_k = [Console]::ReadKey($true).Key
    if ($_k -eq "Y" -or $_k -eq "Enter") {
        if (!(Test-Path "$_spu")) {New-Item -Path "$_sp" -Name "Update" -Type "Directory"}
        for ($i = 0; $i -lt $_u.Count; $i++) {Set-Permission -Path "$_spu" -User $_u[$i] -Permission "FullControl" -Deny -Add}
        New-Item -Path "$_sp" -Name ".update_block" -Type "file"
    }
} else {
    Write-Output "Uninstall Spotify update block? ` [Enter], [Y] - Yes"; $_k = [Console]::ReadKey($true).Key
    if ($_k -eq "Y" -or $_k -eq "Enter") {
        for ($i = 0; $i -lt $_u.Count; $i++) {
        # Set-Permission -Path "$_spu" -User $_u[$i] -Permission "FullControl" -Deny -Del
        Get-ACL "$_sp\User Data" | Set-Acl "$_spu"; Remove-Item "$_sp\.update_block" -Force
        }
    }
}
exit