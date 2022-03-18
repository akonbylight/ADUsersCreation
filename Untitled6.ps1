$name = "Security"

$group = $(try {get-aduser $name} catch {$null})

if ($group -ne $null)

{


Write-Host "group exists"
}

else

{


Write-Host "group not exist"
}