$hookUrl = ""
$payload = [PSCustomObject]@{
    content = $args[0]
    username = "Server Status"
}
Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'
