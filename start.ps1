
## 0xF 0x3 0xC
if ($args[0] -eq '0') {
    Start-Process "C:/Users/hasol/AppData/Roaming/.minecraft/server/start.bat"
} elseif ($args[0] -eq '1') {
    java -Xmx4300M -Xms4300M -Xmn4300M -jar server.jar
    pause
} elseif ($args[0] -eq '2') {
    ForEach ($proc in Get-Process) {
        If ($proc.ProcessName -eq "java") {
            $proc.ProcessorAffinity=0xF
            $proc.PriorityClass="RealTime"
        } Else {
            $proc.ProcessorAffinity=0xC
            If ($proc.ProcessName -eq "explorer") {
                $proc.PriorityClass="BelowNormal"
            }
            #If ($proc.ProcessName -eq "explorer") {
            #    Stop-Process -id $proc.Id
            #}
        }
    }
} else {
    Start-Process ./start.bat
    Start-Sleep -Seconds 20
    Start-Process powershell -Verb RunAs -ArgumentList "-File C:/Users/hasol/AppData/Roaming/.minecraft/server/start.ps1 2"
}