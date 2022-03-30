
# Accepts the name of a csv file with the users that need to be created in AD
# This file must have the following headers:
# * Username   This is the username that the user will login with (we should have a standard (first.last; firstInitialLastName; etc) 
# * Password   This is the user's initial password and it will need to be set to need changing upon initial login
# * Firstname  This is the user's first name 
# * Lastname   This is the user's last name
# * Groups     This is a delimited set of groups that the user should be added to. If we use commas the field will need to be quoted in the csv. If we choose semicolons quoting may not be required
#                for example this could contain "non-ato-engineer-users, workspaces, dev" as three groups to add the user to.
param (
    [string]$csvADUsersToCreate = "C:\SCRIPTS\USPTO-Integration-Jouve team members.csv"
)

#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory

#Store the data from ADUsers.csv in the $ADUsers variables
$ADUsers = Import-csv $csvADUsersToCreate

#Loop through each row containing user details in the csv file
foreach ($User in $ADUsers)
{
    #Read user data from each field in each row and assign the data to a variable as below

    $Username   = $User.Username
    #$Name       = $User.Name
    $Password   = $User.Password
    $Firstname  = $User.Firstname
    $Lastname   = $User.Lastname
    $Groups     = $User.Groups -split","
    $Email   = $User.Email

   Write-Output "username $username"
   Write-Output "password $password"
   Write-Output "firstname $firstname"
   Write-Output "lastname $lastname"
   Write-Output "Groups $Groups"
   Write-Output "Email $Email"
 
    #Check to see if the user already exist in the AD
    if (Get-ADUser -F {SamAccountName -eq $Username})
    {
        #If user does exist, give a warning
        Write-Warning "A user with username $Username already exist in the Active Directory."
    }
    else
    {
        #User does not exist then proceed to create the new user account
        
# ADD Error handling in case the New-ADUser fails 
$ErrorActionPreference       
        #Account will be created in the User's OU
        New-ADUser `
             -Name $Username `
             -Email $Email `
             -GivenName $Firstname `
             -Surname $Lastname `
             -Enabled $True `
             -DisplayName "$Lastname, $Firstname" `
             -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
             -ChangePasswordAtLogon $True
 
# Write a success or failure message
        Write-output "$Username Created"
            
            
        # IF the above New-ADUser succeeds, Parse the $group and loop over each one to add the user to that group
        # think => foreach ($Group in $Groups) ( ... )
		foreach ($group in $Groups){
		Write-Output "$User $Group"
        # Include error handling        
           Add-ADPrincipalGroupMembership -Identity $Username -MemberOf $group
# Write a success or failure message
          Write-output "$Username added to group $group"      
        
    }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
   }
}