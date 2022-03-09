#Import active directory module for running AD cmdlets
Import-Module ActiveDirectory

#Store the data from ADUsers.csv in the $ADUsers variables
$ADUsers = Import-csv C:\SCRIPTS\sample-csv-user-creation.csv

#Loop through each row containing user details in the csv file
foreach ($User in $ADUsers)
{
    #Read user data from each field in each row and assign the data to a variable as below

    $Username   = $User.Username
  # $Name       = $User.Name
    $Password   = $User.Password
    $Firstname  = $User.Firstname
    $Lastname   = $User.Lastname
    $OU         = $User.OU
    $group =    $User.Group

   Write-Output "username $username"
 # Write-Output "username $name"
   Write-Output "password $password"
   Write-Output "firstname $firstname"
   Write-Output "lastname $lastname"
   Write-Output "OU $OU"
   Write-Output group $group -split";"
 
    #Check to see if the user already exist in the AD
    if (Get-ADUser -F {SamAccountName -eq $Username})
    {
        #If user does exist, give a warning
        Write-Warning "A user with username $Username already exist in the Active Directory."
    }
    else
    {
        #User does not exist then proceed to create the new user account
        Write-output "A user with username $Username does not exist and will be created."

        #Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser `
             -Name "$username" `
             -GivenName $Firstname `
             -Surname $Lastname `
             -Enabled $True `
             -DisplayName "$Lastname, $Firstname" `
             -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
             -ChangePasswordAtLogon $True
            #-UserPrincipalName "$Username@pddm.fscedge.com" `
            #-Path "$OU" `
              #-UserName $Username `
            # -Department $Department `
            Add-ADPrincipalGroupMembership -Identity $Username -MemberOf $group

         #If the group attribute in csv file is blank, remove the user from AD
    if ([string]::IsNullOrWhiteSpace($groups))
    {
        Remove-ADUser -Identity $Username -Confirm:$false
        Write-Output "$Username has no groups, removing from directory or simply not adding"
    }

    else
    {
    #Check to see if the user already exists in AD
    #if (Get-ADUser -F {Username -eq $Username})
     }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    }
}