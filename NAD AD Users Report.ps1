$Path = 'C:\SCRIPTS\ADUsers.csv'
Get-ADUser -Filter * -Properties * | Select-Object SamAccountName, Enabled, PasswordExpired, GivenName, surname, EmailAddress, @{n='MemberOf'; e= { ( $_.memberof | % { (Get-ADObject $_).Name }) -join ";" }} | Export-Csv -Path $Path –notypeinformation

