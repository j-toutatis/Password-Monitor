Connect-MgGraph -Scopes "user.read.all"


$users = Get-MgUser -All -Property DisplayName, UserPrincipalName, LastPasswordChangeDateTime
$current_Date = Get-Date
foreach ($user in $users){
    $expiry_Date = $($user.LastPasswordChangeDateTime).AddDays(270)
    if ($expiry_Date -le $current_Date){
        Write-Host "the password for user: '$($user.DisplayName)' has expired. It was set on '$($user.LastPasswordChangeDateTime)'"
    }
    else {
        continue
    }
}
