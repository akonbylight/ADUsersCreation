Import-Module ActiveDirectory

$GroupsDel = Import-Csv "C:\SCRIPTS\groupdeletion.csv" 

foreach ($User in $GroupsDel)
{
Remove-ADGroup $Group.accountdelete
#Write-Output "$Group.Name deleted"
}