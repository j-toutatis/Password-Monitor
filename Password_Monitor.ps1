Connect-MgGraph -Scopes "user.read.all" -NoWelcome


$users = Get-MgUser -All -Property DisplayName, UserPrincipalName, LastPasswordChangeDateTime
$current_Date = Get-Date
foreach ($user in $users){
    $expiry_Date = $($user.LastPasswordChangeDateTime).AddDays(270)
    $warning_Date = $($user.LastPasswordChangeDateTime).AddDays(265)
    if ($expiry_Date -le $current_Date){
        Write-Host "the password for user: '$($user.DisplayName)' has expired. It was set on '$($user.LastPasswordChangeDateTime)'. Email the user at '$($user.UserPrincipalName)' to reset their password."
    }
    elseif ($expiry_Date -le $warning_Date){
        Write-Host "the password for user: '$($user.DisplayName)' will expire on '$warning_Date'"
    }
    else {
        continue
    }
}
