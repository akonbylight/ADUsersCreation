Import-Module ActiveDirectory

$UsersDel = Import-Csv "C:\SCRIPTS\Jouve_DeleteUsers.csv"

foreach ($User in $UsersDel)
{
Remove-ADUser $User.accountdelete
#Write-Output "$User.Name deleted"
}