function Pause {Write-Host -NoNewline "Press any key to continue . . . "; [void][System.Console]::ReadKey($true)}
function Set-Permission {
    param ([string]$Path,[string]$User,[string]$Permission,[switch]$Allow,[switch]$Deny,[switch]$Add,[switch]$Del)
    if ($Allow) {$PermissionType = "Allow"} else {if ($Deny) {$PermissionType = "Deny"} else {return "Error: -Allow or -Deny required"}}; $Acl = Get-Acl "$Path"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$User","$Permission","ContainerInherit,ObjectInherit","None","$PermissionType")
    if ($Add) {$Acl.SetAccessRule($AccessRule); Set-Acl "$Path" $Acl} else {if ($Del) {$Acl.RemoveAccessRule($AccessRule); Set-Acl "$Path" $Acl} else {return "Error: -Add or -Del required"}}
}
$_sp = "$env:LOCALAPPDATA\Spotify"; $_spu = "$_sp\Update"
$_u_a = ((Get-ACL "$_spu").Access | Where-Object {$_.AccessControlType -eq "Allow"}).IdentityReference.Value
$_u_d = ((Get-ACL "$_spu").Access | Where-Object {$_.AccessControlType -eq "Deny"}).IdentityReference.Value
if (!$_u_d) {
    Write-Output "Install Spotify Update Block? ` [Enter], [Y] - Yes"; $_k = [Console]::ReadKey($true).Key
    if ($_k -eq "Y" -or $_k -eq "Enter") {
        if (!(Test-Path "$_spu")) {New-Item -Path "$_sp" -Name "Update" -Type "Directory"}
        for ($i = 0; $i -lt $_u_a.Count; $i++) {Set-Permission -Path "$_spu" -User $_u_a[$i] -Permission "FullControl" -Deny -Add}
        Write-Output "done!"; Pause
    }
} else {
    Write-Output "Uninstall Spotify Update Block? ` [Enter], [Y] - Yes"; $_k = [Console]::ReadKey($true).Key
    if ($_k -eq "Y" -or $_k -eq "Enter") {Get-ACL "$_sp\User Data" | Set-Acl "$_spu"; Write-Output "done!"; Pause}
}
exit