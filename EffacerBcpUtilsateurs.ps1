Import-Module ActiveDirectory

$UsersDel = Import-Csv "C:\SCRIPTS\DeleteNAB Add Users Workspace Clean Name Convention 20220305.csv" 

foreach ($User in $UsersDel)
{
Remove-ADUser $User.accountdelete
Write-Output "$User.Name deleted"
}