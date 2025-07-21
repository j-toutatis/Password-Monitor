Connect-MgGraph -Scopes "user.read.all" -NoWelcome


$users = Get-MgUser -All -Property DisplayName, UserPrincipalName, LastPasswordChangeDateTime
$current_Date = Get-Date
$total_Expired = 0
$total_Warning = 0
foreach ($user in $users){
    $expiry_Date = $($user.LastPasswordChangeDateTime).AddDays(270)
    $warning_Date = $($user.LastPasswordChangeDateTime).AddDays(265)
    if ($expiry_Date -le $current_Date){
        Write-Host "the password for user: '$($user.DisplayName)' has expired. It was set on '$($user.LastPasswordChangeDateTime)'. Email the user at '$($user.UserPrincipalName)' to reset their password."
        $total_Expired++
    }
    elseif ($warning_Date -le $current_Date){
        Write-Host "the password for user: '$($user.DisplayName)' will expire on '$expiry_Date'"
        $total_Warning++
    }
    else {
        continue
    }
}
Write-Host "Total expired passwords: $total_Expired"
Write-Host "Total passwords approaching expiry: $total_Warning"
