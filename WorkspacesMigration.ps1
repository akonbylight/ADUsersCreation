
# Accepts the name of a csv file with the users that need to be created in AD
# This file must have the following headers:
# * Username   This is the username that the user will login with (we should have a standard (first.last; firstInitialLastName; etc) 
# * Password   This is the user's initial password and it will need to be set to need changing upon initial login
# * Firstname  This is the user's first name 
# * Lastname   This is the user's last name
# * Groups     This is a delimited set of groups that the user should be added to. If we use commas the field will need to be quoted in the csv. If we choose semicolons quoting may not be required
#                for example this could contain "non-ato-engineer-users, workspaces, dev" as three groups to add the user to.
param (
    [string]$csvWorkspaces = "C:\SCRIPTS\workspaces-nab-1.csv"
)

#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory

#Store the data from ADUsers.csv in the $ADUsers variables
$Workspaces = Import-csv $csvWorkspaces

#Loop through each row containing user details in the csv file
foreach ($Workspace in $Workspaces)
{
    #Read user data from each field in each row and assign the data to a variable as below

    $Number        = $Workspace.Number
    $IPAddress     = $Workspace.IPAddress
    $Directory     = $Workspace.Directory
    $WorkspaceId   = $Workspace.WorkspaceId
    $Username      = $Workspace.Username

   Write-Output "$Number. $WorkspaceId $Directory $IPAddress $Username "

   aws cli migrate-workspace --source-workspace-id $WorkspaceId --bundle-id wsb-cbbbtf3gn 
}