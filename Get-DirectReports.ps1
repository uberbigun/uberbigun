<#
Description: Script to get all of the active directory groups for all users reporting to a manager

 Author: Scott Carpenter
 Created: 04/06/2016

 Requires: AD modules for PowerShell and my Module Get-ADDirectReports 

 Parameters: Manager SamAccountName
#>
Param
 (  
  [Parameter(Mandatory=$True)]
  [ValidateNotNull()]
  $myManager
  )
import-module Get-ADDirectReport.psm1
 
$reports = Get-ADDirectReports -Identity $myManager -Recurse 
$nl = [Environment]::NewLine
foreach ($name in $reports.SamAccountname)
{
    write-host $nl
    write-host $name
    $groups = Get-ADPrincipalGroupMembership $name 
    foreach ($group in $groups.name)
    {
        write-host $group
    }
}
