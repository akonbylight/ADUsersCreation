
# Accepts the name of a csv file with the Groups that need to be created in AD
# This file must have the following headers:
# * Groupname   This is the Groupname that the Group will login with (we should have a standard (first.last; firstInitialLastName; etc) 
# * Password   This is the Group's initial password and it will need to be set to need changing upon initial login
# * Firstname  This is the Group's first name 
# * Lastname   This is the Group's last name
# * Groups     This is a delimited set of groups that the Group should be added to. If we use commas the field will need to be quoted in the csv. If we choose semicolons quoting may not be required
#                for example this could contain "non-ato-engineer-Groups, workspaces, dev" as three groups to add the Group to.
param (
    [string]$csvADGroupsToCreate = "C:\SCRIPTS\NewGroups.csv"
)

#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory

#Store the data from ADGroups.csv in the $ADGroups variables
$ADGroups = Import-csv $csvADGroupsToCreate

#Loop through each row containing Group details in the csv file
foreach ($Group in $ADGroups)
{
    #Read Group data from each field in each row and assign the data to a variable as below

    $Groupname   = $Group.Groupname
    $Description   = $Group.Description
    $Path         = $Group.Path

   Write-Output "Groupname $Groupname"
 # Write-Output "Groupname $name"
   Write-Output "password $password"
   Write-Output "firstname $firstname"
   Write-Output "lastname $lastname"
   Write-Output "OU $OU"
   Write-Output "Groups $Groups"
 
    #Check to see if the Group already exist in the AD
    if (Get-ADGroup -F {Identity -eq $Groupname})
    {
        #If Group does exist, give a warning
        Write-Warning "A Group with Groupname $Groupname already exist in the Active Directory."
    }
    else
    {
        #Group does not exist then proceed to create the new Group account
        
# ADD Error handling in case the New-ADGroup fails 
$ErrorActionPreference       
        #Account will be created in the Group's OU
        New-ADGroup `
             -Name $Groupname `
             -Description $Description `
             -Path $Path `
             -Groupscope "Global" 
            
# Write a success or failure message
        Write-output "$Groupname Created"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
   }
}