Import-Module ActiveDirectory

$UsersDel = Import-Csv "C:\SCRIPTS\BulkUsersDeletion.csv"

foreach ($User in $UsersDel)
{
Remove-ADUser $User.accountdelete
#Write-Output "$User.Name deleted"
}