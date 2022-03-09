#$names = @( "RZoul", "EHadj", "Steph" )

$names = Get-Content "C:\SCRIPTS\test.csv"

foreach ($name in $names)

{
$user = $(try {get-aduser $name} catch {$null})

if ($user -ne $null)

{


Write-Host "$name user exists"
}

else

{


Write-Host "$name user not exist"
}

}