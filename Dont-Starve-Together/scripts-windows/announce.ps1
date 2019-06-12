$hookUrl = ''

$output = ps -Name dontstarve_dedicated_server_nullrenderer -ErrorAction SilentlyContinue

$count = $output.Count

$Status = "Don't Starve Together Beta Server"

if ($output) {
    $status = "$status is running!"
}
else {
    $status = "$status is not running!"
}

$version = cat "C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Dedicated Server\version.txt" -ErrorAction SilentlyContinue

if (!$version) {
    $version = "none"
}

$now = Get-Date

$content = @"
$status
Number of DST Server Process: ``$count``
Server has version: ``$version``
**``Server time: $now``**
"@

$payload = [PSCustomObject]@{

    content = $content
    username = 'Server Status'

}

Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json)